% procedimentos para trabalhar com a vida
%legenda:
%	V - arvore
%	N - numero de vidas

geraVida( V,N ) :-
	V is N.

decrementaVida( V,Vf ) :-
	Vf is V - 1.
