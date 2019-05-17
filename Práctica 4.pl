/*Predicado para la presentación*/
presenta:-
nl,nl,
write(' INSTITUTO TECNOLOGICO DE CELAYA'),nl,nl,nl,nl,
write(' ADICIONAR AL PRINCIPIO Y AL FINAL DE UNA LISTA'),nl,nl,nl,nl,
write(' MARIA DE JESUS HERNANDEZ MORALES'),nl,nl,nl,nl,
write(' Presione cualquier caracter seguido de punto.... '),
read(_),
menu.
/*Predicado para imprimir el menu principal*/
menu:-
nl,nl,
write(' MENU PRINCIPAL'), nl,nl,nl,
write('Append_head: a. '),nl,
write('Append_bottom: b.'),nl,
write('Salir: c.'),nl,nl,
write('Presiona[a,b, o c] Seguido de punto ... '),
read(Resp),
opcion(Resp).
/*Predicado para validar opciones del menu*/
opcion(Resp):- Resp='a',
nl,
write(' APPEND_HEAD'),nl,nl,
write(' Lista inicial: [a,b,c]'),nl,nl,
write(' Elemento a insertar en la lista seguido de punto'),nl,
write(' Resp: '),
read(Y),
append_head(Y,[a,b,c],Lista2),nl,nl,
write(' Lista final: '),
writelist(Lista2),nl,
%write('Presiona cualquier caracter seguido de punto ... '),
%read(_),
menu.
opcion(Resp):- Resp='b',
nl,
write(' APPEND_BOTTOM'),nl,nl,
write(' Lista inicial: [a,b,c]'),nl,nl,
write(' Elemento a insertar en la lista seguido de punto'),nl,
write(' Resp: '),
read(Y),
append_bottom(Y,[a,b,c],Lista2),nl,nl,
write(' Lista final: '),
writelist(Lista2),nl,
%write('Presiona cualquier caracter seguido de punto ... '),
%read(_),
menu.
opcion(Resp):- Resp='c',despedida.
opcion(Resp):- Resp \='a', Resp \='b', Resp \='c', menu.
/*PREDICADO DE DESPEDIDA*/
despedida:-
nl,nl,nl,
write(' Hasta luego'),nl,nl,nl,
write(' Presiona cualquier caracter seguido de punto ..'),
read(_).
/*PREDICADO PARA ADICIONAR AL FINAL DE LA LISTA*/
append_bottom(X,[],[X]).
append_bottom(X,[T1|R1],[T1|R2]):- append_bottom(X,R1,R2).
/*PREDICADO PARA ADICIONAR AL INICIO DE LA LISTA*/
append_head(X,[],[X]).
append_head(X,H1,[X|H1]).
/*PREDICADO PARA ESCRIBIR LA LISTA*/
writelist([]).
writelist([X|T]):-nl,write(X),nl,writelist(T).