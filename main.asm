include macros.asm
.model small
;-----Stack segment-----
.stack 100h
;-----Data segment-----
.data

    options      db 'Ingrese el numero de opcion que desee:',13,10
                 db '(1) Ingresar lo coeficientes de la funcion',13,10
                 db '(2) Imprimir la funcion almacenada',10,13
                 db '(3) Imprimir derivada de la funcion almacenada',10,13
                 db '(4) Imprimir integral de la funcion almacenada',10,13
                 db '(5) Graficar la funcion',10,13
                 db '(6) Metodo Newton',10,13
                 db '(7) Metodo de Steffensen',10,13
                 db '(8) Salir de la aplicacion',10,13,'$'

    ;-------------------------- Coeficientes  --------------------------
    coefX        db "Coeficiente de xx: ",'$'
    coeficiente5 db 5 dup ('$')
    coeficiente4 db 5 dup ('$')
    coeficiente3 db 5 dup ('$')
    coeficiente2 db 5 dup ('$')
    coeficiente1 db 5 dup ('$')
    coeficiente0 db 5 dup ('$')


    number       db 2 dup (0)
    
    ;-------------------------- Variables de uso general  --------------------------
    newLine      db 10,'$'
    aviso        db 10,13,"Perteneciente a la fase 2",10,13,'$'

    ;--------------------------Mensajes de error  --------------------------
    error1       db 10,10,13,"Error: Opcion invalida",10,10,13,'$'
    error2       db 10,10,13,"Error: No se 64acepta caracteres vacios",10,10,13,'$'
    error3       db 10,10,13,"Error: Solo se aceptan digitos entre -9 a +9",10,10,13,'$'
    error4       db 10,10,13,"Error: caracter no reconocido",10,10,13,'$'


    ;-----------------------------------------Code segment-----------------------------------------
.code
main proc
                         mov             ax, @data
                         mov             ds,ax

    menuPrincipal:       
                    print           options
                    getChar

                ;    Switch case evaluamos las posibles opciones del 1 al 8 si no se muestra un mensaje de error
                    cmp             al, '1'
                    je              ingresarCoeficientes
                    cmp             al, '2'
                    je              imprimirFuncion
                    cmp             al, '3'
                    je              imprimirDerivada
                    cmp             al, '4'
                    je              imprimirIntegral
                    cmp             al, '5'
                    je              graficarFuncion
                    cmp             al, '6'
                    je              metodoNewton
                    cmp             al, '7'
                    je              metodoSteffensen
                    cmp             al, '8'
                    je              exit
                    jmp             invalidOption

    ingresarCoeficientes:
                         print           newLine
                         getCoefficients
                         jmp             menuPrincipal

    imprimirFuncion:     
    ;TODO printFunction
                         jmp             menuPrincipal

    imprimirDerivada:    
                         print           newLine
                         getTexto        coeficiente0
                         print           newLine
                         convertNumber   coeficiente0, number
                         convertAscii    number, coeficiente1
                         print           coeficiente1
                         print           newLine
                         jmp             menuPrincipal
        
    imprimirIntegral:    
                         print           aviso
                         jmp             menuPrincipal

    graficarFuncion:     
                         print           aviso
                         jmp             menuPrincipal

    metodoNewton:        
                         print           aviso
                         jmp             menuPrincipal

    metodoSteffensen:    
                         print           aviso
                         jmp             menuPrincipal

    exit:                
                         mov             ah, 4ch
                         int             21h

    invalidOption:       
                         print           error1
                         jmp             menuPrincipal

    errorChar:           
                         print           error4
                         jmp             menuPrincipal

main endp

end main