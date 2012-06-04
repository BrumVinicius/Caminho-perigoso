% Mundo inicial a ser utilizado no trabalho
% Para mundos maiores, sigam esse modelo
% by Jeiks
%

carregaMundo :-
	consult( 'mundo.pro' ).

carregaRegras :-
	consult( 'regras-basicas.pro' ).

carregaLista :-
	consult( './lib/lista/lista.pro' ).

carregaVizinhanca :-
	consult( './lib/vizinhanca/vizinhanca.pro' ).

carregaPossibilidade :-
	consult( './lib/possibilidade/possibilidade.pro' ).

carregaArvore :-
	consult( './lib/arvore/arvore.pro' ).

carregaHistorico :-
	consult( './lib/historico/historico.pro' ).

carregaVida :-
	consult( './lib/vida/vida.pro' ).

carregaPrincipal :-
	consult( 'principal.pro' ).

carregaInicializa :-
	consult( 'inicializa.pro' ).

carregaTudo :-
	carregaMundo,
	carregaRegras,
	carregaLista,
	carregaVizinhanca,
	carregaPossibilidade,
	carregaArvore,
	carregaHistorico,
	carregaVida,
	carregaPrincipal,
	carregaInicializa.

:- initialization( carregaTudo ).
