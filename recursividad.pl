progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro,Descendiente):- progenitor(Progenitor, Descendiente),
                    ancestro(Ancestro, Progenitor).

ultimo([E],E).
ultimo([_|Cola],Ultimo):- ultimo(Cola,Ultimo).

sumatoria([], 0).
sumatoria([Cabeza|Cola], S):-sumatoria(Cola,SCola), S is SCola + Cabeza.

esta(X, [X|_]). 
esta(X, [_|Z]):-esta(X, Z).

encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola], [Cab|Resto]):- encolar(Elem, Cola, Resto).


maximo(Lista, Maximo):-member(Maximo, Lista),    
    forall(member(OtroElem, Lista), OtroElem =< Maximo).

esCreciente([_]).
esCreciente([Elem, OtroElem|Cola]):- Elem < OtroElem, esCreciente([OtroElem|Cola]).


sublistaMayoresA([], _, []).
sublistaMayoresA([Cab|Cola], Elem, [Cab|Resto]):- Cab > Elem, sublistaMayoresA(Cola, Elem, Resto).
sublistaMayoresA([_|Cola], Elem, Lista):- sublistaMayoresA(Cola, Elem, Lista).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculaDeGenero(Persona, Genero):- persona(Persona), generoPelicula(Genero),
    forall(gusta(Persona, Pelicula), genero(Pelicula,Genero)).


persona(Persona):- gusta(Persona, _).
generoPelicula(Genero):- genero(_, Genero).

peliculasQueLeGustaPorGenero(Persona, Genero, ListaPeliculas):- persona(Persona), generoPelicula(Genero), 
findall(Pelicula, gustaPeliculaGenero(Persona, Genero, Pelicula), ListaPeliculas).

gustaPeliculaGenero(Persona, Genero, Pelicula):- gusta(Persona, Pelicula), genero(Pelicula, Genero).


%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


puedeIr(Persona, Lugar, Alojamiento):- puedeGastar(Persona, CantDias, Disponible), lugar(Lugar, Alojamiento), 
    cumpleCondiciones(Alojamiento, MontoDiario), Total is CantDias * MontoDiario, Total =< Disponible.

cumpleCondiciones(hotel(_, CantEstrellas, MontoDia), MontoDia):- CantEstrellas > 3.
cumpleCondiciones(casa(garaje, MontoDia), MontoDia).
cumpleCondiciones(quinta(_, pileta, MontoDia), MontoDia).
cumpleCondiciones(carpa(MontoDia), MontoDia).


persona(Persona):- puedeGastar(Persona, _, _).
puedeIrACualquierLugar(Persona):- persona(Persona),
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).


transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2014)).
transporte(ana, auto(fiesta, ford, 2020)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).

ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).


objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)).


loLiquidaron(Jugador):- jugador(Jugador), not(ocupa(_, Jugador, _)).

ocupaContinente(Jugador, Continente):- jugador(Jugador), continente(Continente), 
forall( estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).


seAtrinchero(Jugador):- jugador(Jugador), continente(Continente), 
forall(ocupa(Pais, Jugador, _), estaEn(Continente, Pais)).


elQueTieneMasEjercitos(Jugador, Pais):- ocupa(Pais, Jugador, CantEjercito),

forall(ocupa(_, _, OtraCantEjer),  CantEjercito >= OtraCantEjer).

cumpleObjetivos(Jugador):-jugador(Jugador),  
forall(objetivo(Jugador, Objetivo), cumpleObjetivo(Objetivo, Jugador)).

cumpleObjetivo(ocuparContinente(Continente), Jugador):- ocupaContinente(Jugador, Continente).
cumpleObjetivo(ocuparPaises(Cant, Continente), Jugador):- cantidadDePaises(Jugador, Continente, CantPaises), 
    CantPaises >= Cant.
cumpleObjetivo(destruirJugador(JugadorADestruir), Jugador):- not(ocupa(_, JugadorADestruir, _)).

cantidadDePaises(Jugador, Continente, Cant):- jugador(Jugador), 
findall(Pais, estaOcupado(Pais, Continente, Jugador), ListaPaises), 
length(ListaPaises, Cant).

estaOcupado(Pais, Continente, Jugador):- ocupa(Pais, Jugador, _),
    estaEn(Pais, Continente).

