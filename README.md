# Suma de Elementos Numéricos
# Desarrollador: Rolando Vila Rodríguez

# Tester: Miguel Angel Banteurt Blanco , Guillermo Artigas Castillo

# Este repositorio contiene un predicado en **Prolog** que calcula la suma de todos los elementos **numéricos** de una lista, ignorando cualquier valor no numérico (como átomos o variables).

## 📌 Predicado principal

prolog
sumar_lista(+Lista, -SumaTotal)


- **Entrada (`+Lista`)**: Una lista que puede contener números, átomos u otros términos.
- **Salida (`-SumaTotal`)**: La suma de solo los elementos que sean números (enteros o reales).

### Comportamiento
- Si la lista está vacía → devuelve `0`.
- Si un elemento **no es numérico**, se ignora.
- Soporta números enteros, decimales y negativos.

## 🧪 Ejemplos de uso

prolog
?- sumar_lista([10, 5, 2, 3], Total).
Total = 20.

?- sumar_lista([], Total).
Total = 0.

?- sumar_lista([a, b, c], Total).
Total = 0.

?- sumar_lista([1, 2, a, 3, b], Total).
Total = 6.

?- sumar_lista([1.5, 2.5, 3], Total).
Total = 7.0.

?- sumar_lista([-5, 10, -3], Total).
Total = 2.


## 💡 Características
- ✅ Ignora elementos no numéricos de forma segura.
- ✅ Funciona con listas mixtas.
- ✅ Compatible con la mayoría de intérpretes de Prolog (SWI-Prolog, GNU Prolog, etc.).

## 📁 Video compilando el Programa
https://1drv.ms/f/c/9d729424818a6a8a/IgDNL-NRasGZQ7oy2fdgmGOaASIT3Yw9krPgxIbRGfFEX_o

## ⚠️ Problemas identificados y limitaciones

Aunque el predicado funciona correctamente en muchos casos, presenta varias **limitaciones importantes** desde el punto de vista de la robustez, eficiencia y estilo en Prolog:

### 1. **No maneja variables en la lista**
Si la lista contiene una variable no instanciada (ej. `[1, X, 3]`), el predicado **falla silenciosamente** o puede generar resultados incorrectos, ya que `\+ number(X)` es verdadero cuando `X` es una variable (porque no es un número *aún*), pero eso no significa que deba ignorarse.

> 📌 **Ejemplo problemático**:
> ```prolog
> ?- sumar_lista([1, X, 3], Total).
> Total = 1 + 3 = 4   % ¡Pero X podría ser un número más tarde!
> ```
> Esto viola el principio de *declaratividad* y puede causar errores lógicos en programas más grandes.

### 2. **Ineficiencia por retroceso innecesario**
El predicado tiene dos cláusulas recursivas que se solapan:
- Una para cuando `number(H)` es verdadero.
- Otra para cuando `\+ number(H)` es verdadero.

Esto **no es incorrecto**, pero obliga al motor de Prolog a probar ambas cláusulas en ciertos casos (aunque la primera ya haya tenido éxito), lo que puede generar retrocesos innecesarios y ralentizar la ejecución.

### 3. **Falta de modo de uso más flexible**
El predicado está diseñado solo para el modo `(+, -)`, es decir:
- `Lista` debe estar completamente instanciada.
- `SumaTotal` se calcula.

No es reversible (no se puede usar para generar listas que sumen un valor dado), aunque eso podría no ser deseado en este caso. Aun así, es bueno documentarlo.

### 4. **No valida que la entrada sea una lista bien formada**
Si se pasa algo que no es una lista (ej. `sumar_lista(hola, T)`), el predicado fallará con un error de tipo (`instantiation_error` o `type_error`), lo cual es aceptable, pero podría manejarse más elegantemente si se desea robustez extrema.

### 🧪 Ejemplos de uso del codigo mejorado

prolog
?- sumar_lista([1, 2, a, 3.5], T).
T = 6.5.

?- sumar_lista([], T).
T = 0.

?- sumar_lista([1, X, 2], T).
ERROR: Uninstantiated variable in list
ERROR: In sumar_lista/2

### 💡 Recomendación
Si no necesitas que falle con variables (por ejemplo, en un contexto educativo simple), puedes comentar o eliminar la línea de `var(H)`. Pero en código profesional o robusto, es mejor fallar temprano que dar resultados incorrectos.
