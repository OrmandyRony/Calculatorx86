# Manual Tecnico

Calculador grafica, utlizando como herramienta un ensamblador de x86.

La calculadora resuelve ecuaciones de grado n (donde n es un número entero no mayor a 5)
mediante el uso métodos numéricos de Newton y Steffensen.

# Sobre el manual

El manual esta dirigido a un usuario con conocimientos basicos de assembler (manejo de etiquetas, macros, procedimientos, registros, variables y interupciones). Por lo cual programa no se detalla linea por linea, sin embargo se detallan las etiquetas, macros y procedimientos necesarios. 

En el codigo podra encontrar mas informacion donde se encuetra informacion para modifcar los proces mas dificiles.

# Herramientas

- Ensamblador X86
- DOSBox 0.74
- Visual Studio Code
- MASM

# Empezando

Clone el repositorio

```bash
git clone  https://github.com/OrmandyRony/Calculatorx86.git
```

# Flujo del programa

El programa cuenta con un menu principal el cual tiene 8 opciones:

1. Ingresar ecuación (Función)
2. Imprimir la función almacenada
3. Imprimir la derivada de dicha función
4. Imprimir la integral de la función
5. Graficar la función original, derivada o integral
6. Encontrar los ceros de la función por medio del método de Newton.
7. Encontrar los ceros de la función por medio del método de Steffensen.
8. Salir de la aplicación.

El control del menu se lleva a cabo con simples operaciones de comparacion que llevan a las etiquetas de cada una de las opciones.

Nombre de la etiqueta principal

```nasm
menuPrincipal:
;instruccions
	.
	.
	.
```

## Ingresar ecuación

Para esta opcion la etiqueta encargada es `ingresarCoefientes`

## Imprimir la función almacenada

Para esta opcion la etiqueta encargada es `imprimirFuncion`

## Imprimir la derivada de dicha función

Para esta opcion la etiqueta encargada es `imprimirDerivada`

## Imprimir la integral de la función

Para esta opcion la etiqueta encargada es `imprimirIntegral`

## Graficar la función original, derivada o integral

Esta opcion no esta disponible

## Encontrar los ceros de la función por medio del método de Newton.

Esta opcion no esta disponible

## Encontrar los ceros de la función por medio del método de Steffensen.

Esta opcion no esta disponible

## Salir de la aplicación.

Para esta opcion la etiqueta encargada es `exit`

# Manejo de errores

Al elegir una opcion invalida en el menu este la detectara, la etiqueta encarga de esto es `invalidOption`

# Informacion de las herramientas
- DOSBOX
DOSbox es un emulador que recrea un entorno similar al sistema dos con el 
objetivo de poder ejecutar programas y videojuegos originalmente escritos para el 
sistema operativo ms-dos de microsoft en computadoras más modernas o en 
diferentes arquitecturas (como power pc). también permite que estos juegos 
funcionen en otros sistemas operativos como gnu/linux. fue hecho porque 
windows xp ya no se basa en ms dos y pasó a basarse a windows nt.

DOSBox es software libre, y está disponible para numerosos sistemas operativos, 
entre ellos linux, freebsd, windows, mac os x, os/2 y beos. incluso ha sido adaptado 
a las consolas psp, wii y gp2x. 


DOSBox es un emulador de cpu completo, no solo una capa de compatibilidad 
como dosemu o las máquinas con dos virtual de windows y os/2, que aprovechan 
las posibilidades de virtualización de la familia de procesadores intel 80386. no 
requiere un procesador x86 ni una copia de ms-dos o cualquier otro dos para 
ejecutarse, y puede ejecutar juegos que requieran que la cpu esté en modo real o 
modo protegido. 

O núcleo de cpu dinámico: en los sistemas que tienen el juego de instrucciones i386 
se usa una traducción dinámica de instrucciones. en los sistemas que no son 
compatibles con los x86 se utiliza una emulación completa, lo que ralentiza de 
manera importante la emulación. un sistema powerpc g4 a 1.6 ghz es capaz de 
emular un sistema 486 a una velocidad de 50 mhz con el hardware estándar 
emulado; mientras que basta con un pentium iii x86 mucho más lento para alcanzar 
la misma velocidad. 

O emulación de gráficos: modo texto, hercules, cga (incluyendo los modos 
compuesto y 160x100x16 modificado), ega, vga (incluyendo el modo x y otras 
modificaciones), vesa y emulación completa de la s3 trio 64. o emulación de sonido: 
adlib, altavoz del sistema, tandy, sound blaster, creative cms/gameblaster, disney 
soundsource, gravis ultrasound y mpu-401. 

O emulación de red: simulación del módem sobre tcp/ip y soporte para redes ipx, 
permitiendo que se juegue a juegos de dos a través de internet. las versiones de 
windows soportan acceso directo al puerto serie. 
O contiene su propia línea de comandos interna al estilo del dos, ya que no pretende 
ser un emulador de pc completo como bochs. 

- ENSAMBLADOR MASM
El microsoft macro assembler (masm) es un ensamblador para la familia x86 de 
microprocesadores. fue producido originalmente por microsoft para el trabajo de 
desarrollo en su sistema operativo ms-dos, y fue durante cierto tiempo el 
ensamblador más popular disponible para ese sistema operativo. el masm soportó 
una amplia variedad de facilidades para macros y programación estructurada, 
incluyendo construcciones de alto nivel para bucles, llamadas a procedimientos y 
alternación (por lo tanto, masm es un ejemplo de un ensamblador de alto nivel). 
versiones posteriores agregaron la capacidad de producir programas para los 
sistemas operativos windows. masm es una de las pocas herramientas de 
desarrollo de microsoft para las cuales no había versiones separadas de 16 bits y 32 
bits.


# Recomoendaciones

Se aconceja leer el manual de usario para ver el funcionamiento de la calculadora
