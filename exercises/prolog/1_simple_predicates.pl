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
	brother(X,Y) :- father(Z,X), father(Z,Y).
%   Call: (9) brother(b, c) ? creep
%   Call: (10) father(_350, b) ? creep
%   Exit: (10) father(a, b) ? creep
%   Call: (10) father(a, c) ? creep
%   Exit: (10) father(a, c) ? creep
%   Exit: (9) brother(b, c) ? creep

	cousin(X,Y) :- father(P1, X), father(P2, Y), brother(P1, P2).
%   Call: (9) cousin(d, f) ? creep
%   Call: (10) father(_1242, d) ? creep
%   Exit: (10) father(b, d) ? creep
%   Call: (10) father(_1242, f) ? creep
%   Exit: (10) father(c, f) ? creep
%   Call: (10) brother(b, c) ? creep
%   Call: (11) father(_1242, b) ? creep
%   Exit: (11) father(a, b) ? creep
%   Call: (11) father(a, c) ? creep
%   Exit: (11) father(a, c) ? creep
%   Exit: (10) brother(b, c) ? creep
%   Exit: (9) cousin(d, f) ? creep
	grandson(X,Y) :- father(Y, Z), father(Z, X).
%   Call: (8) grandson(d, a) ? creep
%   Call: (9) father(a, _2394) ? creep
%   Exit: (9) father(a, b) ? creep
%   Call: (9) father(b, d) ? creep
%   Exit: (9) father(b, d) ? creep
%   Exit: (8) grandson(d, a) ? creep

        descendent(X,Y):- father(Y, X).
        descendent(X,Y) :- father(Z,X), descendent(Z,Y).

%   Call: (8) descendent(d, a) ? creep
%   Call: (9) father(a, d) ? creep
%   Fail: (9) father(a, d) ? creep
%   Redo: (8) descendent(d, a) ? creep
%   Call: (9) father(_3494, d) ? creep
%   Exit: (9) father(b, d) ? creep
%   Call: (9) descendent(b, a) ? creep
%   Call: (10) father(a, b) ? creep
%   Exit: (10) father(a, b) ? creep
%   Exit: (9) descendent(b, a) ? creep
%   Exit: (8) descendent(d, a) ? creep
