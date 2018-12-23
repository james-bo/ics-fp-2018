% определить предикаты:
	% and(A,B)
	% or(A,B)
	% xor(A,B)
	% not(A)
	% equ(A,B)

and(A,B) :- A , B.
or(A,B) :- A ; B.
redefine_system_predicate(not(A)) :- \+A.
equ(A,B) :- A = B.
xor(A,B) :- not(equ(A,B)).


% ипользовать предикат truth_table(A, B, expression) для построения таблиц истинности, например:
	% truth_table(A, B, and(A, or(A, B))).
		% true true true
		% true fail true
		% fail true fail
		% fail fail fail

is(true).
is(false).

evaluateExpression(Expression) :- call(Expression), writeln("true"), !.
evaluateExpression(_) :- writeln("false"), !.

truth_table(A, B, Expression) :- is(A), is(B), write(A), write("\t"), write(B), write("\t"), evaluateExpression(Expression), false.
truth_table(_,_,_) :- true.


% 	Test example:
	%	?- truth_table(A, B, and(A, or(A, B))).
		%	true    true    true
		%	true    false   true
		%	false   true    false
		%	false   false   false
	
	