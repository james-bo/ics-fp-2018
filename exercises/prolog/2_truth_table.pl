% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)

and(A, B) :- A, B.
or(A, B) :- A; B.
not(A) :- \+A.
equ(A, B) :- A = B.
xor(A, B) :- and(A, not(B)); and(B, not(A)).
equ(A, B) :- not(xor(A, B)).


evaluate(Expr, true) :- Expr, !.
evaluate(_, fail).

truth_table(A, B, Expr) :- bool(A), bool(B), evaluate(Expr, Res), writef('%t %t %t\n', [A, B, Res]), fail.
truth_table(_, _, _).

% truth_table(A, B, equ(not(A), B)).
% true true fail
% true fail true
% fail true true
% fail fail fail

