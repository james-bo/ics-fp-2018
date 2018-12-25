neg(Goal)  :-  Goal,!,fail. 
neg(Goal).

father(a,b).  % 1                 
father(a,c).  % 2
father(b,d).  % 3
father(b,e).  % 4
father(c,f).  % 5

brother(X, Y) :- father(Z, X), father(Z, Y), neg(X=Y).
cousin(X,Y) :- brother(Xfather, Yfather), father(Xfather, X), father(Yfather, Y), neg(X=Y).
grandson(X, Y) :- father(Y, Z), father(Z, X).
descendent(X,Y) :- father(Y, X), neg(X=Y).
descendent(X,Y) :- father(Y, Z), descendent(X, Z).

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
