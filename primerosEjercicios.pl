humano(socrates).
mortal(Persona):- humano(Persona).

habla(juan, espaniol).
habla(juan, ingles).
habla(juan, italiano).
habla(marcela, espaniol).
habla(hernan , aleman).
habla(pedro, ingles).

seComunican(Persona,OtraPersona):- habla(Persona,Idioma), habla(OtraPersona,Idioma), 
                Persona \= OtraPersona.


curso(julia,fisicaI).
curso(emilio , inglesII).
curso(elizabeth , quimica).
curso(pedro,economia).
aprobo(emilio , inglesII).
aprobo(elizabeth , quimica).

desaprobo(Persona,Materia):- curso(Persona, Materia), not(aprobo(Persona,Materia)).


siguiente(Numero, Sig):- numero(Numero), Sig is Numero + 1.

numero(Num):- between(1, 10, Num).

mayor(Mayor, Menor):- numero(Mayor), numero(Menor), Mayor > Menor.

quiere(juan, playa).
quiere(juan , wifi).
quiere(juan , teatro).
quiere(ana , sierra).
quiere(ana , playa).

lugar(mardel, playa).
lugar(mardel , wifi).
lugar(mardel , teatro).
lugar(mardel , casino).
lugar(tandil , sierra).
lugar(tandil , teatro).

tieneTodoParaVeranear(Persona, Lugar):- persona(Persona), lugarVeraneo(Lugar),
    forall(quiere(Persona, Quiere), lugar(Lugar, Quiere)).

persona(Persona):-quiere(Persona, _).
lugarVeraneo(Lugar):-lugar(Lugar, _).


contador(roque).
joven(roque).
trabajoEn(julia,acme).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(pepe, fiat).
honesto(roque).
ingeniero(ana).
ingeniero(pepe).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(julia).
ambicioso(Persona):-joven(Persona),contador(Persona).
tieneExperiencia(Persona):-trabajoEn(Persona, _).
profesional(Persona):-contador(Persona).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).

puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria, Persona):-contador(Persona), honesto(Persona).
puedeAndar(ventas, Persona):-ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos,Persona):- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):- abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):-joven(Persona).
cumpleCondiciones(Persona):-trabajoEn(Persona, omni).



