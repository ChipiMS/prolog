/* Predicado para la presentación*/
presenta:-
nl,nl,
write(' SISTEMA DE CONSULTA RÁPIDA DE ENFERMEDADES PULMONARES'),nl,nl,nl,
write(' APLICACIÓN DE REDES SEMÁNTICAS'), nl,nl,nl,nl,
write(' Presione cualquier caracter seguido de punto..'),
read(_),
nl, menu.
/* Predicado del menu principal */
menu:-
nl,nl,
write(' MENU PRINCIPAL'), nl,nl,nl,
write(' a. Enfermedad Base'),nl,
write(' b. Sintoma Principal'),nl,
write(' c. Tratamiento Prioritario'),nl,
write(' d. Estudio Requerido'),nl,
write(' e. Salir'),nl,nl,
write(' Presiona <a.,b.,c.,d., o e.>..'),
read(Resp),
opcion(Resp).
/* Predicado para validar opciones del menu */
opcion(Resp):- Resp='a',nl,bases.
opcion(Resp):- Resp='b',nl,sint_prio.
opcion(Resp):- Resp='c',nl,trat_princ.
opcion(Resp):- Resp='d',nl,est_imp.
opcion(Resp):- Resp='e',nl,despedida.
opcion(Resp):- Resp\='a',Resp\='b',Resp\='c',Resp\='d',Resp\='e',menu.
/* Predicado de despedida */
despedida:-
nl,nl,
write(' BYE ....').
/* Predicado para encontrar enfermedad base */
bases:-
write('Dame la enfermedad derivada <<Minusculas>>: '),
read(X),
es_un(X,Y),nl,
write(X), nl,
write('se deriva de un(a): '),nl,
write(' '), write(Y), nl,
menu.
/* Predicado ERROR en la búsqueda de la enfermedad base */
bases:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_), menu.
/* Predicado para encontrar el sintoma prioritario */
sint_prio:-
nl,
write('Dame la enfermedad <<minusculas>>: '),nl,
read(X),
tiene(X,Y),nl,
write(X),nl,
write(' tiene como sintoma principal: '),nl,
write(Y),nl,
menu.
/* Predicado ERROR en la búsqueda del sintoma prioritario */
sint_prio:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Predicado para encontrar el elemento principal en el tratamiento */
trat_princ:-
nl,
write('Dame la enfermedad <<minusculas>>: '),nl,
read(X),
se_trata(X,Y),nl,
write(X), write(', se trata principalmente con: '),nl,
write(Y),nl,
menu.
/* Predicado ERROR en la búsqueda del tratamiento */
trat_princ:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Predicado para encontrar el estudio requerido */
est_imp:-
nl,
write('Dame el sintoma <<minusculas>>: '),nl,
read(X),
requiere(X,Y),nl,
write(X), write(', requiere del estudio de: '),nl,
write(Y),nl,
menu.
/* Predicado ERROR en el estudio requerido */
est_imp:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Cláusulas que definen la base de conocimientos de acuerdo a la red semántica */
es_un(asma,enf_pulmonares).
es_un(obstructivas,enf_pulmonares).
es_un(apergilosis,enf_pulmonares).
es_un(bronquiectasia,enf_pulmonares).
es_un(cronicas,obstructivas).
es_un(vias_res_sup,obstructivas).
es_un(obstruccion_traqueal,vias_res_inf).
es_un(estenosis_traqueal,vias_res_inf).
es_un(obstruccion_bronquial,vias_res_inf).
es_un(fibrosis_q,cronicas).
es_un(bronquitis,cronicas).
es_un(enfisema,cronicas).
tiene(asma,sibilancias).
tiene(bronquitis,moco_bronquial).
tiene(enfisema,hiperinflacion_disnea).
tiene(fibrosis_q,esteatorrea).
tiene(vias_resp_sup,estrechamiento_infra_y_suprag).
tiene(obstruccion_traqueal,traumatismo_traquea).
tiene(estenosis_traqueal,incapacidad_para_eliminar_secrec_pulm).
tiene(obstruccion_bronquial,espiracion_prolongada).
tiene(aspergilosis,eosinofilia_periferica).
tiene(bronquiectasia,hemoptisis).
se_trata(asma,simpaticomimeticos).
se_trata(bronquitis,terap_aerosole).
se_trata(enfisema,fisio_de_torax).
se_trata(fibrosis_q,broncodilatadores).
se_trata(vias_resp_sup,asegurar_ventilacion_y_oxigenacion).
se_trata(obstruccion_traqueal,asegurar_ventilacion_y_oxigenacion).
se_trata(estenosis_traqueal,asegurar_ventilación_y_oxigenacion).
se_trata(obstruccion_bronquial,asegurar_ventilacion_y_oxigenacion).
se_trata(aspergilosis,corticosteroides).
se_trata(bronquiectasia,antibioticos).
requiere(hiperinflacion,estudios_radiograficos).
requiere(estrechamiento_infra_y_suprag,radiografias).