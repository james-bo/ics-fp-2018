% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

and(A,B):- A, B.
or(A,B):- A | B.
xor(A,B):- (A,not(B)) | (not(A),B).
equ(A,B):- A = B.
not(A):- \+A.

bool(true).
bool(false).

exec(Exp, true) :- Exp.
exec(Exp, false):- not(Exp).

truth_table(A, B, Exp) :- forall(
   (bool(A), bool(B)),
   (exec(Exp, Res), format("~w\t~w\t~w\n", [A, B, Res]))).

% RESULT:    ?- truth_table(A, B, and(not(A), B)).
%            true    true    false
%            true    false   false
%            false   true    true
%            false   false   false