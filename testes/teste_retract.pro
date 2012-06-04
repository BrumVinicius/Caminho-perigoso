
addPosicao( Pos ) :-
	asserta( ( posicao( Pos ) :- ! ) ),
	posicao( Pos ),
	format( ' ~p ',[Pos] ).

addArvore( Arvore ) :-
	asserta( ( arvore( Arvore ) :- ! ) ),
	format( ' ~p ',[Arvore] ),
	arvore( A ),
	format( ' ~p ',[A] ).