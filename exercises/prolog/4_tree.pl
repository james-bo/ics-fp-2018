% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% qsort из задания 3
:- consult('3_quicksort.pl').

% Список преобразуем в поддерево так, чтобы левая и правая часть были либо одинаковой длины, либо отличались не более чем на 1 (например список из 8 -> 3 слева + корень + 4 справа)
% =:= - "двусторонний is", интерпретирует термы числами/арифм. выраженями по обе стороны в отличие от is (только справа)
% split2/3 - разбиение на подсписки примерно одинаковой длины

split2(L, Lres, Rres) :-
    merge(Lres, Rres, L),
    length(Lres, Llen),
    length(Rres, Rlen),
    (Llen =:= Rlen; Llen+1 =:= Rlen).
    
% to_tree/2 - рекурсивное разбиение L и упаковка в дерево instant(Root, Left, Right)

to_tree(L, instant(Root, Left, Right)) :-
    split2(L, Lres, [Root|Rres]),
    to_tree(Lres, Left),
    to_tree(Rres, Right).
    
to_tree([], empty).

% balanced_tree(L, T) - оболочка над to_tree. Отбрасывает пустые списки, сортирует один раз непустые.

balanced_tree(L, T) :-
    qsort(L, Lsorted),
    to_tree(Lsorted, T).
    
balanced_tree([], empty).

% Тест:

% ?- balanced_tree([1, 7, 4, 8, -2, -6, -9, 0], T).
% T = instant(1, instant(-2, instant(-6, instant(-9, empty, empty), empty), instant(0, empty, empty)), instant(7, instant(4, empty, empty), instant(8, empty, empty)))
