# Manual Tecnico

Calculador grafica, utlizando como herramienta un ensamblador de x86.

La calculadora resuelve ecuaciones de grado n (donde n es un número entero no mayor a 5)
mediante el uso métodos numéricos de Newton y Steffensen.

# Sobre el manual

El manual esta dirigido a un usuario con conocimientos basicos de assembler (manejo de etiquetas, macros, procedimientos, registros, variables y interupciones). Por lo cual programa no se detalla linea por linea, sin embargo se detallan las etiquetas, macros y procedimientos necesarios. 

En el codigo podra encontrar mas informacion donde se encuetra informacion para modifcar los proces mas dificiles.

# Herramientas

- Ensamblador X86
- DOS
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

# Recomoendaciones

Se aconceja leer el manual de usario para ver el funcionamiento de la calculadora