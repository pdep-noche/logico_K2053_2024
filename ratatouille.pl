
%viveEn(rata, restaurante)
viveEn(remy,gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).
%cocina(persona, plato, experiencia)
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(collete, salmonAsado, 9).
cocina(hort, ensaldaRusa,8).

%trabajaEn(nombre, restaurante)
trabajaEn(linguini, gusteaus).
trabajaEn(collete, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

%1
estaEnElMenuDe(Plato, Restaurante):-cocina(Cocinero,Plato, _), trabajaEn(Cocinero, Restaurante).


%2
cocinaBien(Cocinero, Plato):-cocina(Cocinero, Plato, Experiencia), Experiencia > 7.
cocinaBien(Cocinero, Plato):- tieneTutor(Cocinero, Tutor), cocinaBien(Tutor, Plato).
cocinaBien(remy, Plato):- cocina(_, Plato, _). 
%tieneTutor(Cocinero, Tutor).
tieneTutor(linguini, Rata):-viveEn(Rata, Lugar), trabajaEn(linguini, Lugar).
tieneTutor(skinner, amelie).

%3
esChef(Cocinero, Restaurante):-trabajaEn(Cocinero, Restaurante),
            cumpleCondicionesChef(Cocinero, Restaurante).

cumpleCondicionesChef(Cocinero, Resto):-
    forall(estaEnElMenuDe(Plato, Resto), cocinaBien(Cocinero, Plato)).
cumpleCondicionesChef(Cocinero, _):-
    totalExperiencia(Cocinero, Total), Total > 20.

totalExperiencia(Cocinero, Total):-
    findall(Experiencia, cocina(Cocinero, _, Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).
    
%4
encargadoDe(Cocinero, Plato, Resto):- experienciaEnResto(Cocinero, Plato, Resto, Experiencia),
forall(experienciaEnResto(_, Plato, Resto, OtraExperiencia), OtraExperiencia =< Experiencia).

experienciaEnResto(Cocinero, Plato, Resto, Experiencia):- 
    trabajaEn(Cocinero, Resto),
    cocina(Cocinero, Plato, Experiencia).

%5

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(30)).

esSaludable(NombrePlato):- plato(NombrePlato, TipoPlato), 
    calorias(TipoPlato, CantCalorias), 
    CantCalorias < 75.




calorias(entrada(Ingredientes), TotalCalorias):-length(Ingredientes, Cantidad),
    TotalCalorias is Cantidad * 15.
calorias(principal(Guarnicion, Minutos), TotalCalorias):-
    caloriasGuarnicion(Guarnicion, Calorias), 
    TotalCalorias is Calorias  + (5*Minutos).
calorias(postre(Calorias), Calorias).
% calorias/2 es un predicado polimorfico


caloriasGuarnicion(papaFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).


escribeReseniaPositiva(Critico, Resto):-restaurante(Resto),
    not(viveEn(_, Resto)), criterioCritico(Critico, Resto).

criterioCritico(antonEgo,Resto):- esEspecialista(Resto, ratatouille).
criterioCritico(cormillot, Resto):- 
    forall(estaEnElMenuDe(Plato, Resto), esSaludable(Plato)).
criterioCritico(martiniano, Resto):-esChef(Cocinero, Resto), 
    not((esChef(OtroCocinero, Resto), Cocinero \= OtroCocinero)).

esEspecialista(Resto, Comida):-
    forall(esChef(Cocinero, Resto), cocinaBien(Cocinero, Comida)).

restaurante(Resto):- trabajaEn(_, Resto).

