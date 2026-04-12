# Introducci-n-a-los-Ordenadores
# Algoritmo de Euclides (MCD) - Iterativo en RISC-V
Implementación del algoritmo clásico de Euclides para hallar el Máximo Común Divisor (MCD) de dos números.

### Aspectos Técnicos
* **Estructuras de Control:** Uso intensivo de etiquetas y saltos condicionales para simular bucles `while` y estructuras `if-else`.
* **Aritmética de Registros:** Manipulación directa de datos en registros `a1` y `a2` mediante restas sucesivas.
* **Gestión de Memoria:** Carga de valores iniciales y almacenamiento del resultado final en la sección de datos (`.data`).

# Fibonacci Recursivo: Gestión de Pila y Subrutinas
Cálculo de la sucesión de Fibonacci utilizando recursividad, lo que implica una gestión manual del marco de pila (Stack Frame).

### Aspectos Técnicos
* **Llamadas Recursivas:** Uso de `call` y `ret` para gestionar subrutinas que se llaman a sí mismas.
* **Manejo del Stack Pointer (`sp`):** Reserva y liberación dinámica de memoria en la pila para salvar el registro de retorno (`ra`) y los valores temporales de `n`.
* **Casos Base:** Implementación de condiciones de parada para evitar desbordamientos de pila.

# Integración de Subrutinas: Factorial y Fibonacci
Un programa modular que integra dos algoritmos matemáticos distintos (Factorial y Fibonacci) ejecutados de forma secuencial.

### Aspectos Técnicos
* **Programación Modular:** División del código en subrutinas independientes (`subrutinaFactorial` y `subrutinaFibonacci`) invocadas desde el programa principal.
* **Encapsulamiento de Registros:** Uso de la pila para proteger el estado de los registros de un algoritmo mientras se ejecuta el otro.
* **Control de Errores:** Incluye lógica para gestionar resultados negativos en el cálculo del factorial.

# Control de Periféricos GPIO (LEDs y Switches)
Interacción en tiempo real con hardware externo mediante el mapeo de memoria de los registros GPIO.

### Aspectos Técnicos
* **Memory-Mapped I/O:** Acceso directo a las direcciones de memoria de los Switches (`0x80001400`) y los LEDs (`0x80001404`).
* **Lógica de Entrada (Switches):** Lectura del estado de los interruptores para determinar la dirección del movimiento del LED.
* **Operaciones Bitwise:** Uso de máscaras (`andi`) y desplazamientos (`srli`, `sll`) para aislar bits específicos de los periféricos.
* **Temporización:** Implementación de un bucle de retardo (`delay`) para controlar la velocidad de la animación.

# Decodificador para Display de 7 Segmentos
Conversión de valores binarios procedentes de interruptores a una representación visual en un display de 7 segmentos.

### Aspectos Técnicos
* **Look-up Table:** Uso de una tabla de constantes (`display_table`) en la sección `.data` para traducir números a patrones de bits del display.
* **Procesamiento de Bits:** Gestión de un bit de "CLEAR" (switch 15) para resetear el estado del visualizador.
* **Salida de Datos:** Escritura de patrones de bits específicos en el bus del display para formar dígitos legibles.