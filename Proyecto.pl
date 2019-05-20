:- module(
  sistema,
  [
    agregar_enf/2, % +Nombre:atom, +Sintomas:List
    enf_bd/2 % ?Nombre:atom, ?Sintomas:List
  ]
).

:- use_module(library(persistency)).

:- persistent(enf(nombre:atom, sintomas:List)).

:- initialization(db_attach('enf.dbs.pl', [])).

agregar_enf(Nombre, Sintomas):-
  with_mutex(enfermedades_bd, assert_enf(Nombre, Sintomas)).

enf_bd(Nombre, Sintomas):-
  with_mutex(enfermedades_bd, enf(Nombre, Sintomas)).

presenta :-
    write("Instituto Tecnológico de Celaya"), nl,
    write("Sistema de diagnostico de enfermedades respiratorias"), nl,
    write("Aplicación de encadenamiento hacia atrás"), nl,
    write("Celaya, Guanajuato, México"), nl,
    write("Presiona enter"),nl,
    get_char(_),
    write("Introducción"), nl,
    write("Este proyecto es un sistema experto de diagnostico de enfermedades respiratorias. Se usa un mecanismo de inferencia por encadenamiento hacia atrás. A la lista de síntomas el usuario debe responder s/n. La opción de adicionar información a la base de conocimientos permitirá anexarla en el archivo enf.dbs.pl"), nl,
    write("Presiona enter"),nl,
    get_char(_),
        menu.

menu :-
    write("Menú principal"), nl,
    write("1.- Usar el sistema experto"), nl,
    write("2.- Salir"), nl,
    write("Presiona 1 o 2 seguido de punto"),nl,
    read(Resp),
    opcion(Resp).

opcion(Resp) :-
    Resp=1,
    enferma,
    menu.

opcion(Resp) :-
    Resp=2,
    despedida.

opcion(Resp) :-
    Resp\=1,
    Resp\=2,
    write("Presiona enter"),nl,
    get_char(_),
    menu.

despedida :-
    write("Bye"), nl,
    write("Presiona enter"),nl,
    get_char(_).

enferma:-
    assert(si(end)),
    assert(no(end)),
    write("¿Introducirá información? <<s/n>>: "),nl,
    write("Respuesta:"),nl,
    read(A),
    A=s,
    not(introducir),!,
    write("Diálogo de diagnostico"),nl,
    write("< Responde <<s/n>> >"),nl,
    preguntar([]).

enferma:-
    write("Diálogo de diagnostico"),nl,
    write("< Responde << s/n >> >"),nl,
    preguntar([]),
    purgar.

enferma:-
    write("¡No se encuentran enfermedades con los síntomas dados en la base de conocimientos!"),nl,
    write("Presiona enter"),nl,
    get_char(_),
    purgar.

introducir:-
    write("¿Qué enfermedad es? <<minusculas>>"),nl,
    write("Respuesta:"),nl,
    read(Object),
    Object\=fin,
    write("Enfermedad < "), write(Object), write(" >"),nl,
    atributos(Object,[]),
    write("Otra enfermedad <<s/n>> ?"),nl,!,
    write("Respuesta:"),nl,
    read(Q),Q=s,
    introducir.

atributos(O,List):-
    write("Síntoma <<para terminar fin>>:"),nl,
    write("Respuesta:"),nl,
    read(Attribute),
    Attribute\=fin,
    añadir(Attribute,List,List2),
    atributos(O,List2).

atributos(O,List):-
    agregar_enf(O, List),
    writelist(List,1),!,nl.

añadir(X,L,[X|L]).
preguntar(L):-
    enf_bd(O,A),
    not(miembro(O,L)),
    añadir(O,L,L2),
    anterioressi(A),
    anterioresno(A),
    intentar(O,A),
    !,nl,write(O),nl,
    write(" tiene los síntomas presentados"),nl,
    write("Buscando otra enfermedad..."),nl,
    write("Presiona enter"),nl,
    get_char(_),nl,
    preguntar(L2).

anterioressi(A):-
    si(T),!,
    xanterioressi(T,A,[]),!.

xanterioressi(end,_,_):- !.

xanterioressi(T,A,L):-
    miembro(T,A),!,
    añadir(T,L,L2),
    si(X), not(miembro(X,L2)),!,
    xanterioressi(X,A,L2).

anterioresno(A):-
    no(T),!,
    xanterioresno(T,A,[]),!.

xanterioresno(end,_,_):- !.

xanterioresno(T,A,L):-
    miembro(T,A),!,
    añadir(T,L,L2),
    no(X), not(miembro(X,L2)),!,
    xanterioresno(X,A,L2).

intentar(O,[]).

intentar(O,[X|T]):-
    si(X),!,
    intentar(O,T).

intentar(O,[X|T]):-
    write("Síntoma: "),write(X),write(" "),nl,
    read(Q),
    procesar(O,X,Q),!,
    intentar(O,T).

procesar(_,X,s):-
    asserta(si(X)),!.
procesar(_,X,n):-
        asserta(no(X)),!,fail.

procesar(O,X,why):-
    write("Creo que puede ser "),nl,
    write(O," porque tiene: "),nl,
    si(Z), xwrite(Z),nl,
    Z=end,!,
    write("Síntoma:"),write(X),write("?"),nl,
    read(Q),
    procesar(O,X,Q),!.

xwrite(end).
xwrite(Z):- write(Z).

purgar :-
    retract(si(X)),
    X=end, fail.

purgar :-
    retract(no(X)),
    X=end.

juntar([],List,List).
juntar([X|L1],List2,[X|L3]):- juntar(L1,List2,L3).

writelist([],_).
writelist([Head|Tail],3):-
    write(Head),nl,writelist(Tail,1).

writelist([Head|Tail],1):-N=1+1,
    write(Head),write(" "), writelist(Tail,N).

miembro(N,[N|_]).
miembro(N,[_|T]):-miembro(N|T).