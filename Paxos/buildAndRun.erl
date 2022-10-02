-module(buildAndRun).
-export([buildAndRun/0]).

buildAndRun () ->
c(acceptor),
c(proposer),
c(gui),
c(paxy),
paxy:start([3000,6000,9000]).



