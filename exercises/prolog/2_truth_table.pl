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



%% bool(true).
%% bool(false).

%% %% bool(A):- var(A), !, fail.

%% is_true(A) :- bool(A) = bool(true).

%% %% is_true(true).
%% %% is_true(A):- var(A), !, fail.

%% and(A,B):- is_true(A), is_true(B).

%% or(A, B) :- is_true(A) ; is_true(B).
%% or(A, B) :- and(A, B).

%% not(A) :- \+ is_true(A).

%% equ(A, B) :- bool(A), bool(B), A == B.

%% xor(A, B) :- \+ equ(A, B).

bool(true).
bool(false).

and(X, Y) :- X, Y.
or(X, Y) :- X ; Y.
not(X) :- \+ X.
equ(X, Y) :- X == Y.
xor(X, Y) :- not(equ(X, Y)).

%% чтобы write не term, а true/false
result(E, true):- E, !.
result(_, false).

%% output_line(X, Y, E) :- write(X), write('\t'), write(Y), write('\t'), writeln(E), fail.
output_line(X, Y, E) :- write(X), write('\t'), write(Y), write('\t'), writeln(E), fail.

%% всегда fail, когда все варианты просмотрены - идем к следующему правилу
truth_table(_,_,E):- writeln(E), fail.
truth_table(X, Y, E) :- bool(X), bool(Y), result(E, Result), output_line(X, Y, Result), fail.
truth_table(_,_,_):- true.

:- truth_table(A,B,and(A,B)).
:- truth_table(A,B,and(A,or(A,B))).
:- truth_table(A,B,or(A,and(A,B))).
:- truth_table(A,B,and(or(A, A), or(A,B))).

%% Результат:
%% :- truth_table(A,B,and(A,or(A,B))).
%% and(_3386,or(_3386,_3408))
%% true    true    true
%% true    false   true
%% false   true    false
%% false   false   false