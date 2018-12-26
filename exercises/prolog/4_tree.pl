% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
balanced_tree(L,T) :- bin_tree(L,T).
pivot(_,[],[],[]).
pivot(Piv, [H|T], [H|LOrEqT], GrT) :- Piv >= H, pivot(Piv, T, LOrEqT, GrT).
pivot(Piv, [H|T], LOrEqT, [H|GrT]) :- Piv < H, pivot(Piv, T, LOrEqT, GrT).

qsort([], []).
qsort([H|T], SortList) :- pivot(H, T, L1, L2), qsort(L1, SortList1), qsort(L2, SortList2),append(SortList1, [H|SortList2], SortList).

bin_tree([],empty).

bin_tree([H|[]], instant(H,empty,empty)):- !.

bin_tree([T|[H|[]]],instant(H,L,empty)):- T =< H, bin_tree([T],L).

bin_tree([H|[T|[]]],instant(H,L,empty)):- H < T,bin_tree([T],L).

bin_tree(L, instant(R, Left, Right)):- qsort(L,SL), append(LList, [R|RList], SL),
        length(LList, LengthL), length([R|RList], LengthR), (LengthL =:= LengthR;
        LengthL =:= (LengthR - 1)), bin_tree(LList, Left), bin_tree(RList, Right),!.

%?- balanced_tree([3,1],T).
%T = instant(3, instant(1, empty, empty), empty) .

%?- balanced_tree([1,3],T).
%T = instant(1, empty, instant(3, empty, empty)) .




