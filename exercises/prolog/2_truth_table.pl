% определить предикаты:
	% and(A,B)
	
	and(A, B) :- A, B.
	
	% or(A, B)
	
	or(A, B) :- A; B.
	
	% not(A)
	
	not(A) :- \+ A.
	
	% equ(A,B)
	
	% equ(A, B) :- A = B. - Так нельзя! Искажает результаты сложных выражений. 
	equ(A, B) :- (A, B); (not(A), not(B)).
	
	% xor(A, B)
	
	xor(A, B) :- not(equ(A, B)).
	
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail


% Построение предиката truth_table

        bool(A) :- A = true.
        bool(A) :- A = false.
        
        eval(E, true) :- E, !.
        eval(E, false).
        
        truth_table(A, B, E) :- bool(A), bool(B), write(A), write(' '), write(B), write(' '), eval(E, R), write(R).
        
% Примеры таблиц истинности
% 1. Импликация

        %?- truth_table(A, B, or(not(A), B)).
        %true true true
        %true false false
        %false true true
        %false false true

% 2. Правило де Моргана
        
        %?- truth_table(A, B, equ(not(and(A, B)), or(not(A), not(B)))).
        %true true true
        %true false true
        %false true true
        %false false true
        
% 3. Двойной XOR

        %?- truth_table(A, B, equ(A, xor(xor(A, B), B))).
        %true true true
        %true false true
        %false true true
        %false false true
        
% 4. Ещё один пример

        %? - truth_table(A, B, and(xor(A, B), not(B))).
        %true true false
        %true false true
        %false true false
        %false false false
        
        
        
