% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([],[],[]).
mrg([], L, L).
mrg(L, [], L).

mrg([HeadL1|TailL1], [HeadL2|TailL2], [HeadL1|TailR]) :- HeadL1 < HeadL2, mrg(TailL1, [HeadL2|TailL2], TailR).
mrg([HeadL1|TailL1], [HeadL2|TailL2], [HeadL2|TailR]) :- HeadL1 >= HeadL2, mrg([HeadL1|TailL1], TailL2, TailR).

% 	Test example:
	%	?- mrg([-2510, -5, 0, 17, 143] ,[-113, 0, 42, 143], R).
	%	R = [-2510, -113, -5, 0, 0, 17, 42, 143, 143] 