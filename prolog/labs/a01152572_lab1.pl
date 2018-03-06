/*After doing this lab you should be able to understand how to represent facts and graphs in a logic programming language.
		 You should also grasp how Prolog’s basic operations work.*/

/* Define a predicate “compatible(X,Y)”.
 We say that X and Y are compatible if they share at least 1 hobby.*/



hobby(juan,kaggle). 
hobby(luis,hack). 
hobby(elena,tennis). 
hobby(midori,videogame). 
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame). 

compatible(X, Y):-
    hobby(X,Z),
    hobby(Y,Z).

/*Define the rule can_get_to(Origin, Destination) which is true if there is a path that starts in Origin and following the directionality of the roads can get to Destination.
can_get_to(lilibeum, capua)  is true,
can_get_to(roma, pisae)  is false.
Define the predicate size(X, Y, Z) which returns in Z the number of cities crossed in the path from X to Y. */

	road(placentia, ariminum).
	road(ariminum, ancona).
	road(pisae,roma).
	road(capua,roma).
	road(ancona, roma).
	road(messana, capua).
	road(catina, rhegium).
	road(brundisium,capua).
	road(syracusae,catina).
	road(lilibeum,messana).
	road(messana,capua).
	road(rhegium,capua).
	road(ancona,roma).
	road(castrum,roma).
	road(arimium,roma).

	can_get_to(Destination, Destination):-!.
	can_get_to(Origin, Destination):-
		road(Origin, X),
		can_get_to(X, Destination).


	size(Destination, Destination, 1).
  size(X,Y,Z):-
		road(X, Temp),
		size(Temp, Y, Z1),
		Z is Z1 + 1 .


	min(A,B,C,Z):-
		A >= B,
		A >= C,
		Z is A;
		B >= C,
		B > A,
		Z is B;
		C > B,
		C > A,
		Z is C.

/* function gcd(a, b)
    if b = 0
       return a;
    else
       return gcd(b, a mod b); */

	gcd(G, 0, G).
	gcd(A, B, G):-
		Temp is mod(A, B),
		gcd(A, Temp, G).
