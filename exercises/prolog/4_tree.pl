% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% RESULT:  ?- balanced_tree([0,-5,6,7,8,9,2,4],T).
%            T = instant(6, instant(2, instant(-5, empty, instant(0, empty, empty)), instant(4, empty, empty)), instant(8, instant(7, empty, empty), instant(9, empty, empty))) .

fork([], _, [], []).
fork([X| Xs], Pivot, Smalls, Bigs) :-
    (    X =< Pivot ->
         Smalls = [X|Rest],
         fork(Xs, Pivot, Rest, Bigs);
         Bigs = [X|Rest],
         fork(Xs, Pivot, Smalls, Rest)).
qsort([], []).
qsort([X|Xs], R):-
    fork(Xs, X, Smaller0, Bigger0),
    qsort(Smaller0, Smaller),
    qsort(Bigger0, Bigger),
    append(Smaller, [X|Bigger], R).

balanced_tree(List, T) :- balanced_tree_c(List, T).

balanced_tree_c([], empty).

balanced_tree_c(List1, instant(H, empty, empty)) :-
    List1 = [H|[]].

balanced_tree_c([VS|[VB|[]]], instant(VS, empty, RC)) :-
    VS < VB,
    balanced_tree_c([VB], RC).

balanced_tree_c([VB|[VS|[]]], instant(VB, Left1, empty)) :-
    balanced_tree_c([VS], Left1).

balanced_tree_c(List, instant(Root, Left1, Right1)) :-
    qsort(List, Left3),
    div(Left3, Left2, [Root|Right2]),
    balanced_tree(Left2, Left1),
    balanced_tree(Right2, Right1).

div(List, Left1, Right1) :-
    append(Left1, Right1, List),
    length(Left1, Left2),
    length(Right1, Right2),
    (Left2 =:= Right2; Left2 =:= (Right2 - 1)).