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

----------------------------Correction---------------------------------
and(A,B) :- A,B.
or(A,B) :- A ; B.
xor(A,B) :- not(equ(A,B)).
not(A) :- \+A.
equ(A,B) :- A == B.

bool(true).
bool(fail).

evaluate(E, true) :- E, !.
evaluate(_, fail).

truth_table(A,B,E) :-
  bool(A),
  bool(B),
  write(A),
  write(' \t '),
  write(B),
  write(' \t '),
  evaluate(E, Result),
  write(Result),nl, fail.

And the output is : 
?- truth_table(A,B,and(A,or(A,B))).
true 	 true 	 true
true 	 fail 	 true
fail 	 true 	 fail
fail 	 fail 	 fail




