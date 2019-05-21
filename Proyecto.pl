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
    write("Instituto Tecnol�gico de Celaya"), nl,
    write("Sistema de diagnostico de enfermedades respiratorias"), nl,
    write("Aplicaci�n de encadenamiento hacia atr�s"), nl,
    write("Celaya, Guanajuato, M�xico"), nl,
    write("Presiona enter"),nl,
    get_char(_),
    write("Introducci�n"), nl,
    write("Este proyecto es un sistema experto de diagnostico de enfermedades respiratorias. Se usa un mecanismo de inferencia por encadenamiento hacia atr�s. A la lista de s�ntomas el usuario debe responder s/n. La opci�n de adicionar informaci�n a la base de conocimientos permitir� anexarla en el archivo enf.dbs.pl"), nl,
    write("Presiona enter"),nl,
    get_char(_),
        menu.

menu :-
    write("Men� principal"), nl,
    write("1.- Usar el sistema experto"), nl,
    write("2.- Actualizar base de hechos"), nl,
    write("3.- Salir"), nl,
    write("Presiona 1, 2 o 3 seguido de punto"),nl,
    read(Resp),
    opcion(Resp).

opcion(Resp) :-
    Resp=1,
    enferma,
    menu.

opcion(Resp) :-
    Resp=2,
    actualizar.

opcion(Resp) :-
    Resp=3,
    despedida.

opcion(Resp) :-
    Resp\=1,
    Resp\=2,
    Resp\=3,
    write("Presiona enter"),nl,
    get_char(_),
    menu.

despedida :-
    write("Bye"), nl,
    write("Presiona enter"),nl,
    get_char(_).

actualizar:-
    not(introducir),
    menu.

enferma:-
    assertz(si(end)),
    assertz(no(end)),
    write("Di�logo de diagnostico"),nl,
    write("< Responde << s/n >> >"),nl,
    not(preguntar()),
    purgar.

enferma:-
    write("�No se encuentran enfermedades con los s�ntomas dados en la base de conocimientos!"),nl,
    write("Presiona enter"),nl,
    get_char(_),
    purgar.

introducir:-
    write("�Qu� enfermedad es? <<minusculas>>"),nl,
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
    write("S�ntoma <<para terminar fin>>:"),nl,
    write("Respuesta:"),nl,
    read(Attribute),
    Attribute\=fin,
    a�adir(Attribute,List,List2),
    atributos(O,List2).

atributos(O,List):-
    agregar_enf(O, List),
    writelist(List), nl.

a�adir(X,L,[X|L]).

preguntar():-
    enf(O,A),
    anterioresno(A),
    intentar(O,A),
    nl,write(O),
    write(" tiene los s�ntomas presentados: "),writelist(A),nl,
    write("Buscando otra enfermedad..."),nl,
    write("Presiona enter"),nl,
    get_char(_),
    fail.

anterioresno(A):-
    no(T),!,
    xanterioresno(T,A,[]),!.

xanterioresno(end,_,_):- !.

xanterioresno(T,A,L):-
    not(miembro(T,A)),!,
    a�adir(T,L,L2),
    no(X), not(miembro(X,L2)),!,
    xanterioresno(X,A,L2).

intentar(O,[]).

intentar(O,[X|T]):-
    si(X),!,
    intentar(O,T).

intentar(O,[X|T]):-
    write("S�ntoma: "),write(X),write(" "),nl,
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
    write("S�ntoma:"),write(X),write("?"),nl,
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

writelist([]).
writelist([Head|Tail]):-
    write(Head),write(" "),writelist(Tail).

miembro(N,[N|_]).
miembro(N,[_|T]):-miembro(N,T).