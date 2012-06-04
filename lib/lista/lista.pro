% procedimentos para trabalhar com lista
% fonte: http://es.wikipedia.org/wiki/Prolog
% legenda:
%	H* - cabeca
%	T* - cauda
%	L* - tamanho
%	A* - lista

geraLista( L ) :-
	L = [].

getTamanhoLista( [],0 ).
getTamanhoLista( [_|T],L ) :-
	getTamanhoLista( T,L1 ),
	L is L1 + 1.

pesquisaLista( H,[H|_] ) :- !.
pesquisaLista( H,[_|T] ) :-
	pesquisaLista( H,T ).

removePrimeiroLista( [H|T],H1,T1 ) :-
	H1 = H,
	removeLista( H1,[H|T],T1 ).

removeLista( H1,[H1|T],T ) :- !.
removeLista( H1,[H|T],[H|T1] ) :-
	removeLista( H1,T,T1 ).

concatenaLista( [],A,A ).
concatenaLista( [H|A1],A2,[H|A3] ) :-
	concatenaLista( A1,A2,A3 ).
