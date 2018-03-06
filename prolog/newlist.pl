list([1,2,3,4,5,76,83])

prog(X,Z):-
  list(X),
  sumElements(X,Z).

SumElements([],0).

sumeElements([H|T], Res):-
  sumElements(T,NewRes),
  Res is NewRes + H.
