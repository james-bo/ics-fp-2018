% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

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

balanced_tree([], empty).

balanced_tree([H|[]], instant(H, empty, empty)) :- !.

balanced_tree([T|[H|[]]], instant(H, L, empty)) :-
    H > T,
    balanced_tree([T], L).

balanced_tree([H|[T|[]]], instant(H, L, empty)) :-
    T >= H,
    balanced_tree([T], L).

balanced_tree(L, instant(R, Lt, Rt)) :-
    qsort(L, LS),
    append(LL, [R|LR], LS),
    length(LL, LnL),
    length([R|LR], LnR),
    (LnL =:= LnR; LnL =:= (LnR - 1)),
    balanced_tree(LL, Lt),
    balanced_tree(LR, Rt), !.