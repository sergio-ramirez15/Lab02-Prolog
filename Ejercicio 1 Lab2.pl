% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).
meta(pos(orilla_final)).

% Caso base: El estado actual es la meta.
dfs(Estado, _, [Estado]) :-
    meta(Estado).

dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]) :-
    siguiente_estado(EstadoActual, SiguienteEstado),
    not(member(SiguienteEstado, Visitados)),
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], CaminoRestante).
    
siguiente_estado(pos(LugarActual), pos(LugarSiguiente)) :- 
    ubicacion(LugarActual,X,Y), 
    ubicacion(LugarSiguiente,X1,Y1),
    Xf is X-X1,
	Yf is Y-Y1,
	Dist is sqrt((Xf*Xf)+(Yf*Yf)),
    Dist =< 4.0.

buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion). %dfs(Estado,Visitados, Solucion)

