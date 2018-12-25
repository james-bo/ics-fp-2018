% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(L, K) :-
    L = [H|T], % Head Tail
    pivot(H,T,L,R), % Head Tail Left Right
    qsort(L,LS), % Left LeftSorted
    qsort(R,RS), % Right RightSorted
    append(LS,[H|RS],K).
  qsort([],[]).
  
partition(X,[H|T],LS,[H|RS]) :- 
    X <= H, partition(X,T,LS,RS).
partition(X,[H|T],[H|LS],RS) :- 
    X > H, partition(X,T,LS,RS).

partition(_,[],[],[]).
  
 % ?- qsort([0, 33, 31, -3, 1, 4, -9, 17, 25, 24],R).
 % R = [-9, -3, 0, 1, 4, 17, 24, 25, 31, 33]

  