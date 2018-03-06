mov(1, 2).
mov(1, 3).
mov(1, 4).
mov(2, 5).
mov(2, 6).
mov(2, 7).
mov(3, 8).
mov(3, 9).
mov(3, 10).
mov(3, 6).
mov(4, 5).
mov(4, 7).
mov(4, 11).
mov(4, 9).
mov(7, 8).
mov(7, 10).
mov(8, 9).


member(X,[X|_]).
member(X,[_|T]):-member(X,T).

empty_stack([]).

    % member_stack tests if an element is a member of a stack

member_stack(E, S) :- member(E, S).

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

path(State, Goal, Been_list, D) :-
  D > 0,
	mov(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list), %push
	path(Next, Goal, New_been_list, D - 1), !.

reverse_print_stack(S) :-
	empty_stack(S).

reverse_print_stack(S) :-
	stack(E, Rest, S), %pop
	reverse_print_stack(Rest),
	write(E), nl.
