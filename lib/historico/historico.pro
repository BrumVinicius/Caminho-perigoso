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
	Ha = Hf,
	removePrimeiroLista( Hi,P,Calda ) -> (
		removePrimeiroLista( P,C,Caldap ),
		removePrimeiroLista( Caldap,N,X ),
		( N == 0 ) -> (
			definePosicao( C,'.' ),
			imprimeMundo,
			retrocedeHistorico( Calda,Hf1,Hr )
		);(
			removePrimeiroLista( Hi,Cabeca,Calda ),
			removePrimeiroLista( Cabeca,Posicao,Caldac ),
			removePrimeiroLista( Caldac,Grau,X ),
			NovoGrau is Grau - 1,
			setHistorico( Calda ),
			addHistorico( Posicao,NovoGrau ),
			getHistorico( Hr )
		)
	).
