% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

part([X|Xs], Y, [X|Ls], Bs) :- X=<Y, part(Xs, Y, Ls, Bs).
part([X|Xs], Y, Ls, [X|Bs]) :- X>Y, part(Xs, Y, Ls, Bs).
part([],Y,[],[]).

qsort([X|Xs], Ys) :-part(Xs, X, L, B),
    qsort(L,Ls),
    qsort(B, Bs),
    append(Ls, [X|Bs], Ys).
qsort([],[]).

divide(L, L1, L2):-divide2([_|L], L, L1, L2).
divide2([_,_|T], [A|L], [A|L1], L2):-!, divide2(T, L, L1, L2).
divide2(_, L2, [], L2).

deleteLast([_|[]],[]).
deleteLast([X|Xs],[X|Ys]) :- deleteLast(Xs,Ys).
deleteLast(Xs,Ys) :- Xs=[], Ys=[].

getLast(X, Y) :- X=[], Y=[].
getLast(X, Y) :- last(X,Z), Y=[Z].

getElement(L,X) :- divide(L,L1,L2), getLast(L1, R), R=X.

put(L1,L2,X,R) :- length(L1,0), length(L2,0), R=X.
put(L1,L2,X,R) :- getElement(L1,X1), getElement(L2,X2), append(X,X1,R1), append(R1,X2,R2),
divide(L1,L11,L12), deleteLast(L11,L111), put(L111, L12, R2, R3),
divide(L2,L21,L22), deleteLast(L21,L211), put(L211, L22, R3, R4), R=R4.

getList(L,Y):- R=[], getElement(L,X), append(R,X,R2), divide(L,L1,L2), deleteLast(L1,L11), put(L11, L2, R2, R3), Y=R3.

add(X,empty,T) :- T = instant(X,empty,empty).
add(X,instant(Root,L,R),T) :- X @< Root, T = instant(Root,L1,R), add(X,L,L1).
add(X,instant(Root,L,R),T) :- X @> Root, T = instant(Root,L,R1), add(X,R,R1).

balanced_tree(L,T) :- qsort(L, S), getList(S, L2), balanced_tree(L2,T,empty).
balanced_tree([],T,T0) :- T = T0.
balanced_tree([N|Ns],T,T0) :- add(N,T0,T1), balanced_tree(Ns,T,T1).

% ?- balanced_tree([11,10,9,8,7,5,1,0],T).
%  T = instant(7, instant(1, instant(0, empty, empty), instant(5, empty,
% empty)), instant(9, instant(8, empty, empty), instant(10, empty,
