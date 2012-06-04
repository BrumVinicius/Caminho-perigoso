% procedimentos para trabalhar com o historico
%legenda:
%	H - historico
%	Hi - historico inicial ( historico inicial )
%	Hf - historico final auxiliar ( lista para auxiliar na concatenacao )
%	Ha - historico auxiliar ( lista para auxiliar na concatenacao )
%	Hr - historico final
%	P - posicao
%	N - numero de nos de P nao visitados
%	C - coordenada de P
%	Calda - calda do historico

geraHistorico( H ) :-
	geraLista( H ).

adicionaHistorico( N,P,H,Hf ) :-
	concatenaLista( [[N,P]],H,Hf ).

retrocedeHistorico( Hi,Hf,Hr ) :-
	format( 'Hi: ~p\n',[Hi] ),
	format( 'Hf: ~p\n',[Hf] ),
	format( 'Hr: ~p\n',[Hr] ),
	Ha = Hf,
	removePrimeiroLista( Hi,P,Calda ) -> (
		format( 'Hi: ~p\n',[Hi] ),
		format( 'P: ~p\n',[P] ),
		format( 'Calda: ~p\n',[Calda] ),
		removePrimeiroLista( P,N,Caldap ),
		format( 'P: ~p\n',[P] ),
		format( 'N: ~p\n',[N] ),
		format( 'Caldap: ~p\n',[Caldap] ),
		removePrimeiroLista( Caldap,C,X ),
		format( 'Caldap: ~p\n',[Caldap] ),
		format( 'C: ~p\n',[C] ),
		format( 'X: ~p\n',[X] ),
		( N == 0 ) -> (
			format( 'C: ~p\n',[C] ),
			definePosicao( C,'?' ),
			retrocedeHistorico( Calda,Hf1,Hr )
		);Hr = Hi
	).
