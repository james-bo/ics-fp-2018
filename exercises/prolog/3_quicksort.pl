% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort([],[]).
qsort([H|T],K) :-
  partition(H,T,Left,Right),
  qsort(Left,LeftSorted),
  qsort(Right,RightSorted),
  append(LeftSorted,[H|RightSorted],K).

partition(_,[],[],[]).
partition(Pivot,[H|T],[H|Left],Right) :-
  H =< Pivot,
  partition(Pivot,T,Left,Right).
partition(Pivot,[H|T],Left,[H|Right]) :-
  H > Pivot,
  partition(Pivot,T,Left,Right).

append([],L,L).
append([H|T],L2,[H|L3]) :- append(T,L2,L3).