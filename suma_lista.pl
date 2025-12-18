% Caso base: lista vacía
sumar_lista([], 0).

% Caso recursivo: procesar cabeza y continuar con la cola
sumar_lista([H|T], SumaTotal) :-
    number(H),  % Verifica que H sea un número
    sumar_lista(T, SumaCola),
    SumaTotal is H + SumaCola.

% Caso para elementos no numéricos: ignorarlos
sumar_lista([H|T], SumaTotal) :-
    \+ number(H),
    sumar_lista(T, SumaTotal).

% -----------------------------------------------------------
% Consultas de prueba
% -----------------------------------------------------------

% Consulta del ejemplo:
% ?- sumar_lista([10, 5, 2, 3], Total).
% Resultado esperado: Total = 20

% Otras consultas para testing:
% ?- sumar_lista([], Total).                % Total = 0
% ?- sumar_lista([a, b, c], Total).         % Total = 0
% ?- sumar_lista([1, 2, a, 3, b], Total).   % Total = 6
% ?- sumar_lista([1.5, 2.5, 3], Total).     % Total = 7.0
% ?- sumar_lista([-5, 10, -3], Total).      % Total = 2
