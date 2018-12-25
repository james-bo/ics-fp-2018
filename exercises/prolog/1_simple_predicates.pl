% есть набор фактов вида father(person1, person2) (person1 is the father of person2)
% Необходимо определить набор предикатов:
% 1. brother(X,Y)    -  определяющий являются ли аргументы братьями
% 2. cousin(X,Y)     -  определяющий являются ли аргументы двоюродными братьями
% 3. grandson(X,Y)   -  определяющий является ли аргумент Х внуком аргумента Y
% 4. descendent(X,Y) -  определяющий является ли аргумент X потомком аргумента Y
% 5. используя в качестве исходных данных следующий граф отношений
	father(a,b).  % 1                 
	father(a,c).  % 2
	father(b,d).  % 3
	father(b,e).  % 4
	father(c,f).  % 5
% указать в каком порядке и какие ответы генерируются вашими методами
	%% ?- brother(X,Y).
	%% ?- cousin(X,Y).
	%% ?- grandson(X,Y).
	%% ?- descendent(X,Y).

neg(Goal)  :-  Goal,!,fail. 
neg(Goal).

brother(X, Y) :- father(Z, X), father(Z, Y), neg(X=Y).

cousin(X,Y) :- brother(Xfather, Yfather), father(Xfather, X), father(Yfather, Y), neg(X=Y).

grandson(X, Y) :- father(Y, Z), father(Z, X).

descendent(X,Y) :- father(Y, X), neg(X=Y).
descendent(X,Y) :- father(Y, Z), descendent(X, Z).

%% Для вывода

answer_brother(X, Y) :- brother(X, Y), write(X), writeln(Y), fail.
answer_brother(_, _) :- nl, true.

answer_cousin(X, Y) :- cousin(X, Y), write(X), writeln(Y), fail.
answer_cousin(_, _) :- nl, true.

answer_grandson(X, Y) :- grandson(X, Y), write(X), writeln(Y), fail.
answer_grandson(_, _) :- nl, true.

answer_descendent(X, Y) :- descendent(X, Y), write(X), writeln(Y), fail.
answer_descendent(_, _) :- nl, true.

:- answer_brother(X, Y).
:- answer_cousin(X, Y).
:- answer_grandson(X, Y).
:- answer_descendent(X, Y).

%% Результаты:
%% 1) brother(X,Y).
%% bc
%% cb
%% de
%% ed
%% 2) cousin(X,Y).
%% df
%% ef
%% fd
%% fe
%% 3) grandson(X,Y).
%% da
%% ea
%% fa
%% 4) descendent(X,Y).
%% ba
%% ca
%% db
%% eb
%% fc
%% da
%% ea
%% fa