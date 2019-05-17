/*Predicado para la presentacion*/
presenta:-

write(' Busqueda en anchura: BREADTH SEARCH'),
write(' Arbol de Busqueda: Enfermedades pulmonares'),
write(' Se informa la ruta seguida: enfermedades y peso'),
write(' Presione cualquier caracter seguido de punto...'),
read(_),
 menu.
/*Predicado del menu principal*/
menu:-
database,

write(' MENU PRINCIPAL'),
write(' a. Breadth Search'),
write(' b. Salir'),
write(' Presiona <a. o b.>....'),
read(Resp),
opcion(Resp).
/* Predicado para validar opciones del menu */
opcion(Resp):-Resp='a',
 enf_enc.
opcion(Resp):-Resp='b',
 despedida.
opcion(Resp):-Resp\='a',Resp\='b',menu.
/* Predicado de despedida */
despedida:-

write(' BYE ..... ').
/* Predicado para preguntar la enfermedad base y la derivada. */
enf_enc:-
write('Enfermedad Base <<Minusculas>>: '),
read(Eb),
write('Enfermedad Derivada <<Minusculas>>: '),
read(Ed),
enf_rut(Eb,Ed,R),
write('EL PESO DE LA RUTA ES: '),
write(R),
not(enf_display),
write('Presiona cualquier caracter seguido de punto: '),
read(_),menu.
/* Encontrar la ruta de conexion entre las enfermedades */
enf_rut(Eb,Ed,R):-
enf_es(Eb,Ed,R).
/* Informar de fallas */
enf_rut(_,_,R):-

write('¡NO HAY RELACION ENTRE ESTAS ENFERMEDADES!'),
write('Presiona cualquier caracter seguido de punto: '),
read(_),
R is 0, enf_eliminar, menu.
/* Predicado para verificar la relacion entre dos enfermedades */
enf_es(Eb,Ed,R):-
enf(Eb,Ed,R),
enf_agregar(Eb).
/* HACER PRIMERO EN ANCHURA */
enf_es(Eb,Ed,R):-
enf(Eb,X,R2),
enf(X,Ed,R3),
enf_agregar(Eb),
enf_agregar(X),
R is R2+R3,
R is 0, fail.
enf_es(Eb,Ed,R):-
enf(Eb,X,R2),
not(X=Ed),
enf_agregar(Eb),
enf_es(X,Ed,R3),
R is R2+R3.
enf_es(Eb,_,R):-
write(' ENFERMEDAD SIN DERIVACIONES EN : '),
write(Eb), 
R is 0, fail.
/* Añadir a la lista de enfermedades consideradas */
enf_agregar(Eb):-
not(enf_vis(Eb)),
assertz(enf_vis(Eb)),!.
enf_agregar(_).
/* Definir las bases para la siguiente tarea */
enf_eliminar:-
retract(enf_vis(_)), fail,!.
/* Escribir las enfermedades consideradas */
enf_display:-

write(' LA CLASIFICACION CONSIDERADA ES: '),
enf_vis(Eb), write(Eb),
 fail, !.
/* Definición de los nodos que constituyen el árbol */
database:-
assertz(enf(enfer_pulmonares,asma,10)),
assertz(enf(enfer_pulmonares,obstructivas,10)),
assertz(enf(enfer_pulmonares,aspergilosis,10)),
assertz(enf(enfer_pulmonares,bronquiectasis,10)),
assertz(enf(obstructivas,cronicas,20)),
assertz(enf(obstructivas,vias_resp_sup,20)),
assertz(enf(obstructivas,vias_res_inf,20)),
assertz(enf(cronicas,bronquitis,30)),
assertz(enf(cronicas,enfisema,30)),
assertz(enf_vis(nada)),
retract(enf_vis(nada)).