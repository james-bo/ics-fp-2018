% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(L,K):-
		L = [Head|Tail],
		partition(Head, Tail, List1, List2),
		qsort(List1, Sorted1),
		qsort(List2, Sorted2),
		append(Sorted1, [Head|Sorted2], K).

qsort([], []).

partition(Current, [Head|Tail], [Head|LowEq], High):-
		Current >= Head,
		partition(Current, Tail, LowEq, High).

partition(Current, [Head|Tail], LowEq, [Head|High]):-
		partition(Current, Tail, LowEq, High).

partition(_, [], [], []).

check_sort:-
	List = [-54, 31, 78, -43, 23, 432, 65, 72, 32, 98, 12],
	qsort(List, Sorted),
	write(Sorted).

% ?-check_sort.
% [-54, -43, 12, 23, 31, 32, 65, 72, 78, 98, 432]
% true