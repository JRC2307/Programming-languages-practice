dad(billy, bob).
dad(bob, sue).
dad(bob, alex).
dad(alex, john).
dad(john, pete).
dad(pete, jack).
mom(ana, erika).
mom(erika, sue).
mom(sue, sussy).
mom(ana,billy).

grandParent(X,Y):-
    dad(X, Z),
    dad(Z, Y).

grandPapi(X, Y):-
    mom(X, Z),
    mom(Y, Z).


/* using or and
grandparent(X, Y):-
    dad(X, Y),
	(dad (Z, Y);
	(mom (Z, Y)),
    mom(X, Y),
	(dad (Z, Y);
	(mom (Z, Y)).
 */


/* find child */
child(Mom, Dad, Kid):-
    mom(Mom,Kid),
    dad(Dad,Kid).


/* find ancestor */
parent(X, Y):-
    mom(X, Y);
    dad(X, Y).

ancestor(X, Y):- 	/* recusion */
    parent(X,Y).

ancestor(X,Y):-
	    ancestor(Y,_Z).
