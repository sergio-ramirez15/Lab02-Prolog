power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

dfs(estado([],_,_),_).

dfs(EstadoActual, Visitados) :-
    siguiente_estado(EstadoActual, SiguienteEstado),
    not(member(SiguienteEstado, Visitados)),
    dfs(SiguienteEstado, [SiguienteEstado | Visitados]).


siguiente_estado(estado(Villanos, [_|PoderesRestantes], EnergiaActual), estado(Villanos, PoderesRestantes, EnergiaActual)).

	
siguiente_estado(estado([villain(_,HP,Debilidad)| VillanosRestantes], [power(AbilityName,Daño,Coste)|PoderesRestantes], EnergiaActual), estado(VillanosRestantes, PoderesRestantes, NuevaEnergia)):-
    member(AbilityName,Debilidad),
    Daño >= HP,
    EnergiaActual >= Coste,
    NuevaEnergia is EnergiaActual-Coste.
    
batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]). %dfs(Estado,Visitados)