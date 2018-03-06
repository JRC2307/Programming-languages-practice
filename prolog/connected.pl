connect(1,3).
connect(1,4).
connect(3,5).
connect(4,5).

is_connected(X,Y):-
	connect(X,Y).
is_connected(X,Y):-
	connect(X,Z),!,
	is_connected(Z,Y).

