% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)

and(A, B) :- A, B.
or(A, B) :- (A; B), !.
not(A) :- \+ A.
equ(A, B) :- (and(A, B); not(or(A, B))), !.
xor(A, B) :- not(equ(A, B)).

bool(true).
bool(false).

eval(E,false) :- not(E).
eval(E,true) :- E.

truth_table(A, B, E) :- forall((bool(A), bool(B)), (write(A), write("\t"), write(B), write("\t"), eval(E, R), write(R), nl)).

% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

% truth_table(A,B,and(A,or(A,B))).
% true	true	true
% true	false	true
% false	true	false
% false	false	false

% truth_table(A,B,and(A,B)).
% true	true	true
% true	false	false
% false	true	false
% false	false	false

% truth_table(A,B,or(A,B)).
% true	true	true
% true	false	true
% false	true	true
% false	false

% truth_table(A,B,xor(A,B)).
% true	true	false
% true	false	true
% false	true	true
% false	false	