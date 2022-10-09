-module(acceptor).
-export([start/2]).
-define(delay, 320).
-define(dropProposals, 0).
-define(dropVotes, 0).

start(Name, PanelId) ->
spawn(fun() -> init(Name, PanelId) end).

init(Name, PanelId) ->
Promised = order:null(),
Voted = order:null(),
Value = na,
acceptor(Name, Promised, Voted, Value, PanelId).

acceptor(Name, Promised, Voted, Value, PanelId) ->
receive
{prepare, Proposer, Round} ->
io:format("[DBG] Acceptor [~w, Promised = ~w] recv: {prepare, Proposer = ~w, Round = ~w} \n", [Name, Promised, Proposer, Round]),
case order:gr(Round, Promised) of
true ->

P = rand:uniform(10),
if P =< ?dropProposals ->
io:format("[DBG] Dropped Promise from ~w to ~w ~n", [Name, Proposer]);
true ->

T1 = rand:uniform(?delay),
io:format("[DBG] Delay of ~w sec for Promise. \n", [T1]),
timer:send_after(T1, Proposer, {promise, Round, Voted, Value}),

%Comment as it's sent with delay on the above statement
%Proposer ! {promise, Round, Voted, Value},
io:format("[Acceptor ~w] Phase 1: promised ~w voted ~w colour ~w~n",
[Name, Round, Voted, Value]),
% Update gui
Colour = case Value of na -> {0,0,0}; _ -> Value end,
PanelId ! {updateAcc, "Voted: " ++ io_lib:format("~p", [Voted]),
"Promised: " ++ io_lib:format("~p", [Round]), Colour}
end,

acceptor(Name, Round, Voted, Value, PanelId);

false ->
io:format("[DBG] Acceptor [~w] Sorry!, I won't promise round ~w, I promised ~w \n", [Name, Round, Promised]),
%Proposer ! {sorry, {prepare, Round}},
acceptor(Name, Promised, Voted, Value, PanelId)
end;

{accept, Proposer, Round, Proposal} ->
io:format("[DBG] {accept, ~w, ~w, ~w}:: Voted: ~w \n", [Proposer, Round, Proposal, Voted]),
case order:goe(Round, Promised) of
true ->

P = rand:uniform(10),
if P =< ?dropVotes ->
io:format("[DBG] Dropped Vote from ~w to ~w ~n", [Name, Proposer]);
true ->
io:format("[DBG] Proposer ! {vote, Round = ~w} \n", [Round]),

T = rand:uniform(?delay),
io:format("[DBG] Delay of ~w sec for Vote(). \n", [T]),
timer:send_after(T, Proposer, {vote, Round})

%Proposer ! {vote, Round},
end,


case order:goe(Round, Voted) of
true ->
io:format("[Acceptor ~w] Phase 2: promised ~w voted ~w colour ~w~n",
[Name, Promised, Round, Proposal]),
% Update gui
PanelId ! {updateAcc, "Voted: " ++ io_lib:format("~p", [Round]),
"Promised: " ++ io_lib:format("~p", [Promised]), Proposal},
acceptor(Name, Promised, Round, Proposal, PanelId);
false ->
acceptor(Name, Promised, Voted, Value, PanelId)
end;
false ->
%Proposer ! {sorry, {accept, Round}},
acceptor(Name, Promised, Voted, Value, PanelId)
end;

stop ->
PanelId ! stop,
ok
end.