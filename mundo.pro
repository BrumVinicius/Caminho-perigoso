% 0_____________________X
% |                     |
% |                     |
% |                     |
% |                     |
% Y_____________________X
% posicao [2,2] linha 2, coluna 2
%        1         2         3
%  1           PERCEPCAO2
%  2 PERCEPCAO1   Pos    PERCEPCAO3
%  3           PERCEPCAO4

% X: linhas, Y: colunas
dimensoes( X, Y ) :-
	X is 3,
	Y is 3.

% percepcao( [Linha, Coluna], [percepcao1, percepcao2,...])
% Mundo: P (Poço), T(Tesouro), . (nada)
%     X  X  X
% l/c 1  2  3
% Y 1  .  .  .
% Y 2  .  P  P
% Y 3  .  T  .
%percepcao( [1,1], nada,   nada ) :- !.
%percepcao( [2,1],brisa,   nada ) :- !.
%percepcao( [3,1], nada,   nada ) :- !.
%percepcao( [1,2],brisa,   nada ) :- !.
%percepcao( [2,2],brisa,   poco ) :- !.
%percepcao( [3,2],brisa,tesouro ) :- !.
%percepcao( [1,3],brisa,   nada ) :- !.
%percepcao( [2,3],brisa,   poco ) :- !.
%percepcao( [3,3],brisa,   nada ) :- !.
percepcao( [1,1], '.',   nada ) :- !.
percepcao( [2,1],'P?',   nada ) :- !.
percepcao( [3,1],'P?',   nada ) :- !.
percepcao( [1,2],'P?',   nada ) :- !.
percepcao( [2,2],'P?',   poco ) :- !.
percepcao( [3,2],'P?',   poco ) :- !.
percepcao( [1,3], '.',   nada ) :- !.
percepcao( [2,3],'P?',tesouro ) :- !.
percepcao( [3,3],'P?',   nada ) :- !.

percepcao( [X,Y],P ) :-
	percepcao( [X,Y],P,_ ).
