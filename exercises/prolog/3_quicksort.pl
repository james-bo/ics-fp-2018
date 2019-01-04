% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

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
	
% 	Test example:
	%	?- qsort([143, -2510, 0, 0, 17, 42, 143, -5, -113], K).
	%	K = [-2510, -113, -5, 0, 0, 17, 42, 143, 143] 