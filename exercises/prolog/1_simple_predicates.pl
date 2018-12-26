% ���� ����� ������ ���� father(person1, person2) (person1 is the father of person2)
% ���������� ���������� ����� ����������:
% 1. brother(X,Y)    -  ������������ �������� �� ��������� ��������
% 2. cousin(X,Y)     -  ������������ �������� �� ��������� ����������� ��������
% 3. grandson(X,Y)   -  ������������ �������� �� �������� � ������ ��������� Y
% 4. descendent(X,Y) -  ������������ �������� �� �������� X �������� ��������� Y
% 5. ��������� � �������� �������� ������ ��������� ���� ���������

father(a,b).  % 1
father(a,c).  % 2
father(b,d).  % 3
father(b,e).  % 4
father(c,f).  % 5

% �������
brother(X,Y) :- father(Z,X), father(Z,Y), X \= Y.
cousin(X,Y) :- father(Z,X), father(W,Y), brother(Z,W).
grandson(X,Y) :- father(Y,W), father(W,X).
descendent(X,Y) :- father(Y,X).
descendent(X,Y) :- father(Y,W), descendent(X,W).

% ����� �������� �������
:- forall(brother(X,Y), (write(X),write(" is brother of "),write(Y),nl)).
%b is brother of c
%c is brother of b
%d is brother of e
%e is brother of d

:- forall(cousin(X,Y), (write(X),write(" is cousin of "),write(Y),nl)).
%d is cousin of f
%e is cousin of f
%f is cousin of d
%f is cousin of e

:- forall(grandson(X,Y), (write(X),write(" is grandson of "),write(Y),nl)).
%d is grandson of a
%e is grandson of a
%f is grandson of a

:- forall(descendent(X,Y), (write(X),write(" is descedent of "),write(Y),nl)).
%b is descedent of a
%c is descedent of a
%d is descedent of b
%e is descedent of b
%f is descedent of c
%d is descedent of a
%e is descedent of a
%f is descedent of a
