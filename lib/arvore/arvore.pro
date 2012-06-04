% procedimentos para trabalhar com a arvore
%legenda:
%	A - arvore
%	Af - arvore final
%	L - lista

geraArvore( A ) :-
	geraLista( A ).

removePrimeiroArvore( Ai,Pos,Af ) :-
	removePrimeiroLista( Ai,Pos,Af ).

adicionaNoArvore( L,A,Af ) :-
	concatenaLista( L,A,Af ).
