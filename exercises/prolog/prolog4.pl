% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

append([],L,L). 
append([H|T],L2,[H|L3])  :-  append(T,L2,L3).

%сортирует массив, при этом создается два массива: с числами меньше чем pivot, и больше.
partition([H|T], Pivot, [H|LeftTail], Right) :- H =< Pivot, partition(T, Pivot, LeftTail, Right).
partition([H|T], Pivot, Left, [H|RightTail]) :- H > Pivot, partition(T, Pivot, Left, RightTail).
partition([], _, [], []).

quicksort([H|T], Result) :-
  partition(T, H, Left, Right), %в качестве pivot всегда берем первый элемент
  quicksort(Left, LeftResult),
  quicksort(Right, RightResult),
  append(LeftResult, [H|RightResult], Result).
quicksort([],[]).


	appendPre([],L,L,_). 
	%appendPre([H|[]],L,L,0). 
	appendPre(_,L,L,0). 
	appendPre([H|T],L2,[H|L3], Count)  :- NewCount is Count - 1, appendPre(T,L2,L3,NewCount).

	appendSuf([],L,L,0,_). 
	appendSuf(_,L,L,_,0).
	appendSuf([H|T],L2,[H|L3],0,Count) :- NewCount is Count - 1, appendSuf(T,L2,L3,0,NewCount).
	appendSuf([H|T],L2,L3,Skip,Count) :- NewSkip is Skip - 1, appendSuf(T,L2,L3,NewSkip,Count).


length_list(List,Length)  :-  acc_length(List, 0, Length).

acc_length([], Acc, Acc).
acc_length([H|T], Acc, Result) :- AccTemp is Acc + 1, acc_length(T, AccTemp, Result).

div_mod(Dividend, Divisor, Quotient, Remainder) :-
        Quotient  is Dividend div Divisor,
        Remainder is Dividend mod Divisor.

get_by_index([H|_],0,H) :- !.
get_by_index([_|T],N,H) :-
    N > 0,
    N1 is N-1,
    get_by_index(T,N1,H).

middle(List, Result) :- length_list(List,Length), div_mod(Length, 2, Index, _), get_by_index(List, Index, Result).

splitOnTwo(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).


%print_tree(instant(Root, empty, empty)):- write(Root). %, nl.
%print_tree(instant(Root, Left, Right)):- write(Root), write('('), 
%                                       print_tree(Left), write(','),
%                                       print_tree(Right), write(')').

print_N_spaces(0).
print_N_spaces(Depth) :- write('\t'), NewDepth is Depth - 1, print_N_spaces(NewDepth).

print_tree(X) :- print_tree(X, 0). 
print_tree(instant(Root, empty, empty), Depth):- write(Root), nl.
print_tree(instant(Root, Left, Right), Depth):- write(Root), nl, NewDepth is Depth + 1, print_N_spaces(NewDepth),
                                       print_tree(Left, NewDepth), print_N_spaces(NewDepth), 
                                       print_tree(Right, NewDepth).

balanced_tree([], empty) :- write('empty').
balanced_tree(L, T) :- quicksort(L, Sorted), build_tree(Sorted, T).

build_tree([], CurrentRoot) :- CurrentRoot = empty.
build_tree(List, instant(Root,L,R)) :- length_list(List,Length), div_mod(Length, 2, Index, _), 
	get_by_index(List, Index, Root),
	appendPre(List, _, LeftList,Index), build_tree(LeftList, L),
	RightIndex is Index + 1, RightLength is Length - RightIndex, 
	appendSuf(List, _, RightList, RightIndex, RightLength), build_tree(RightList, R).

instant(Root, L, R).
instant(Root, empty, R).
instant(Root, L, empty).
instant(Root, empty, empty).