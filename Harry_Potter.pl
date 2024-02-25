% Personaje identification rules
% To run, type      go.
go :- hypothesize(Personaje),
     write('El personaje es: '),
     write(Personaje), nl, undo.

 /* hypotheses to be tested */
hypothesize(harry_potter) :- harry_potter, !.
hypothesize(ron_weasley) :- ron_weasley, !.
hypothesize(ginny_weasley) :- ginny_weasley, !.
hypothesize(hermione_granger) :- hermione_granger, !.
hypothesize(dumbledore) :- dumbledore, !.
hypothesize(sirius_black) :- sirius_black, !.
hypothesize(remus_lupin) :- remus_lupin, !.
hypothesize(snape) :- snape, !.
hypothesize(voldemort) :- voldemort, !.
hypothesize(bellatrix_lestrange) :- bellatrix_lestrange, !.
hypothesize(molly_weasley) :- molly_weasley, !.
hypothesize(draco_malfoy) :- draco_malfoy, !.
hypothesize(lucius_malfoy) :- lucius_malfoy, !.
hypothesize(dobby) :- dobby, !.
hypothesize(hagrid) :- hagrid, !.
hypothesize(luna_lovegood) :- luna_lovegood, !.
hypothesize(cho_chang) :- cho_chang, !.
hypothesize(cedric_diggory) :- cedric_diggory, !.
hypothesize(nymphadora_tonks) :- nymphadora_tonks, !.
hypothesize(muggle) :- muggle, !.
hypothesize(no_identificado). /* no diagnosis */


/* Personaje identification rules */

harry_potter :- masculino, gryffindor, ejercito_de_dumbledore, (tiene_cicatriz ; habilidad_parlante_parsel).
ron_weasley :- masculino, gryffindor, weasley, ejercito_de_dumbledore.
ginny_weasley :- femenino, gryffindor, weasley, ejercito_de_dumbledore.

hermione_granger :- femenino, gryffindor, (inteligente ; no_se_dice_leviosa).
dumbledore :- masculino, gryffindor, orden_del_fenix, profesor, inteligente, muere_en_alguna_pelicula.

sirius_black :- masculino, gryffindor, orden_del_fenix, muere_en_alguna_pelicula, verify(fue_prisionero).
remus_lupin :- masculino, gryffindor, orden_del_fenix, muere_en_alguna_pelicula, lobo.

snape :- masculino, slytherin, profesor, mortifago, muere_en_alguna_pelicula, orden_del_fenix.
voldemort :- masculino, slytherin, mortifago, muere_en_alguna_pelicula, (magia_oscura ; no_se_puede_nombrar).
bellatrix_lestrange :- femenino, slytherin, mortifago, magia_oscura, muere_en_alguna_pelicula.

molly_weasley :- femenino, gryffindor, weasley, verify(es_madre), orden_del_fenix.
draco_malfoy :- masculino, slytherin, malfoy, not(es_mayor), magia_oscura, mortifago.
lucius_malfoy :- masculino, slytherin, malfoy, magia_oscura, mortifago.

dobby :- masculino, verify(necesitaba_un_calcetin).
hagrid :- masculino, gryffindor, semigigante, profesor, orden_del_fenix.

luna_lovegood :- femenino, ravenclaw, inteligente, ejercito_de_dumbledore.
cho_chang :- femenino, ravenclaw, verify(aparece_en_el_libro_4), inteligente, ejercito_de_dumbledore.
cedric_diggory :- masculino, hufflepuff, verify(aparece_en_el_libro_4).

nymphadora_tonks :- femenino, hufflepuff, orden_del_fenix, verify(no_le_gusta_su_primer_nombre), auror.

/* classification rules */

masculino :- verify(es_masculino), !.
femenino :- not(masculino).

lobo :- verify(se_transforma_en_lobo), !.

inteligente :- verify(inteligente), !.

:- dynamic no_pertenece_a_ninguna_casa/1.
no_pertenece_a_ninguna_casa(true) :- !.

gryffindor :- no_pertenece_a_ninguna_casa(true), verify(pertenece_a_gryffindor), retractall(no_pertenece_a_ninguna_casa(_)), asserta(no_pertenece_a_ninguna_casa(false)), !.
slytherin :- no_pertenece_a_ninguna_casa(true), verify(pertenece_a_slytherin), retractall(no_pertenece_a_ninguna_casa(_)), asserta(no_pertenece_a_ninguna_casa(false)), !.
ravenclaw :- no_pertenece_a_ninguna_casa(true), verify(pertenece_a_ravenclaw), retractall(no_pertenece_a_ninguna_casa(_)), asserta(no_pertenece_a_ninguna_casa(false)), !.
hufflepuff :- no_pertenece_a_ninguna_casa(true), verify(pertenece_a_hufflepuff), retractall(no_pertenece_a_ninguna_casa(_)), asserta(no_pertenece_a_ninguna_casa(false)), !.
muggle :- verify(es_muggle), !.

ejercito_de_dumbledore :- verify(pertenece_a_ejercito_de_dumbledore), !.
orden_del_fenix :- verify(pertenece_a_orden_del_fenix), !.
mortifago :- verify(pertenece_a_mortifago), !.
auror :- verify(auror), !.

bueno :- auror.
bueno :- ejercito_de_dumbledore.
bueno :- not(mortifago), not(orden_del_fenix).
bueno :- orden_del_fenix.

malo :- mortifago.
malo :- not(orden_del_fenix).
malo :- not(ejercito_de_dumbledore).

semigigante :- verify(semigigante), !.


profesor :- verify(es_profesor), !.
% alumno :- not(profesor).

weasley :- verify(tiene_el_pelo_rojo), !.
malfoy :- verify(tiene_el_pelo_rubio), !.
gordo :- verify(es_gordo), !.

es_mayor :- verify(es_mayor), !.
muere_en_alguna_pelicula :- verify(muere_en_alguna_pelicula), !.

% mas personales
tiene_cicatriz :- verify(tiene_cicatriz), !.
magia_oscura :- verify(practica_magia_oscura), !.
habilidad_parlante_parsel :- verify(tiene_habilidad_parlante_parsel), !.
no_se_dice_leviosa :- verify(no_se_dice_leviosa), !.
no_se_puede_nombrar :- verify(no_se_puede_nombrar), !.


/* how to ask questions */
ask(Question) :-
      write('El personaje tiene la siguiente caracteristica: '),
      write(Question), write('? '),
       read(Response), nl,
       ( (Response == si ; Response == s; Response == yes; Response == y)
       -> assert(yes(Question)) ;
       assert(no(Question)), fail).
:- dynamic yes/1,no/1.
/* How to verify something */
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).
/* undo all yes/no assertions */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.