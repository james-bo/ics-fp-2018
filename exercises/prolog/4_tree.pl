% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

split(L, Left, Right) :- append(Left, Right, L), length(Left, Left_L), length(Right, Right_L), (Left_L =:= Right_L; Left_L =:= (Right_L - 1)).

balanced_tree([], empty).
balanced_tree(L, instant(H, empty, empty)) :- L = [H|[]].
balanced_tree([Lo|[Hi|[]]], instant(Hi, LChild, empty)) :- Lo < Hi, balanced_tree([Lo], LChild), !.
balanced_tree([Hi|[Lo|[]]], instant(Hi, LChild, empty)) :- balanced_tree([Lo], LChild), !.
balanced_tree(List, instant(Root, L, R)) :-
    qsort(List, Sorted),
    split(Sorted, Left_L, [Root|Right_L]),
    balanced_tree(Left_L, L),
    balanced_tree(Right_L, R), !.

% ?- balanced_tree([8,6,9,4,5,7,10], T).
% T = instant(7, instant(5, instant(4, empty, empty), instant(6, empty, empty)), instant(9, instant(8, empty, empty), instant(10, empty, empty))).
