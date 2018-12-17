% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort([],[]).
qsort([Head|Tail],Result) :-
	partition(Head,Tail,Left,Right),
	qsort(Left,SortedLeft),
	qsort(Right,SortedRight),
	append(SortedLeft,[Head|SortedRight],Result).

partition(_,[],[],[]).
partition(Pivot,[Head|Tail],[Head|Left],Right) :-
	Pivot > Head, partition(Pivot,Tail,Left,Right).
partition(Pivot,[Head|Tail],Left,[Head|Right]) :-
	partition(Pivot,Tail,Left,Right).

split(List, Left, Right):-
    append(Left, Right, List),
    length(List, ListLength),
    Half is ListLength div 2,
    length(Left, Half).

balanced_tree_impl([], empty).

balanced_tree_impl(List, instant(Root, Left, Right)):-
    split(List, LeftList, [Root|RightList]),
    balanced_tree_impl(LeftList, Left),
    balanced_tree_impl(RightList, Right).

balanced_tree(L,T):-
	qsort(L,K),
	balanced_tree_impl(K,T).

% balanced_tree([14,10,12,19,7,3,1,20],T)
% T = instant(12, instant(7, instant(3, instant(1, empty, empty), empty), instant(10, empty, empty)), instant(19, instant(14, empty, empty), instant(20, empty, empty))) 