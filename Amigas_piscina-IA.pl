/*Aluno: Fabrício Hiury da Costa Féo
RA: 22251807
Link do desafio do racha cuca: https://rachacuca.com.br/logica/problemas/amigas-na-piscina/#:~:text=Quatro%20amigas%20combinaram%20de%20aproveitar,gostos%20e%20as%20caracter%C3%ADsticas%20delas.*/

     %Maiô
     maio(amarelo).
     maio(azul).
     maio(branco).
     maio(verde).

     %Nomes
     nome(ana).
     nome(bruna).
     nome(raquel).
     nome(vivian).

     %Idade
     idade(8).
     idade(9).
     idade(10).
     idade(11).

     %Suco
     suco(laranja).
     suco(limao).
     suco(maracuja).
     suco(morango).

     %Protetor
     protetor(fps40).
     protetor(fps45).
     protetor(fps50).
     protetor(fps55).

     %Animal
     animal(cachorro).
     animal(gato).
     animal(passaro).
     animal(peixe).

%alldifferent = variaveis da lista com valores diferentes

alldifferent([]). %lista vazia
alldifferent([Elemento|Lista]):-
      not(member(Elemento,Lista)),% retorna TRUE se o elemento NÃO for membro da lista
      alldifferent(Lista).

modelo([
        (Maio_1, Nome_1,Idade_1,Suco_1, Protetor_1,Animal_1),
        (Maio_2, Nome_2,Idade_2,Suco_2,Protetor_2,Animal_2),
        (Maio_3, Nome_3,Idade_3,Suco_3,Protetor_3,Animal_3),
        (Maio_4, Nome_4,Idade_4,Suco_4,Protetor_4,Animal_4)
       ]) :-

animal(Animal_1),
animal(Animal_2),
animal(Animal_3),
animal(Animal_4),
%Na terceira posição está a menina que gosta de Cachorros.

(Animal_3==cachorro),
%Quem gosta de Peixes está em uma das pontas.

(Animal_1==peixe; Animal_4==peixe),
%A garota que gosta de Gatos está na primeira posição.

(Animal_1==gato),
alldifferent([Animal_1, Animal_2, Animal_3,Animal_4]),
%Na segunda posição está a menina que usa filtro solar com FPS 55.

protetor(Protetor_1),
protetor(Protetor_2),
protetor(Protetor_3),
protetor(Protetor_4),

(Protetor_2==fps55),
alldifferent([Protetor_1, Protetor_2, Protetor_3, Protetor_4]),

suco(Suco_1),
suco(Suco_2),
suco(Suco_3),
suco(Suco_4),
%Quem gosta de suco de Morango está na quarta posição.

(Suco_4==morango),
%Quem gosta de suco de Laranja está em uma das pontas.

(Suco_1==laranja;Suco_4==laranja),
%A menina que gosta de limonada está ao lado da que gosta de
%suco de Maracujá.

(
(Suco_1==maracuja, Suco_2==limao);
(Suco_2==maracuja, (Suco_1==limao;Suco_3==limao));
(Suco_3==maracuja, (Suco_2==limao; Suco_4==limao));
(Suco_4==maracuja, Suco_3==limao)
),
alldifferent([Suco_1,Suco_2,Suco_3,Suco_4]),
%A menina que gosta de suco de Maracujá está ao lado da que gosta de
%Pássaros

(
(Suco_1==maracuja, Animal_2==passaro);
(Suco_2==maracuja, (Animal_1==passaro; Animal_3==passaro));
(Suco_3==maracuja, (Animal_2==passaro;Animal_4==passaro));
(Suco_4==maracuja, Animal_3==passaro)
),

idade(Idade_1),
idade(Idade_2),
idade(Idade_3),
idade(Idade_4),

%A garota de 8 anos está na quarta posição.

(Idade_4==8),
%A garota de 11 anos está em uma das pontas.

(Idade_1==11; Idade_4==11),
alldifferent([Idade_1,Idade_2,Idade_3,Idade_4]),
%A garota mais nova está ao lado da que usa protetor solar de menor FPS.

(Protetor_3==fps40, Idade_4==8),

nome(Nome_1),
nome(Nome_2),
nome(Nome_3),
nome(Nome_4),

%Raquel está na primeira posição.

(Nome_1==raquel),
alldifferent([Nome_1,Nome_2,Nome_3,Nome_4]),
%Vivian gosta de Pássaros.

(
(Nome_1==vivian, Animal_1==passaro);
(Nome_2==vivian, Animal_2==passaro);
(Nome_3==vivian, Animal_3==passaro);
(Nome_4==vivian, Animal_4==passaro)
),
%Ana usa protetor solar de FPS 50.

(
(Nome_1==ana, Protetor_1==fps50);
(Nome_2==ana, Protetor_2==fps50);
(Nome_3==ana, Protetor_3==fps50);
(Nome_4==ana, Protetor_4==fps50)
),

maio(Maio_1),
maio(Maio_2),
maio(Maio_3),
maio(Maio_4),
%A menina de maiô Verde está na quarta posição.

(Maio_4==verde),
%A menina de maiô Branco está em uma das pontas.

(Maio_1==branco),
alldifferent([Maio_1,Maio_2,Maio_3,Maio_4]),
%A menina de maiô Azul está em algum lugar à esquerda da menina de 9
%anos

(
(Maio_1==azul,Idade_2==9);
(Maio_2==azul,Idade_3==9);
(Maio_3==azul,Idade_4==9)
),

nl,
write('ESSA É A RESPOSTA!').

imprime_lista([]):- write('\n\n------ FIM ------\n').
imprime_lista([H|T]):-
	write('\n......................................\n'),
	write(H), write(' : '),
              imprime_lista(T).

main :-
    statistics(cputime,Tempo_inicial),

   modelo(  [Coluna1, Coluna2, Coluna3, Coluna4]  ),

   imprime_lista(  [Coluna1, Coluna2, Coluna3, Coluna4]  ),

   statistics(cputime ,Tempo_final),
   Tempo_BUSCA is Tempo_final - Tempo_inicial,

   format('\n Tempo inicial: ~2f \t Tempo final: ~2f  msec', [Tempo_inicial, Tempo_final]),
    format('\n Tempo total: ~2f  msec', Tempo_BUSCA).
