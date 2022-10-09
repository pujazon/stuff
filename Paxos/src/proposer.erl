-module(proposer).
-export([start/6]).
-define(timeout, 100). %If not received messages on 0.3 s, abort
-define(backoff, 10). %Begin new round after 0.01 s. So many rounds

start(Name, Proposal, Acceptors, Sleep, PanelId, Main) ->
spawn(fun() -> init(Name, Proposal, Acceptors, Sleep, PanelId, Main) end).
init(Name, Proposal, Acceptors, Sleep, PanelId, Main) ->
timer:sleep(Sleep),
Begin = erlang:monotonic_time(),
Round = order:first(Name),

{Decision, LastRound} = round(Name, ?backoff, Round, Proposal, Acceptors, PanelId),
End = erlang:monotonic_time(),
Elapsed = erlang:convert_time_unit(End-Begin, native, millisecond),
io:format("[Proposer ~w] DECIDED ~w in round ~w after ~w ms~n",
[Name, Decision, LastRound, Elapsed]),

Main ! done,
PanelId ! stop.

round(Name, Backoff, Round, Proposal, Acceptors, PanelId) ->
io:format("[Proposer ~w] Phase 1: round ~w proposal ~w~n",
[Name, Round, Proposal]),
% Update gui
PanelId ! {updateProp, "Round: " ++ io_lib:format("~p", [Round]), Proposal},
case ballot(Name, Round, Proposal, Acceptors, PanelId) of
{ok, Value} ->
{Value, Round};
abort ->
timer:sleep(rand:uniform(Backoff)),
Next = order:inc(Round),
io:format("[DBG] Next ~w})\n", [Next]),
round(Name, (2*Backoff), Next, Proposal, Acceptors, PanelId)
end.

ballot(Name, Round, Proposal, Acceptors, PanelId) ->
prepare(Round, Acceptors),
%Quorum here is understood as the mean +1, majority
Quorum = (length(Acceptors) div 2) + 1,
MaxVoted = order:null(),
case collect(Quorum, Round, MaxVoted, Proposal) of
{accepted, Value} ->
io:format("[Proposer ~w] Phase 2: round ~w proposal ~w (was ~w)~n",
[Name, Round, Proposal, Value]),
% update gui
Colour = case Value of na -> {0,0,0}; _ -> Value end,
PanelId ! {updateProp, "Round: " ++ io_lib:format("~p", [Round]), Colour},
accept(Round, Proposal, Acceptors),
case vote(Quorum, Round) of
ok ->
{ok, Proposal};
abort ->
abort
end;
abort ->
abort
end.

collect(0, _, _, Proposal) ->
io:format("[DBG] collect(0, _, _, Proposal) = ~w) OK. END \n", [Proposal]),
{accepted, Proposal};

collect(N, Round, MaxVoted, Proposal) ->
io:format("[DBG] collect(N = ~w, Round = ~w, MaxVoted = ~w, Proposal = ~w) -> \n", [N, Round, MaxVoted, Proposal]),
receive
{promise, Round, _, na} ->
io:format("[DBG] Received {promise, Round = ~w, _, na} -> (MaxVoted = ~w) \n", [Round, MaxVoted]),
io:format("[DBG] Send collect(N = ~w, Round = ~w, MaxVoted = ~w, Proposal = ~w) -> \n", [N - 1, Round, MaxVoted, Proposal]),
collect(N - 1, Round, MaxVoted, na);

{promise, Round, Voted, Value} ->
io:format("[DBG] Received {promise(Round = ~w, Voted = ~w, Value = ~w) -> \n", [Round, Voted, Value]),
case order:gr(Voted, MaxVoted) of
true ->
io:format("[DBG] Send collect(N = ~w, Round = ~w, Voted = ~w, Value = ~w) -> \n", [N - 1, Round, Voted, Value]),
collect(N - 1, Round, Voted, Value);
false ->
io:format("[DBG] Send collect(N = ~w, Round = ~w, MaxVoted = ~w, Proposal = ~w) -> \n", [N - 1, Round, MaxVoted, Proposal]),
collect(N - 1, Round, MaxVoted, Proposal)
end;

{promise, _, _, _} ->
io:format("[DBG] {promise, _, _, _} -> \n"),
io:format("[DBG] Send collect(N = ~w, Round = ~w, Voted = ~w, Value = ~w) -> \n", [N, Round, MaxVoted, Proposal]),
collect(N, Round, MaxVoted, Proposal);

{sorry, {prepare, Round}} ->
%If we recieved a sorry, we cannot --N, as it means we have received
collect(N, Round, MaxVoted, Proposal);

%Then all the other potential sorry messages. The accept ones, for vote
{sorry, _} ->
collect(N, Round, MaxVoted, Proposal)
after ?timeout ->
abort
end.

vote(0, _) ->
ok;
vote(N, Round) ->
io:format("[DBG] vote(N = ~w, Round = ~w) -> \n", [N, Round]),
receive
{vote, Round} ->
io:format("[DBG] recevied vote(Round = ~w) -> \n", [Round]),
vote(N - 1, Round);
{vote, _} ->
io:format("[DBG] recevied vote(_) -> \n"),
vote(N, Round);
{sorry, {accept, Round}} ->
io:format("[DBG] recevied sorry, {accept, Round = ~w} -> \n", [Round]),
vote(N, Round);
{sorry, _} ->
vote(N, Round)
after ?timeout ->
abort
end.

prepare(Round, Acceptors) ->
Fun = fun(Acceptor) ->
io:format("[DBG] send(~w, {prepare, ~w, ~w})\n", [Acceptor, self(), Round]),
send(Acceptor, {prepare, self(), Round})
end,
lists:foreach(Fun, Acceptors).
accept(Round, Proposal, Acceptors) ->
Fun = fun(Acceptor) ->
send(Acceptor, {accept, self(), Round, Proposal})
end,
lists:foreach(Fun, Acceptors).

send(Name, Message) ->
Name ! Message.