% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

and(A,B) :- A,B.
or(A,B) :- A; B.
xor(A,B) :- A \== B.
not(A) :- \+A.
equ(A,B) :- A == B. % not(xor(A,B))

evaluate(Expr, true) :- Expr.
evaluate(Expr, fail) :- \+Expr.

writeRow(A,B,Result) :- write(A), write(' '), write(B), write(' '), write(Result),nl.

bool(true).
bool(fail).

truth_table_row(A,B,Expression) :-
bool(A),bool(B),
  evaluate(Expression, Result),
  writeRow(A,B,Result).

truth_table(A,B,Expression) :-
  write('A    B    Result'),
  nl,
  truth_table_row(A,B,Expression),
  fail.
  
:-truth_table(A,B,xor(not(A),and(A,B))).

%A    B    Result
%true true true
%true fail true
%fail true true
%fail fail true