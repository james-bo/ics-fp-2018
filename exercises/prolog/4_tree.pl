% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% qsort used from a previous exercise

balanced_tree_impl([], empty). % no nodes

split(List, L, R):-
    append(L, R, List),
    length(List, Len),
    H is Len div 2,
    length(L, H).

balanced_tree_impl(List, instant(Root, L, R)):-
    split(List, LList, [Root|RList]),
    balanced_tree_impl(LList, L),
    balanced_tree_impl(RList, R).

balanced_tree(L,T):- qsort(L,K), balanced_tree_impl(K,T).
