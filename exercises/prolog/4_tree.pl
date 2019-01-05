% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort([],[]).
qsort([H|T], K) :-
	partition(H, T, Left, Right),
	qsort(Left, SortedLeft),
	qsort(Right, SortedRight),
	append(SortedLeft, [H|SortedRight], K).

partition(_, [], [], []).
partition(Base, [H|T], [H|Left], Right) :-
	Base > H, partition(Base, T, Left, Right).

partition(Base,[H|T], Left, [H|Right]) :-
	partition(Base, T, Left, Right).
	

balanced_tree([], empty).

balanced_tree([H|[]], instant(H, empty, empty)) :- !.

balanced_tree([T|[H|[]]], instant(H, L, empty)) :-
    H > T,
    balanced_tree([T], L).

balanced_tree([H|[T|[]]], instant(H, L, empty)) :-
    H =< T,
    balanced_tree([T], L).

balanced_tree(L, instant(Root, Left, Right)) :-
    qsort(L, LSorted),
    append(LL, [Root|LR], LSorted),
    length(LL, LLength),
    length([Root|LR], RLength),
    (LLength =:= RLength; LLength =:= (RLength - 1)),
    balanced_tree(LL, Left),
    balanced_tree(LR, Right), !.
	
% 	Test example:
	%	?- qsort([143, -2510, 0, 0, 17, 42, 143, -5, -113], K).
	%	K = [-2510, -113, -5, 0, 0, 17, 42, 143, 143] 
	
	%	?- balanced_tree([143, -2510, 0, 0, 17, 42, 143, -5, -113], T).
	%	T = instant(0, 
	%			instant(-5, 
	%				instant(-113, 
	%					instant(-2510, empty, empty), empty), 
	%					instant(0, empty, empty)), 
	%			instant(143,
	%				instant(42, 
	%					instant(17, empty, empty), empty), 
	%				instant(143, empty, empty))). 