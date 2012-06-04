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
	removePrimeiroLista( Possibilidades,Posicao,NovasPossibilidades ),
	definePosicao( Posicao,Percepcao ),
	defPossibilidadesMundo( Percepcao,NovasPossibilidades ).
	
% Inicializa o jogo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comeca_jogo( NumeroVidas ) :-
	setVida( NumeroVidas ),
	setArvore( [[1,1]] ),
	setPosicaoAtual( [1,1] ),
	setHistorico( [] ),
	setPossibilidades( [] ),
	getArvore( A ),
	getPosicaoAtual( P ),
	getHistorico( H ),
	getPossibilidades( Possibilidades ),
	write( '\nINICIALIZANDO_JOGO...\n' ),
	format( '\tNumero de vidas..: ~p\n',[NumeroVidas] ),
	format( '\tArvore inicial...: ~p\n',[A] ),
	format( '\tPosicao Atual....: ~p\n',[P] ),
	format( '\tHistorico inicial: ~p\n',[H] ),
	format( '\tPossibilidades...: ~p\n',[Possibilidades] ),
	write( 'INICIANDO_AGENTE...\n' ),
	inicia_agente.

% Inicia o agente %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inicia_agente :-
	getArvore( A ),
	getHistorico( B ),
	getVida( C ),
	write( '\n\tMOVIMENTO DO AGENTE\n' ),
	format( 'Arvore...: ~p \n',[A] ),
	format( 'Historico: ~p \n',[B] ),
	format( 'Vida.....: ~p \n\n',[C] ),
	removePrimeiroArvore( Posicao ),
	definePosicao( Posicao,'A' ),
	setPosicaoAtual( Posicao ),
	imprimeMundo,
	achouTesouro( Posicao ) -> (
		write( '\n\tEncontrou o ouro!!!' ),
		format( '\n\tO tesouro estava escondido na posicao ~p\n\n',[Posicao] ),
		definePosicao( Posicao,'T' ),
		imprimeMundo
	);(
		write( '\n\tNao encontrou o ouro!!!' ),
		getPosicaoAtual( Posicao ),
		morreu( Posicao ) -> (
			write( '\n\tMorreu!!!' ),
			subVida,
			getVida( Vaux ),
			Vaux == 0 -> (
				write( '\n\tGame-Over!!!\n\n' )
			);(
				getVida( Vaux ),
				format( '\n\tMas ainda tem ~p vida(s)!!!\n\n',[Vaux] )
			),
			getPosicaoAtual( Posicao ),
			definePosicao( Posicao,'P' ),
			getHistorico( Historico ),
			retrocedeHistorico( Historico,Ha,HistoricoFinal ),
			setHistorico( HistoricoFinal ),
			inicia_agente
		);(
			write( '\n\tNao morreu!!!' ),
			getPosicaoAtual( Posicao ),
			geraPossibilidades( Posicao,Possibilidades ),
			setPossibilidades( Possibilidades ),
			getTamanhoLista( Possibilidades,Tamanho ),
			G is Tamanho - 1,
			addHistorico( Posicao,G ),
			( Tamanho == 0 ) -> (
				write( '\n\tTem certeza que definiu a posicao do tesouro?' ),
				write( '\n\tVerifique a definição do mundo!!!'),
				getHistorico( Historico ),
				retrocedeHistorico( Historico,Ha,HistoricoFinal ),
				setHistorico( HistoricoFinal )
			);(
				write( '\n\tAinda nao chegou numa folha!!!\n\n' ),
				getPossibilidades( PossibilidadesAux ),
				addArvore( PossibilidadesAux ),
				getPosicaoAtual( Posicao ),
				percepcao( Posicao,Percepcao ),
				defPossibilidadesMundo( Percepcao,PossibilidadesAux );
				imprimeMundo,
				inicia_agente
			)
		)
	).
