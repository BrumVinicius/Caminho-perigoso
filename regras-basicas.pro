% A diretiva dynamic nos permite utilizar os predicados seguintes
% nos predicados asserta, assertz, retract, retractall.
:- dynamic(mundo/2).

% altura: quantidade de linhas
altura( Y )         :- dimensoes( _,Y ).
% largura: quantidade de colunas
largura( X )        :- dimensoes( X,_ ).

% verifica se a posicao desejada existe no tabuleiro
posicaoValida( [PosX,PosY] ) :- PosX > 0, PosY > 0,
                                altura( A )  , PosY =< A,
			        largura( L ) , PosX =< L.

achouTesouro( Posicao ) :- percepcao(Posicao, _, tesouro), !.
morreu( Posicao )       :- percepcao(Posicao, _, poco), !.

% mundo - indica como está o mundo para seu agente
% ?  - não sabe nada sobre a posição
% .  - posicao limpa
% P? - dúvida de poço nesta posição
% P  - poço nesta posição
% T  - Tesouro nesta posição
mundo( [_,_], '?' ) :- !.
definePosicao(Pos, X) :- posicaoValida(Pos),
	                 ( X == ('?'); X == ('.') ;
                           X == ('P'); X == ('P?'); X == 'T'; X == 'A' ),
                         asserta( (mundo(Pos, X):-!) ), !.
% Regras para imprimir o mundo
imprimePosicao( X ) :-
	posicaoValida(X),
	mundo(X, R),
	format(" ~p ", [R]).

imprimeLin( [X,Y] ) :- 
	\+ posicaoValida( [X,Y] ), 
	!.
imprimeLin( [X,Y] ) :-
	imprimePosicao( [X,Y] ),
	X1 is X+1,
	imprimeLin( [X1,Y] ),
	!.

imprimeCol( [X,Y] ) :-
	\+ posicaoValida( [X,Y] ), 
	!.
imprimeCol( [X,Y] ) :- 
	imprimeLin( [X,Y] ), 
	write( '\n' ),
	Y1 is Y+1, 
	imprimeCol( [X,Y1] ), 
	!.

imprimeMundo :- 
	X is 1, 
	Y is 1, 
	imprimeCol( [X,Y] ).
