/* Predicado para la presentación*/
presenta:-
nl,nl,
write(' BUSQUEDA EN PROFUNDIDAD: DEPTH SEARCH '),nl,nl,nl,
write(' ARBOL DE BUSQUEDA: Enfermedades pulmonares'), nl,nl,nl,nl,
write(' Se informa la ruta seguida: enfermedades y peso'),nl,nl,
write(' Presione cualquier caracter seguido de punto..'),
read(_),
nl, menu.
/* Predicado del menu principal */
menu:-
database,
nl,nl,
write(' MENU PRINCIPAL'), nl,nl,nl,
write(' a. Depth Search'),nl,
write(' b. Salir'),nl,nl,nl,
write(' Presiona <a.> o <b.>..'),
read(Resp),
opcion(Resp).
/* Predicado para validar opciones del menu */
opcion(Resp):- Resp='a', nl, enf_enc.
opcion(Resp):- Resp='b', nl, despedida.
opcion(Resp):- Resp\='a',Resp\='b', menu.
/* Predicado de despedida */
despedida:-
nl,nl,
write(' BYE ....').
/* Predicado para preguntar la enfermedad base y la derivada */
enf_enc:-
write('Enfermedad Base <<Minusculas>>: '),
read(Eb),nl,
write('Enfermedad Derivada <<Minusculas>>: '),
read(Ed),nl,
enf_rut(Eb,Ed,R),nl,
write('EL PESO DE LA RUTA ES: '),
write(R),
not(enf_display),
write('Presiona cualquier caracter seguido de punto: '),
read(_), menu.
/* Predicado para encontrar la ruta de conexión entre las enfermedades */
enf_rut(Eb,Ed,R):-
enf_es(Eb,Ed,R).
/* Predicado para informar de fallas */
enf_rut(_,_,R):-
nl,
write('¡NO HAY RELACION ENTRE ESTAS ENFERMEDADES!'),nl,nl,nl,
write('Presiona cualquier caracter seguido de punto: '),
read(_),
R is 0, enf_eliminar,menu.
/* Predicado para verificar la relación entre dos enfermedades */
enf_es(Eb,Ed,R):-
enf(Eb,Ed,R),
enf_agregar(Eb).
/* HACER PRIMERO EN PROFUNDIDAD */
enf_es(Eb,Ed,R):-
enf(Eb,X,R2),
not(X=Ed),
enf_agregar(Eb),
enf_es(X,Ed,R3),
R is R2+R3.
enf_es(Eb,_,R):-
write('ENFERMEDAD SIN DERIVACIONES EN: '),
write(Eb),nl,
R is 0, fail.
/* Añadir a la lista de enfermedades consideradas */
enf_agregar(Eb):-
not(enf_vis(Eb)),
assertz(enf_vis(Eb)),!.
enf_agregar(_).
/* Definir las bases para la siguiente tarea */
enf_eliminar:-
retract(enf_vis(_)),fail,!.
/* Escribir las enfermedades consideradas */
enf_display:-
nl,
write(' LA CLASIFICACION CONSIDERADA ES: '),nl,
enf_vis(Eb), write(Eb),nl,
fail,!.
/* Definición de los nodos que constituyen el árbol */
database:-
assertz(enf(enfer_pulmonares,asma,10)),
assertz(enf(enfer_pulmonares,obstructivas,10)),
assertz(enf(enfer_pulmonares,apergilosis,10)),
assertz(enf(enfer_pulmonares,bronquiectasis,10)),
assertz(enf(obstructivas,cronicas,20)),
assertz(enf(obstructivas,vias_resp_sup,20)),
assertz(enf(obstructivas,vias_resp_inf,20)),
assertz(enf(cronicas,bronquitis,30)),
assertz(enf(cronicas,enfisema,30)),
assertz(enf_vis(nada)),
retract(enf_vis(nada)).