% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% Quicksort
quicksort([X|Xs],Ys) :-
  partition(Xs,X,Left,Right),
  quicksort(Left,Ls),
  quicksort(Right,Rs),
  append(Ls,[X|Rs],Ys).
quicksort([],[]).

partition([X|Xs],Y,[X|Ls],Rs) :-
  X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]) :-
  X > Y, partition(Xs,Y,Ls,Rs).
partition([],Y,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).

% Tree

split(List, Left, Right):-
    append(Left, Right, List),
    length(List, Len),
    HalfLen is Len div 2,
    length(Left, HalfLen).

balanced_tree_impl(List, instant(Root, LeftChild, RightChild)):-
    split(List, LeftList, [Root|RightList]),
    balanced_tree_impl(LeftList, LeftChild),
    balanced_tree_impl(RightList, RightChild).

balanced_tree(L,T):-
	quicksort(L, SL),
	balanced_tree_impl(SL,T).

balanced_tree_impl([], empty).