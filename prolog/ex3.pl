
/* counter*/
count(0).

count(X):-
    NewX is X - 1,
    count(NewX).


/*acumulator*/

	get_value(0,0):-!.

get_value(Count, Res):-
    NewCount is Count -1,
    get_value(NewCount, TempRes),
    Res is TempRes + 1 .

/* Head recursion 25 secs */

factorial(1, 1):-!.

factorial(X, Res):-
    NewX is X -1,
    factorial(NewX, NewRes),
    Res is NewRes*X.

/* Tail recursion */

facotrialTail(1,Res,Res):-!.
    NewX is X-1,
    NewTemp is Temp*X,
    factorialtail(NewX, Res, NewTemp).

