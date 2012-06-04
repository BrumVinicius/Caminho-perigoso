% procedimento para trabalhar com vizinhanca
% legenda:
% 	P = posicao...
% 	? = vizinhanca...
%	Vi = vizinhanca inicial ( todos os vizinhos da posicao, sem considerar se o vizinho esta ocupado )
%	Vf = vizinhanca final auxiliar ( lista para auxiliar na concatenacao )
%	Va = vizinhanca auxiliar ( lista para auxiliar na concatenacao )
%	Vr = vizinhanca final ( todos os vizinhos da posicao que nao foram ocupado )
%	D = o que foi definido no mundo ( 'P','P?','T','.','?' )
%	T = tamanho da lista
%	C = cauda da lista
%
% ------------ ------------ ------------
%| P = [1,1]  | P = [2,1]  | P = [3,1]  |
%|   X  X  X  |   X  X  X  |   X  X  X  |
%| Y P  ?  .  | Y ?  P  ?  | Y .  ?  P  |
%| Y ?  .  .  | Y .  ?  .  | Y .  .  ?  |
%| Y .  .  .  | Y .  .  .  | Y .  .  .  |
% ------------ ------------ ------------
%| P = [1,2]  | P = [2,2]  | P = [3,2]  |
%|   X  X  X  |   X  X  X  |   X  X  X  |
%| Y ?  .  .  | Y .  ?  .  | Y .  .  ?  |
%| Y P  ?  .  | Y ?  P  ?  | Y .  ?  P  |
%| Y ?  .  .  | Y .  ?  .  | Y .  .  ?  |
% ------------ ------------ ------------
%| P = [1,3]  | P = [2,3]  | P = [3,3]  |
%|   X  X  X  |   X  X  X  |   X  X  X  |
%| Y .  .  .  | Y .  .  .  | Y .  .  .  |
%| Y ?  .  .  | Y .  ?  .  | Y .  .  ?  |
%| Y P  ?  .  | Y ?  P  ?  | Y .  ?  P  |
% ------------ ------------ ------------

vizinhanca( [1,1],[ [1,2],[2,1]             ] ) :- !.
vizinhanca( [2,1],[ [2,2],[3,1],[1,1]       ] ) :- !.
vizinhanca( [3,1],[ [3,2],[2,1]             ] ) :- !.
vizinhanca( [1,2],[ [1,3],[2,2],[1,1]       ] ) :- !.
vizinhanca( [2,2],[ [2,3],[3,2],[2,1],[1,2] ] ) :- !.
vizinhanca( [3,2],[ [3,3],[3,1],[2,2]       ] ) :- !.
vizinhanca( [1,3],[ [2,3],[1,2]             ] ) :- !.
vizinhanca( [2,3],[ [3,3],[2,2],[1,3]       ] ) :- !.
vizinhanca( [3,3],[ [3,2],[2,3]             ] ) :- !.

verificaVizinhanca( Vi,Vf,Vr ) :-
	Va = Vf,
	removePrimeiroLista( Vi,V,C ) -> (
		mundo( V,D ),
		(
			( D == 'A';D == 'P' ) -> concatenaLista( [],Va,Vf1 );concatenaLista( [V],Va,Vf1 )
		),
		verificaVizinhanca( C,Vf1,Vr )
	);Vr = Vf.
