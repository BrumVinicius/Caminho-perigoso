% testes com vida...

testeVida :-
	geraVida( V,5 ),
	write( 'numero vidas: ' ),
	format( ' ~p ',[V] ),
	decrementaVida( V,Vf ),
	write( '\nnumero vidas: ' ),
	format( ' ~p ',[Vf] ).
