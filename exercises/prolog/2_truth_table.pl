% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)
and(A,B):- A,B.
or(A,B):- A; B.
not(A):- \+A.
equ(A,B):- A = B.
xor(A,B):- not(equ(A, B)).

bool(true).
bool(false).

evaluate(E,true) :- E.
evaluate(E,false) :- not(E).

print_headers(X,Y,R) :- write(' '), write(X), write('       '), write(Y), write('      '), write(R),nl.
truth_table(A, B, E) :- forall((bool(A), bool(B)), (write(A), write("\t"), write(B), write("\t"), evaluate(E, R), write(R),nl)).

% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности
:- print_headers('A','B','OR').
:- truth_table(A,B,or(A,B)).
% A       B      OR
%true    true    true
%true    false   true
%false   true    true
%false   false   false

:- print_headers('A','B','AND&OR').
:- truth_table(A,B,and(A,or(A,B))).
% A       B      AND&OR
%true    true    true
%true    false   true
%false   true    false
%false   false   false

:- print_headers('A','B','XOR').
:- truth_table(A,B,xor(A,B)).
% A       B      XOR
%true    true    false
%true    false   true
%false   true    true
%false   false   false
