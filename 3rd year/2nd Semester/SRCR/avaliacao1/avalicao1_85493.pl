%-----------------------------------------------------------------------------------------
% NOME: Pedro Alexandre Gonçalves Ribeiro ------------------------------------------------
% NÚMERO MECANOGRÁFICO: a85493 -----------------------------------------------------------
% CURSO: Mestrado Integrado em Engenharia Informática - 3º ano ---------------------------
%-----------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------
% SICStusPROLOG:Declaracoesiniciais ------------------------------------------------------
%-----------------------------------------------------------------------------------------

:-set_prolog_flag(discontiguous_warnings,off).
:-set_prolog_flag(single_var_warnings,off).
:-set_prolog_flag(unknown,fail).

%-----------------------------------------------------------------------------------------
% SICStusPROLOG:definicoesiniciais -------------------------------------------------------
%-----------------------------------------------------------------------------------------

:-op(900,xfy,'::').
:-dynamic pai/2.
:-dynamic mae/2.
:-dynamic nascimento/2.
:-dynamic excecao/1.

%-----------------------------------------------------------------------------------------
% UTILITIES ------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),
    !,
    fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%-----------------------------------------------------------------------------------------
% Testa se uma proposição consta da Base de Conhecimento ---------------------------------
%-----------------------------------------------------------------------------------------

nao( Q ) :-
    Q, !, fail;
    true.

%-----------------------------------------------------------------------------------------
% Sistema de inferência ------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

demo( Q,verdadeiro ) :-
    Q,
    nao(excecao(Q)),
    nao(nao(Q)).
demo( Q,falsa ) :-
    nao(Q).
    nao( excecao( Q ) ).
demo( Q,desconhecido ) :-
    excecao( Q ).

%-----------------------------------------------------------------------------------------
% INVARIANTES ---------------------------------------------------------------------------- 
%-----------------------------------------------------------------------------------------

+pai( Pai,Filho ) :: (solucoes( (Filho),(pai(P, Filho)), S),
                    comprimento( S,N ),
                    N =< 1).

+mae( Mae,Filho ) :: (solucoes( (Filho),(mae(M, Filho)), S),
                    comprimento( S,N ),
                    N =< 1).

+nascimento( Pessoa,Data ) :: (solucoes( (Pessoa), (nascimento( Pessoa,D )), S),
                               comprimento( S,N ),
                               N =< 1).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 1 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( abel,ana ).
mae( alice,ana ).
nascimento( ana,(1,1,2010) ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 2 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( antonio,anibal ).
mae( alberta,anibal ).
nascimento( anibal,(2,1,2010) ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 3 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( bras,berta ).
mae( belem,berta ).
pai( bras,berto ).
mae( belem,berto ).
nascimento( berta,(2,2,2010) ).
nascimento( berto,(2,2,2010) ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 4 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

nascimento( catia,(3,3,2010) ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 5 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

mae( catia,cirspim ).
excecao(pai( celso,crispim )).
excecao(pai( caio,crispim )).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 6 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( daniel,danilo ).
nascimento( danilo,(4,4,2010) ).

pai( niDanilo,danilo ).
nuloIncerto( niDanilo ).
excecao(pai(P,F)) :- pai( niDanilo,F ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 7 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( elias,eurico ).
mae( elsa,eurico ).
excecao(nascimento( eurico,(5,5,2010) )).
excecao(nascimento( eurico,(15,5,2010) )).
excecao(nascimento( eurico,(25,5,2010) )).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 8 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

excecao(pai( fausto,fabia )).
excecao(pai( fausto,octavia )).
excecao(mae( niFabiaOctavia,fabia )).
excecao(mae( niFabiaOctavia,octavia )).
nuloIncerto( niFabiaOctavia ).
excecao(pai(P,F)):- pai( niFabiaOctavia,F ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 9 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

pai( guido,golias ).
mae( guida,golias ).

nascimento( golias,ninterditoGolias ).
nuloInterdito( ninterditoGolias ).
nao(nascimento( Pessoa,Data )) :-
        nascimento( Pessoa,ninterditoGolias ).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 10 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

excecao(nascimento(Pessoa,Data)) :- 
        Pessoa=helder, 
        Data =:= (8,8,2010).

%-----------------------------------------------------------------------------------------
% EXERCÍCIO 11 ----------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------

excecao(nascimento( ivo,(Dia,Mes,Ano) )) :-
        (Dia >= 1, Dia =< 15),
        Mes = 6,
        Ano = 2020.