-module(acceptor).
-export([start/2]).
-define(delay, 200).

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

T = rand:uniform(?delay),
timer:send_after(T, Proposer, {promise, Round, Voted, Value}),

Proposer ! {promise, Round, Voted, Value},
io:format("[Acceptor ~w] Phase 1: promised ~w voted ~w colour ~w~n",
[Name, Round, Voted, Value]),
% Update gui
Colour = case Value of na -> {0,0,0}; _ -> Value end,
PanelId ! {updateAcc, "Voted: " ++ io_lib:format("~p", [Voted]),
"Promised: " ++ io_lib:format("~p", [Round]), Colour},
acceptor(Name, Round, Voted, Value, PanelId);
false ->
io:format("[DBG] Acceptor [~w] Sorry!, I won't promise round ~w, I promised ~w \n", [Name, Round, Promised]),
Proposer ! {sorry, {prepare, Round}},
acceptor(Name, Promised, Voted, Value, PanelId)
end;

{accept, Proposer, Round, Proposal} ->
io:format("[DBG] {accept, ~w, ~w, ~w}:: Voted: ~w \n", [Proposer, Round, Proposal, Voted]),
case order:goe(Round, Promised) of
true ->
io:format("[DBG] Proposer ! {vote, Round = ~w} \n", [Round]),
Proposer ! {vote, Round},
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
Proposer ! {sorry, {accept, Round}},
acceptor(Name, Promised, Voted, Value, PanelId)
end;

stop ->
PanelId ! stop,
ok
end.