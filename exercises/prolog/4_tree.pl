% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
% 

compareWithPivot(_, [], [], []).
compareWithPivot(Pivot, [Head|Tail], [Head|LessPart], GreaterPart) :- Pivot >= Head, compareWithPivot(Pivot, Tail, LessPart, GreaterPart). 
compareWithPivot(Pivot, [Head|Tail], LessPart, [Head|GreaterPart]) :- compareWithPivot(Pivot, Tail, LessPart, GreaterPart).

quicksort([], []).
quicksort(L, K) :- L = [Head|Tail], compareWithPivot(Head, Tail, LessPart, GreaterPart), 
    quicksort(LessPart, SortedLessPart), 
    quicksort(GreaterPart, SortedGreaterPart), 
    append(SortedLessPart, [Head|SortedGreaterPart], K).

devide(List,Left,Right) :- append(Left,Right,List),
    length(Left, N),
    length(Right, N).
devide(List,Left,Right) :- append(Left,Right,List),
    length(Left, N),
    length(Right, N1), N1 is N+1.
devide(List,Left,Right,Middle) :- devide(List,Left,RightAndMiddle), 
    RightAndMiddle = [Middle|Right].
tree([],empty).
tree(Sorted,T) :- devide(Sorted,Left,Right,Middle), 
    tree(Left,LT), 
    tree(Right,RT), 
    T=instant(Middle,LT,RT). 
balanced_tree(L,T) :- quicksort(L,Sorted), tree(Sorted, T).

% сначала сортируем список, 
% потом закидываем рекурсивно половинки списка в листья дерева с помощью tree(Sorted,T)
% devide(Left,Right) - делит список пополам, если размер списка нечетный - то правый кусок больше на один
% Соответственно из правого куска вынимаем первый элемент, он становится серединкой списка в devide(List,Left,Right,Middle)