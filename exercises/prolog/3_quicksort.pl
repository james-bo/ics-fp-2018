% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

%% select pivot point
%% поставить два индекса (в начале массива и в конце) - 1 больше опорного  и перед pivot, 2 - меньше и после pivot
%% swap elements
%% Обмен происходит до тех пор, пока индексы не пересекутся. Алгоритм возвращает последний индекс
%% 

append([],L,L). 
append([H|T],L2,[H|L3])  :-  append(T,L2,L3).

%% length_list(List,Length)  :-  acc_length(List, 0, Length).

%% acc_length([H|T], Acc, Result) :- AccTemp is Acc + 1, acc_length(T, AccTemp, Result).
%% acc_length([], Acc, Acc).

%% div_mod(Dividend, Divisor, Quotient, Remainder) :-
%% 	Quotient  is Dividend div Divisor,
%% 	Remainder is Dividend mod Divisor.

%% get_by_index([H|_],0,H) :- !.
%% get_by_index([_|T],N,H) :-
%% 	N > 0,
%% 	N1 is N-1,
%% 	get_by_index(T,N1,H).

%% middle(List, Result) :- length_list(List,Length), div_mod(Length, 2, Index, _), get_by_index(List, Index, Result).

%% qsort(List, Result) :- qsort(List, StartIndex, EndIndex).
%% qsort(List, Start, End) :- partition(List, Start, End, Mid), qsort(List, Start, Mid), qsort(List, Mid, End), \+ Start >= End, !. 
%% partition(List, Pivot, Start, End, Mid) :- compare_less(List, H, IndexA), compare_more(List, H, IndexB), Mid = IndexB, \+ IndexA < IndexB, swap(List, IndexA, IndexB).


%% сортирует массив, при этом создается два массива: с числами меньше чем pivot, и больше.
partition([H|T], Pivot, [H|LeftTail], Right) :- H =< Pivot, partition(T, Pivot, LeftTail, Right).
partition([H|T], Pivot, Left, [H|RightTail]) :- H > Pivot, partition(T, Pivot, Left, RightTail).
partition([], _, [], []).

quicksort([H|T], Result) :-
	partition(T, H, Left, Right), %% в качестве pivot всегда берем первый элемент
	quicksort(Left, LeftResult),
	quicksort(Right, RightResult),
	append(LeftResult, [H|RightResult], Result).
quicksort([],[]).

qsort(In, Sorted) :- quicksort(In, Sorted), write(Sorted).

:- qsort([4221, -3, 15, -10, 20], Sorted).

%% Результаты:
%% :- qsort([4221, -3, 15, -10, 20], Sorted).
%% [-10,-3,15,20,4221]
