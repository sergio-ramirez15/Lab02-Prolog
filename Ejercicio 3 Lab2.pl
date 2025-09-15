% Caso base
dfs(Estado, _, Estado) :-
    length(Estado, 8).

% Paso recursivo: intentar agregar una nueva reina
dfs(Estado, Visitados, SolFinal) :-
    mover(Estado, NuevoEstado),
    \+ member(NuevoEstado, Visitados),   % evitar repetir estados
    dfs(NuevoEstado, [NuevoEstado|Visitados], SolFinal).

% Generar un nuevo estado colocando una reina en la siguiente fila
mover(Estado, [Columna|Estado]) :-
    between(1, 8, Columna),
    fila_siguiente(Estado, Fila),
    valido(Columna, Fila, Estado).

% Calcular la fila siguiente según cuántas reinas ya se colocaron
fila_siguiente(Estado, Fila) :-
    length(Estado, L),
    Fila is L + 1.

% Verificar que la reina nueva no ataque a ninguna anterior
valido(_, _, []).
valido(Columna, Fila, [ColAnt|Resto]) :-
    length(Resto, K),
    FilaAnt is K + 1,
    ColAnt =\= Columna,
    abs(Columna - ColAnt) =\= abs(Fila - FilaAnt),
    valido(Columna, Fila, Resto).

% Predicado principal: encontrar una solución
solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).