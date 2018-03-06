/*   Lab3 prolog    */
/* IDF & merge sort */
/* Javier Rodriguez */
/*    A01152572     */

/*IDFS*/
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


member(X,[X|_]).
member(X,[_|T]):-member(X,T).

empty_stack([]).

member_stack(E, S) :- member(E, S).

stack(E, S, [E|S]).

% depth search %

% Count will limit the iterations of our search
go(Start, Goal, Count) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list), %push
	path(Start, Goal, Been_list, Count).


path(Goal, Goal, Been_list, Count) :-
	reverse_print_stack(Been_list).

% while count is bigger than cero continue with the search
path(State, Goal, Been_list, Count) :-
  Count > 0,
	road(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list), %push
  CountTemp is Count - 1,
	path(Next, Goal, New_been_list, CountTemp), !.

reverse_print_stack(S) :-
	empty_stack(S).

reverse_print_stack(S) :-
	stack(E, Rest, S), %pop
	reverse_print_stack(Rest),
	write(E), nl.



/*Merge sort, from the class example*/
merge_sort([], []).
merge_sort([X], [X]).

merge_sort(List, Sorted):-
    List = [_,_|_],
    divide(List, L1, L2),
    merge_sort(L1, Sorted1),
    merge_sort(L2, Sorted2),
    merge(Sorted1, Sorted2, Sorted).

divide(L, L1, L2):-
    hv(L, [], L1, L2).

% hv function takes the original list(or modified if it has iterated previously), An accumulator, which is made of the Tail of the list which will be called recusively, a new list L, and a new list B
hv(L, L, [], L).
hv(L, [_|L], [], L).
hv([H|T], Acc, [H|L], B):-
    hv(T, [_|Acc], L, B).
%The function calls itself to  create the two lists by separating the head and the tail until it´s in the half

%stop conditions
merge([], L, L).
merge(L, [], L):- L \=[].

%if head of list one is smaller or equal than the head of list two, add the head of list one to to the new sorted list
merge([X|T1], [Y|T2], [X|T]):-
    X =< Y,
    merge(T1, [Y|T2], T).

%if head of list one is bigger than the head of list two, add the head ot listtwo to the new sorted list
merge([X|T1], [Y|T2], [Y|T]):-
    X > Y,
    merge([X|T1], T2, T).
