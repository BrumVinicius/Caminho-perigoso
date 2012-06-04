%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% procedimentos para auxiliar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vida %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setVida( Vida ) :-
	asserta( ( vida( Vida ) :- ! ) ).
getVida( Vida ) :-
	vida( Vida ).
subVida :-
	getVida( Vida ),
	NovaVida is Vida - 1,
	setVida( NovaVida ).

% Arvore %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setArvore( Arvore ) :-
	asserta( ( arvore( Arvore ) :- ! ) ).
getArvore( Arvore ) :-
	arvore( Arvore ).
addArvore( Possibilidades ) :-
	getArvore( ArvoreAnterior ),
	concatenaLista( Possibilidades,ArvoreAnterior,NovaArvore ),
	setArvore( NovaArvore ).
removePrimeiroArvore( Posicao ) :-
	getArvore( Arvore ),
	removePrimeiroLista( Arvore,Posicao,NovaArvore ),
%	write( '\nNovaArvore: ' ),
%	format( ' ~p ',[NovaArvore] ),
%	write( '\n\n' ),
	setArvore( NovaArvore ).

% Posicao Atual %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setPosicaoAtual( Posicao ) :-
	asserta( ( posicaoAtual( Posicao ) :- ! ) ).
getPosicaoAtual( Posicao ) :-
	posicaoAtual( Posicao ).

% Historico %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setHistorico( Historico ) :-
	asserta( ( historico( Historico ) :- ! ) ).
getHistorico( Historico ) :-
	historico( Historico ).
addHistorico( Posicao,Grau ) :-
	getHistorico( HistoricoAnterior ),
	concatenaLista( [[Posicao,Grau]],HistoricoAnterior,NovoHistorico ),
	setHistorico( NovoHistorico ).

% Possibilidades %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setPossibilidades( Possibilidades ) :-
	asserta( ( possibilidades( Possibilidades ) :- ! ) ).
getPossibilidades( Possibilidades ) :-
	possibilidades( Possibilidades ).
defPossibilidadesMundo( Percepcao,Possibilidades ) :-
%	write( '\ndefPossibilidadesMundo...\n' ),
%	format( ' Percepcao.....: ~p \n',[Percepcao] ),
%	format( ' Possibilidades: ~p \n',[Possibilidades] ),
	removePrimeiroLista( Possibilidades,Posicao,NovasPossibilidades ),
%	format( ' Posicao............: ~p \n',[Posicao] ),
%	format( ' NovasPossibilidades: ~p \n',[NovasPossibilidades] ),
	definePosicao( Posicao,Percepcao ),
	defPossibilidadesMundo( Percepcao,NovasPossibilidades ).
	
% Inicializa o jogo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comeca_jogo :-
	write( '\n\tINICIALIZA_JOGO' ),
	setVida( 5 ),
	setArvore( [[1,1]] ),
	setPosicaoAtual( [1,1] ),
	setHistorico( [] ),
	setPossibilidades( [] ),
	inicia_agente.

% Inicia o agente %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inicia_agente :-
	write( '\n\tINICIA_AGENTE\n\n' ),
	getArvore( A ),
	format( '\nArvore: ~p \n',[A] ),
	getHistorico( B ),
	format( '\nHistorico: ~p \n',[B] ),
	getVida( C ),
	format( '\nVida: ~p \n',[C] ),
	removePrimeiroArvore( Posicao ),
	definePosicao( Posicao,'A' ),
	setPosicaoAtual( Posicao ),
	imprimeMundo,
	achouTesouro( Posicao ) -> (
		write( '\n\n\tEncontrou o ouro!!!\n\n' )
	);(
		write( '\n\n\tNao encontrou o ouro!!!\n\n' ),
		getPosicaoAtual( Posicao ),
		morreu( Posicao ) -> (
			write( '\n\n\tMorreu!!!\n\n' ),
			getVida( Vida ),
			( Vida == 0 ) -> (
				write( '\n\n\tGame-over!!!\n\n' )
			);(
% se morreu e ainda tem vida... define o poco no mundo... retrocedeHistorico
				write( '\n\n\tAinda tem vida!!!\n\n' ),
				getPosicaoAtual( Posicao ),
				subVida,
				geraPossibilidades( Posicao,Possibilidades ),
				setPossibilidades( Possibilidades ),
				getTamanhoLista( Possibilidades,Tamanho ),
				G is Tamanho - 1,
				addHistorico( Posicao,G ),
				( Tamanho == 0 ) -> (
					getHistorico( Historico ),
					retrocedeHistorico( Historico,Ha,HistoricoFinal ),
					setHistorico( HistoricoFinal ),
					inicia_agente
				);(
					getPossibilidades( Possibilidades ),
					addArvore( Possibilidades ),
					inicia_agente
				)
			)
		);(
			write( '\n\n\tNao morreu!!!\n\n' ),
			getPosicaoAtual( Posicao ),
			geraPossibilidades( Posicao,Possibilidades ),
			setPossibilidades( Possibilidades ),
			getTamanhoLista( Possibilidades,Tamanho ),
			G is Tamanho - 1,
			addHistorico( Posicao,G ),
			( Tamanho == 0 ) -> (
				write( '\n\n\tFolha!!!\n\n' ),
				getHistorico( Historico ),
				retrocedeHistorico( Historico,Ha,HistoricoFinal ),
				setHistorico( HistoricoFinal )
%				inicia_agente
			);(
				write( '\n\nNao eh folha!!!\n\n' ),
				getPossibilidades( PossibilidadesAux ),
				addArvore( PossibilidadesAux ),
				percepcao( Posicao,Percepcao ),
				defPossibilidadesMundo( Percepcao,PossibilidadesAux );
				imprimeMundo,
				inicia_agente
			)
		)
	).
