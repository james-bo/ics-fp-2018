%% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

append([],L,L). 
append([H|T],L2,[H|L3])  :-  append(T,L2,L3).

add(A,B,[A|B]).


%% mrg([H1|T1], [H2|T2], Result) :- H1 =< H2, append(H1, Result, Result), mrg(T1, [H2|T2], Result), print('h1<h2').
%% mrg([H1|T1], [H2|T2], Result) :- append(H2, Result, Result), mrg([H1|T1], T2, Result), print('h2>h1').
%% 	mrg([H1|T1], [], Result) :- append(H1, [], Result), mrg(T1, [], Result), print('h2 empty').
%% 	mrg([], [H2|T2], Result) :- append(H2, [], Result), mrg([], T2, Result), print('h1 empty').
%% mrg([], [H2|T2], Result) :- append([H2|T2], Result, Result), print('h1 empty').
%% 	mrg([],Result,Result).

%% короче, это как append, но есть нюанс
mrg(L1, L2, Merged) :- mrg2(L1, L2, Merged), print(Merged).

mrg2([], Result, Result).
mrg2(Result, [], Result).
mrg2([H1|T1], [H2|T2], [H1|Tr]) :- H1 =< H2, mrg2(T1, [H2|T2], Tr).
mrg2([H1|T1], [H2|T2], [H2|Tr]) :- H1 > H2, mrg2([H1|T1], T2, Tr).

:- mrg([3, 7, 9, 11], [1, 2, 2, 4], Merged).

%% Результаты:
%% :- mrg([3, 7, 9, 11], [1, 2, 2, 4], Merged).
%% [1,2,2,3,4,7,9,11]