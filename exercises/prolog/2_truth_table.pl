% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)
	

	truth(A) :- A=true.
    false(A) :- A=false.

    bool_var(true).
    bool_var(false).

	not(A) :-
    	false(A).
    	

	and(A, B) :-
    	truth(A),
    	truth(B).

	or(A, B) :-
    	truth(A), truth(B);
    	truth(A), false(B);
        false(A), truth(B).

	xor(A, B) :-
    	truth(A), false(B);
    	false(A), truth(B).

	equ(A, B) :-
    	truth(A),truth(B);
    	false(A),false(B).

	get_result(Expression, true) :- Expression, !.
	get_result(_, false).

	truth_table(A, B, Expression) :-
		bool_var(A),
		bool_var(B),
		write(A), write(' '),
		write(B), write(' '),
		get_result(Expression, Result),
		write(Result),nl,false.
    	
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true false true
% false true false
% false false false