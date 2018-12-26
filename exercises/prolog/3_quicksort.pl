% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный
qsort([], []).
qsort([H|T], SortList) :- pivot(H, T, L1, L2),
    qsort(L1, SortList1), qsort(L2, SortList2),
    append(SortList1, [H|SortList2], SortList).

pivot(_, [], [], []).
pivot(Piv, [H|T], [H|LOrEqT], GrT) :- Piv >= H, pivot(Piv, T, LOrEqT, GrT).
pivot(Piv, [H|T], LOrEqT, [H|GrT]) :- Piv < H, pivot(Piv, T, LOrEqT, GrT).

%?- qsort([4,1,6,3,5],K).
%K = [1,3,4,5,6]
