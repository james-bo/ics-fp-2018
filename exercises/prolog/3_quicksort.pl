% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

compareWithPivot(_, [], [], []).
compareWithPivot(Pivot, [Head|Tail], [Head|LessPart], GreaterPart) :- Pivot >= Head, compareWithPivot(Pivot, Tail, LessPart, GreaterPart). 
compareWithPivot(Pivot, [Head|Tail], LessPart, [Head|GreaterPart]) :- compareWithPivot(Pivot, Tail, LessPart, GreaterPart).

quicksort([], []).
quicksort(L, K) :- L = [Head|Tail], compareWithPivot(Head, Tail, LessPart, GreaterPart), 
    quicksort(LessPart, SortedLessPart), 
    quicksort(GreaterPart, SortedGreaterPart), 
    append(SortedLessPart, [Head|SortedGreaterPart], K).