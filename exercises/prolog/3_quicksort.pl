% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

part([X|Xs], Y, [X|Ls], Bs) :- X=<Y, part(Xs, Y, Ls, Bs).
part([X|Xs], Y, Ls, [X|Bs]) :- X>Y, part(Xs, Y, Ls, Bs).
part([],Y,[],[]).

qsort([X|Xs], Ys) :-part(Xs, X, L, B),
    qsort(L,Ls),
    qsort(B, Bs),
    append(Ls, [X|Bs], Ys).
qsort([],[]).
