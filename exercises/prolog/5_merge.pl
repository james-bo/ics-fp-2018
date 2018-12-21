% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([],L2,R) :- R = [].

mrg(L1,[],R) :- R = [].

mrg([],[],R) :- R = [].

mrg(L1,L2,R) :- L1 = [Head1|Tail1], 
    L2 = [Head2|Tail2], 
    Head1 == Head2, 
    mrg(Tail1,Tail2,R1),
    R = [Head1|R1].

mrg(L1,L2,R) :- L1 = [Head1|Tail1], 
    L2 = [Head2|Tail2],
    Head1 < Head2, 
    mrg(Tail1,L2,R).

mrg(L1,L2,R) :- L1=[Head1|Tail1], 
    L2 = [Head2|Tail2],
    Head1 > Head2, 
    mrg(L1,Tail2,R).
