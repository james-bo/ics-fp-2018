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

% правила
brother(X,Y) :- father(Z,X), father(Z,Y), X \= Y.
cousin(X,Y) :- father(Z,X), father(W,Y), brother(Z,W).
grandson(X,Y) :- father(Y,W), father(W,X).
descendent(X,Y) :- father(Y,X).
descendent(X,Y) :- father(Y,W), descendent(X,W).

% вывод степеней родства
:- forall(brother(X,Y), (write(X),write(" is brother of "),write(Y),nl)).
%b is brother of c
%c is brother of b
%d is brother of e
%e is brother of d

:- forall(cousin(X,Y), (write(X),write(" is cousin of "),write(Y),nl)).
%d is cousin of f
%e is cousin of f
%f is cousin of d
%f is cousin of e

:- forall(grandson(X,Y), (write(X),write(" is grandson of "),write(Y),nl)).
%d is grandson of a
%e is grandson of a
%f is grandson of a

:- forall(descendent(X,Y), (write(X),write(" is descedent of "),write(Y),nl)).
%b is descedent of a
%c is descedent of a
%d is descedent of b
%e is descedent of b
%f is descedent of c
%d is descedent of a
%e is descedent of a
%f is descedent of a
