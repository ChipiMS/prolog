/* Predicado para la presentación*/
presenta:-
nl,nl,
write('SISTEMA DE DIAGNÓSTICO Y TRATAMIENTO DE ENFERMEDADES PULMONARES'),nl,nl,nl,
write(' APLICACIÓN DE MARCOS'), nl,nl,nl,nl,
write(' Presione cualquier caracter seguido de punto..'),
read(_),
nl, menu.
/* Predicado del menu principal */
menu:-
nl,nl,
write(' MENU PRINCIPAL'), nl,nl,nl,
write(' a. Enfermedad Base'),nl,
write(' b. Lista de sintomas'),nl,
write(' c. Tratamiento'),nl,
write(' d. Estudios Requerido'),nl,
write(' e. Salir'),nl,nl,
write(' Presiona <a.,b.,c.,d., o e.>..'),
read(Resp),
opcion(Resp).
/* Predicado para validar opciones del menu */
opcion(Resp):- Resp='a',nl,enf_base.
opcion(Resp):- Resp='b',nl,sintomas.
opcion(Resp):- Resp='c',nl,tratamiento.
opcion(Resp):- Resp='d',nl,estudios.
opcion(Resp):- Resp='e',nl,despedida.
opcion(Resp):- Resp\='a',Resp\='b',Resp\='c',Resp\='d',Resp\='e',menu.
/* Predicado de despedida */
despedida:-
nl,nl,
write(' BYE ....').
/* Predicado para escribir listas */
writeliste([]).
writeliste([Head|Tail]):- write(Head),nl,writeliste(Tail).
writelists([]).
writelists([Head|Tail]):- write(Head),nl,writelists(Tail).
writelistp([]).
writelistp([Head|Tail]):- write(Head),nl,writelistp(Tail).
writelistt([]).
writelistt([Head|Tail]):- write(Head),nl,writelistt(Tail).
/* Predicado para encontrar enfermedad base */
enf_base:-
write('Dame la enfermedad derivada <<Minusculas>>: '),
read(X),
frame_enf(X,E,LS,LP),nl,
write(X), nl,
write(' SE DERIVA DE UN(A): '),nl,nl,
writeliste(E), nl,
menu.
/* Predicado ERROR en la búsqueda de la enfermedad base */
enf_base:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_), menu.
/* Predicado para encontrar el sintoma prioritario */
sintomas:-
nl,
write('Dame la enfermedad <<minusculas>>: '),nl,
read(X),
frame_enf(X,E,LS,LP),nl,
write(X),nl,
write(' TIENE COMO SINTOMAS PRINCIPALES: '),nl,nl,
writelists(LS),nl, menu.
/* Predicado ERROR en la búsqueda de los sintomas */
sintomas:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Predicado para encontrar el tratamiento */
tratamiento:-
nl,
write('Dame la enfermedad <<minusculas>>: '),nl,
read(X),
frame_enf(X,E,LS,LP),nl,
write(X), write(', SE TRATA CON: '),nl,nl,
writelistp(LP),nl,
menu.
/* Predicado ERROR en la búsqueda del tratamiento */
tratamiento:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Predicado para encontrar el estudio requerido */
estudios:-
nl,
write('Dame el sintoma <<minusculas>>: '),nl,
read(X),
frame_est(X,LT),nl,
write(X), write(', REQUIERE EL ESTUDIO DE : '),nl,nl,
writelistt(LT),nl,
menu.
/* Predicado ERROR en el estudio requerido */
estudios:-
nl,
write(' No se encuentra en la BASE DE CONOCIMIENTOS '),nl,nl,
write(' ....Oprima cualquier caracter seguido de punto: '),
read(_),menu.
/* Predicados que definen la base de conocimientos de acuerdo a los cuadros */
frame_enf(asma,[enf_pulmonares],[sibilancias,espiracion,flujo,disfuncion],
[simpaticomimeticos,corticosteroides,cromolin_sodico]).
frame_enf(bronquitis,[enf_pulmonares,obstructivas,cronicas],[moco_bronquial,tos_productiva],
[inter_del_tabaq,educ_del_pac,al_broncospas,terap_aerosole,fisiot_de_torax]).
frame_enf(enfisema,[enf_pulmonares,obstructivas,cronicas],[disnea,tos,prod_de_esputo,hipertrofia_mus,hiperinflacion],
[terap_aerosole,fisiot_torax,rehabilitacion,trat_de_complic]).
frame_enf(fibrosis_q,[enf_pulmonares,obstructivas,cronicas],[tos,intolerancia_al_ejercicio,neumonias_recurrentes,estertores],
[aerosoles_blandos,broncodilatadores,vacunacion,prednisonal]).
frame_enf(vias_resp_sup,[enf_pulmonares,obstructivas],[estridor_inspiratorio,retracciones,lesiones_faringe_laringe],
[asegurar_ventilacion,asegurar_oxigena,psicoterapia]).
frame_enf(obstruccion_traqueal,[enf_pulmonares,obstructivas,vias_resp_inf],[traumatismo_traqueal],
[reconstruccion_quirurgica,fotorreseccion_laser,asegurar_oxigena]).
frame_enf(obstruccion_bronquial,[enf_pulmonares,vias_resp_inf],[disnea,tos,sibilancias,fiebre,escalofrio,esp_prolongada],
[asegurar_ventilacion,asegurar_oxigena,evitar_manipulaciones,reconstruccion_quirurgica,laser]).
frame_enf(aspergilosisma,[enf_pulmonares],[asma,eosinofilia_periferica,reactividad_cutanea,infiltrados_pulmonares,bronquiectasia],
[prednisona,corticosteroides,broncodilatadores]).
frame_enf(bronquiectasia,[enf_pulmonares],[tos_cronica,esputo,hemoptisis,neumonia,perdida_peso,anemia],
[antibioticos,fisioterapia,percusion_del_torax,broncodilatadores]).
frame_est(hiperinflacion,[est_radio_torax]).
frame_est(estrechamiento_infra_y_suprag,[radiografias]).
frame_est(lesiones_en_faringe_y_laringe,[ts,irm]).