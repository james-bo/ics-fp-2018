% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% bt(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% level(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% bt(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% level(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort(L,K):-
		L = [Head|Tail],
		partition(Head, Tail, List1, List2),
		qsort(List1, Sorted1),
		qsort(List2, Sorted2),
		append(Sorted1, [Head|Sorted2], K).

qsort([], []).

partition(Current, [Head|Tail], [Head|LowEq], High):-
		Current >= Head,
		partition(Current, Tail, LowEq, High).

partition(Current, [Head|Tail], LowEq, [Head|High]):-
		partition(Current, Tail, LowEq, High).

partition(_, [], [], []).

split(List, Left, Right):-
	append(Left, Right, List),
	length(List, Len),
	Half is Len div 2,
	length(Left, Half).

bt_i([], empty).
bt_i(List, level(Root, LeftLeef, RightLeef)):-
	split(List, LeftList, [Root|RightList]),
	bt_i(LeftList, LeftLeef),
	bt_i(RightList, RightLeef). 

bt(L, T):-
	qsort(L, SL),
	bt_i(SL, T).

check_tree:-
	Empty_list = [],
	L1 = [90],
	L2 = [90, 10],
	L3 = [90, 10, 20],
	L4 = [90, 100, 40, 20, 60, 70, 50],
	writeln(Empty_list),
	bt(Empty_list,R0),

	writeln(R0), nl,
	writeln(L1),
	bt(L1,R1),

	writeln(R1), nl,
	writeln(L2),
	bt(L2,R2),

	writeln(R2), nl,
	writeln(L3),
	bt(L3,R3),

	writeln(R3), nl,
	writeln(L4),
	bt(L4,R4),
	writeln(R4).

% ?-check_tree.
% []
% empty

% [90]
% level(90,empty,empty)

% [90,10]
% level(90,level(10,empty,empty),empty)

% [90,10,20]
% level(90,level(10,empty,empty),level(20,empty,empty))

% [90,100,40,20,60,70,50]
% level(90,level(70,level(60,level(50,level(40,level(20,empty,empty),empty),empty),empty),empty),level(100,empty,empty))
% true.