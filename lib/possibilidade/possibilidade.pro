% procedimento para trabalhar com possibilidades

geraPossibilidades( [X,Y],L ) :-
	posicaoValida( [X,Y] ),
	vizinhanca( [X,Y],V ),
	geraLista( A ),
	verificaVizinhanca( V,A,L ).
