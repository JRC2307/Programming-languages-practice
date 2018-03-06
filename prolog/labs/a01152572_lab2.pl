/* Lab2 prolog */
/*    lists     */
/* Javier Rodriguez */
/* A01152572 */

/* Any Positive */
/* ?- any_positive ([-1,-2,3,-4]).  */
/* true.  */
any_positive([H|_]):-
H > 0.
any_positive([_|T]):-
 any_positive(T).


/* Substitute.  */
/* ?- substitute(2, 3, [1, 2, 2, 2, 3, 2], X).  */
/* X = [1, 3, 3, 3, 3, 3]  */
substitute(_,_,[],[]).

substitute(A,B,[A|L1],[B|L2]):-
    substitute(A,B,L1,L2).

substitute(A,B,[H|L1],[H|L2]):-
    substitute(A,B,L1,L2).


/* Eiminate duplicates.  */
/* ?- eliminate_duplicates ([a, a, a, a, b, c, c, a, a, d, e, e, e, e],X).  */
/* X = [a, b, c, d, e]  */
%eliminate_duplicates([],[]).
%eliminate_duplicates():-



/* Intersect.  */
/* ?- intersect ([a, b, c, d], [b, d, e, f], X).  */
/* X = [b, d]  */


/* Invert.  */
/* ?- invert([a, b, e, c, e],X).  */
/* X = [e, c, e, b, a]  */

%append function as seen on the prolog list tutorials
%http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/lists.html

append([],L,L).
append([H|T],L2,[H|Res]):-
    append(T,L2,Res).

invert([X],[X]).
invert([H|T],X):-
  invert(T,NE),
  append(NE,[H],X).

/* Less than.  */
/* ?- less_then(5, [1, 6, 5, 2, 7], X).  */
/* X = [1, 2]  */
%pivot(H,[X|T],L,[X|G]):-
% X>H,
%pivot(H,T,L,G).

less_then(_,[],[]).
less_then(X,[H|T],[H|T2]):-
X>H,
  less_then(X,T,T2).
less_then(X,[_|T],T2):-
  less_then(X,T,T2).

/* More than (or equal).  */
/* ?- more_than(5, [1, 6, 5, 2, 7], X).  */
/* X = [6, 5, 7]  */
%Same as the less_then function but inverted
more_than(_,[],[]).
more_than(X,[H|T],[H|T2]):-
X=<H,
  more_than(X,T,T2).
more_than(X,[_|T],T2):-
  more_than(X,T,T2).

/* quicksort.  */
/* ?- quicksort([1, 6, 5, 2, 7], X).  */
/* X = [1, 2, 5, 6, 7]  */
quicksort([],[]).
quicksort([H|T],S):-
	less_then(H,T,L1),
  more_than(H,T,L2),
  quicksort(L1,S1),
  quicksort(L2,S2),
	append(S1,[H|S2],S).

/* rotate.  */
/* ?- rotate([1, 6, 5, 2, 7], 3, X).  */
/* X = [2, 7, 1, 6, 5]  */
/* ?- rotate([1, 6, 5, 2, 7], -3, X).  */
/* X = [5, 2, 7, 1, 6]  */


/* dfs rome for extra points */
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


size(X,[X|_]).
size(X,[_|T]):-size(X,T).

empty_stack([]).

    % size_stack tests if an element is a size of a stack

size_stack(E, S) :- size(E, S).

    % stack performs the push, pop and peek operations
    % to push an element onto the stack
        % ?- stack(a, [b,c,d], S).
    %    S = [a,b,c,d]
    % To pop an element from the stack
    % ?- stack(Top, Rest, [a,b,c]).
    %    Top = a, Rest = [b,c]
    % To peek at the top element on the stack
    % ?- stack(Top, _, [a,b,c]).
    %    Top = a

stack(E, S, [E|S]).

% depth search %

go(Start, Goal) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list), %push
	path(Start, Goal, Been_list).

	% path implements a depth first search in PROLOG

	% Current state = goal, print out been list
path(Goal, Goal, Been_list) :-
	reverse_print_stack(Been_list).

path(State, Goal, Been_list) :-
	road(State, Next),
	% not(unsafe(Next)),
	not(size_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list), %push
	path(Next, Goal, New_been_list), !.

reverse_print_stack(S) :-
	empty_stack(S).

reverse_print_stack(S) :-
	stack(E, Rest, S), %pop
	reverse_print_stack(Rest),
	write(E), nl.
