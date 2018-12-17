% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)?
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail
%
and(A, B) :- A, B.

or(A,B) :- A; B.

xor(A, B):- not(A),B; not(B),A.

equ(A,B) :- A=B.

not1(A) :- A=false.

trueOrFalse(X) :- X=true.
trueOrFalse(X) :- X=false.


exec(Expression) :- call(Expression), writeln("true"), !.
exec(_) :- writeln("false"), !.


truth_table(A,B,Expression) :- trueOrFalse(A), trueOrFalse(B), write(A), write(" "), write(B), write(" "), exec(Expression), false.
truth_table(_,_,_) :- true.
