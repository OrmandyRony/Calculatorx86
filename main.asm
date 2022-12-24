include macros.asm
.model small
.stack
.data
    ; Opciones de menu
    options      db 'Ingrese el  de opcion que desee:',13,10
                 db '(1) Ingresar lo coeficientes de la funcion',13,10
                 db '(2) Imprimir la funcion almacenada',10,13
                 db '(3) Imprimir derivada de la funcion almacenada',10,13
                 db '(4) Imprimir integral de la funcion almacenada',10,13
                 db '(5) Graficar la funcion',10,13
                 db '(6) Metodo Newton',10,13
                 db '(7) Metodo de Steffensen',10,13
                 db '(8) Salir de la aplicacion',10,13,'$'

    ; Variables
    coeficiente1 db 0d
    coeficiente2 db 0d
    coeficiente3 db 0d
    coeficiente4 db 0d
    coeficiente5 db 0d
    coeficiente6 db 0d

    signo1 db 0d  ; varoable de apoyo para el control de su signo
    signo2 db 0d  ; varoable de apoyo para el control de su signo
    signo3 db 0d  ; varoable de apoyo para el control de su signo
    signo4 db 0d  ; varoable de apoyo para el control de su signo
    signo5 db 0d  ; varoable de apoyo para el control de su signo
    signo6 db 0d  ; varoable de apoyo para el control de su signo

    derivada1 db 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada2 db 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada3 db 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada4 db 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada5 db 0d  ;variable para almacenar la derivada de su respectivo coeficiente

    ;variables para almacenar el contenido de la integral
    valInt1 db 0d   
    valInt2 db 0d
    valInt3 db 0d
    valInt4 db 0d
    valInt5 db 0d
    valInt6 db 0d

    ; Variables temporales de unidades
    decenas db 0
    unidades db 0
    numTmp db 0d
    signoTmp db 0
    
    msgInterrupcion db 'Presiona enter para continuar','$'

    ;Mensajes de informacion
    mensageDerivada db "**************** DERIVADA ***************",0ah,'$'
    mensajeIntegral db "**************** INTEGRAL ***************",0ah,'$'
    separador db "*******************************",0ah,'$'
    
    indicador db "consola>", '$'
    pivoteCoeficiente db "5",'$' ; para indicar que coeficiente se ingresa
    msgCoeficiente db "Coeficiente de x^",'$'
    saltoLinea db " ",0ah,'$'
    espacio db " ",'$'
    parA db "(",'$'
    parC db ")",'$'
    variable db 'x^','$'
    aviso db 'Perteneciente a la fase 2','$'
    simPos db '+','$'
    simNeg db '-','$'
    constante db 'C','$'

    ;--------------------------Mensajes de error  --------------------------
    error1       db 10,10,13,"Error: Opcion invalida",10,10,13,'$'
    error2       db 10,10,13,"Error: No se acepta caracteres vacios",10,10,13,'$'
    error3       db 10,10,13,"Error: Solo se aceptan digitos entre -9 a +9",10,10,13,'$'
    error4       db 10,10,13,"Error: caracter no reconocido",10,10,13,'$'


    
.386
.code

    menuPrincipal:        

        mov ax,@data
        mov ds,ax

        call LimpiarConsola

        push OFFSET saltoLinea
        call soutln

        push OFFSET options
        call soutln
        push OFFSET indicador
        call sout

        ;Menu
        mov ah,01h    ;solicitud de 1 caracter
        int 21h  
        
        push OFFSET saltoLinea
        call sout

        cmp al,'1'               ; comprueba si es uno
        je ingresarCoeficientes
        cmp al,'2'
        je imprimirFuncion
        cmp al,'3'
        je imprimirDerivada
        cmp al,'4'
        je imprimirIntegral
        cmp al, '5'
        je  graficarFuncion
        cmp al, '6'
        je  metodoNewton
        cmp al, '7'
        je  metodoSteffensen
        cmp al, '8'
        je  exit
        jmp invalidOption
        
        call InterrupcionEnter
        jmp menuPrincipal


ingresarCoeficientes:
    call LimpiarConsola
    call ingEcuacion
    call InterrupcionEnter
    jmp menuPrincipal

imprimirFuncion:
    call mostrarEcuacion
    jmp menuPrincipal

imprimirDerivada:
    call calcularDerivada
    jmp menuPrincipal

imprimirIntegral:
    call calcularIntegral
    jmp menuPrincipal

graficarFuncion:     
                        push OFFSET aviso
                        call soutln
                        jmp             menuPrincipal

metodoNewton:        
                        push OFFSET aviso
                        call soutln
                        jmp             menuPrincipal

metodoSteffensen:    
                        push OFFSET aviso
                        call soutln
                        jmp             menuPrincipal

exit:                
                         mov             ah, 4ch
                         int             21h

invalidOption:       
                        push OFFSET            error1
                        call soutln
                        call InterrupcionEnter
                        jmp             menuPrincipal

errorChar:           
                        print           error4
                        jmp             menuPrincipal

; Procedimientos
LimpiarConsola PROC
    mov ah,0Fh
    INT 10h
    mov ah,0
    INT 10h
    ret
LimpiarConsola ENDP

InterrupcionEnter PROC

    push offset separador
    call soutln

    push offset msgInterrupcion
    call soutln

    push offset separador
    call soutln

    mov ah,1    ;solicitud de 1 caracter
    int 21h  

    ret
InterrupcionEnter ENDP

; Procedimiento parecido a la funcion soutln de java la cual imprime con salto de linea
soutln PROC
    push BP
    mov BP, SP
    push AX
    push DX

    mov AH, 09h     ;imprimir una cadena de texto terminada en '$'
    mov DX, [BP+4]  ;direccion de cadena en memoria en segmento de pila
    int 21h

    mov AH, 02      ;imprimir caracter a pantalla
    mov DL, 0ah     ;salto de linea
    int 21h

    pop DX
    pop AX
    pop BP
    ret 2
soutln ENDP

; Procedimiento parecido a la funcion soutln de java la cual imprime 
sout PROC
    push BP
    mov BP, SP
    push AX
    push DX

    mov AH, 09h     ;imprimir una cadena de texto terminada en '$'
    mov DX, [BP+4]  ;direccion de cadena en memoria en segmento de pila
    int 21h

    pop DX
    pop AX
    pop BP
    ret 2
sout ENDP

ingEcuacion PROC

    call ingresoCoeficiente ; primera llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente1, al
    mov pivoteCoeficiente,'4'
    mov DI, offset signo1
    mov SI, offset signoTmp[0]
    call mover    

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo1   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod


    call ingresoCoeficiente ; segunda llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente2, al
    mov pivoteCoeficiente,'3'
    mov DI, offset signo2
    mov SI, offset signoTmp[0]
    call mover

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo2   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod

    call ingresoCoeficiente ; tercera llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente3, al
    mov pivoteCoeficiente,'2'
    mov DI, offset signo3
    mov SI, offset signoTmp[0]
    call mover

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo3   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod


    call ingresoCoeficiente ; cuarta llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente4, al
    mov pivoteCoeficiente,'1'
    mov DI, offset signo4
    mov SI, offset signoTmp[0]
    call mover

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo4   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod

    call ingresoCoeficiente ; primera llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente5, al
    mov pivoteCoeficiente,'0'
    mov DI, offset signo5
    mov SI, offset signoTmp[0]
    call mover

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo5   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod


    call ingresoCoeficiente ; primera llamada
    mov al, numTmp ; reasignacion valores
    mov coeficiente6, al
    mov pivoteCoeficiente,'5'
    mov DI, offset signo6
    mov SI, offset signoTmp[0]
    call mover

    ;agregando caracter de finalizacion al signo para evitar problemas
    mov al, '$'   ; carga el caracter '$' en AL
    mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    add bx, offset signo6   ; calcula la dirección de la siguiente posición de la cadena
    mov [bx], al 
    ;endcod

    ;conversion negativos
    mov si, offset signo1
    mov al, [si]
    cmp al,'-'
    je neg1
    jne continuar1

    neg1:
        neg coeficiente1

    continuar1:
    
    mov si, offset signo2
    mov al, [si]
    cmp al,'-'
    je neg2
    jne continuar2

    neg2:
        neg coeficiente2
    continuar2:
    mov si, offset signo3
    mov al, [si]
    cmp al,'-'
    je neg3
    jne continuar3

    neg3:
        neg coeficiente3
    continuar3:

    mov si, offset signo4
    mov al, [si]
    cmp al,'-'
    je neg4
    jne continuar4

    neg4:
        neg coeficiente4
    continuar4:

    mov si, offset signo5
    mov al, [si]
    cmp al,'-'
    je neg5
    jne continuar5

    neg5:
        neg coeficiente5
    continuar5:

    mov si, offset signo6
    mov al, [si]
    cmp al,'-'
    je neg6
    jne continuar6

    neg6:
        neg coeficiente6
    continuar6:

    push OFFSET saltoLinea
    call sout

    ret
ingEcuacion ENDP

; Resive la literal del coeficiente y la guarda en numTmp
ingresoCoeficiente PROC 

    push OFFSET saltoLinea
    call sout

    push OFFSET msgCoeficiente
    call sout

    push OFFSET pivoteCoeficiente
    call soutln

    push OFFSET indicador
    call sout

    mov ah, 1
    int 21h 

    mov signoTmp,al    

    ; ;agregando caracter de finalizacion al signo para evitar problemas
    ; mov al, '$'   ; carga el caracter '$' en AL
    ; mov bx, 1   ; establece el índice de la siguiente posición de la cadena en BX
    ; add bx, offset signoTmp   ; calcula la dirección de la siguiente posición de la cadena
    ; mov [bx], al 
    ; ;endcod

    mov ah,1    ;guardando las decenas 
    int 21h
    sub al,30h
    mov decenas,al

    mov ah,1    ;guardando las unidades 
    int 21h
    sub al,30h
    mov unidades,al

    ;realizando la operacion para convertir a numero de dos decimales
    mov al,decenas
    mov bl,10d
    mul bl
    add al,unidades
    mov numTmp,al


    ret 
ingresoCoeficiente ENDP

mover PROC
    mov_loop:
    ; Lee el carácter actual de la cadena de origen
    mov bl,al
    MOV AL, [SI]

    ; Si el carácter es cero, termina el bucle
    CMP AL, 0
    JE done
    CMP AL, '$'
    JE done

    ; Escribe el carácter en la cadena de destino
    MOV [DI], AL
    done:

        ret
mover ENDP

mostrarEcuacion PROC

    ;salto de linea incial
    push OFFSET saltoLinea
    call sout

    push OFFSET separador
    call soutln
    
    mov si, offset signo1
    mov al, [si]
    cmp al,'-'
    je mostNeg1
    jne mostPos1

        mostNeg1:
            push OFFSET simNeg
            call sout

            mov al,coeficiente1
            neg al
            jmp mostAv1
        
        mostPos1:
            mov al,coeficiente1

            push OFFSET simPos
            call sout
        
        mostAv1: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'4' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    ;=============Imprimiendo: signo(coeficiente_2)x^n 
        mov si, offset signo2
        mov al, [si]
        cmp al,'-'
        je mostNeg2
        jne mostPos2

        mostNeg2:
            push OFFSET simNeg
            call sout

            mov al,coeficiente2
            neg al
            jmp mostAv2
            
        
        mostPos2:
            mov al,coeficiente2
            push OFFSET simPos
            call sout
        
        mostAv2: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'3' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    
    ; Imprimiebdo: signo(coeficiente_3)x^n 
        mov si, offset signo3
        mov al, [si]
        cmp al,'-'
        je mostNeg3
        jne mostPos3

        mostNeg3:
            push OFFSET simNeg
            call sout

            mov al,coeficiente3
            neg al
            jmp mostAv3
        
        mostPos3:
            mov al,coeficiente3

            push OFFSET simPos
            call sout
        
        mostAv3: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'2' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    ;=============Imprimirneodo: signo(coeficiente_4)x^n 
        mov si, offset signo4
        mov al, [si]
        cmp al,'-'
        je mostNeg4
        jne mostPos4

        mostNeg4:
            push OFFSET simNeg
            call sout

            mov al,coeficiente4
            neg al
            jmp mostAv4
        
        mostPos4:
            mov al,coeficiente4

            push OFFSET simPos
            call sout
        
        mostAv4: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'1' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    ;=============Imprimirneodo: signo(coeficiente_5)x^n 
        mov si, offset signo5
        mov al, [si]
        cmp al,'-'
        je mostNeg5
        jne mostPos5

        mostNeg5:
            push OFFSET simNeg
            call sout

            mov al,coeficiente5
            neg al
            jmp mostAv5
        
        mostPos5:
            mov al,coeficiente5

            push OFFSET simPos
            call sout
        
        mostAv5: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'0' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    ;=============Imprimirneodo: signo(coeficiente_6)x^n 
        mov si, offset signo6
        mov al, [si]
        cmp al,'-'
        je mostNeg6
        jne mostPos6

        mostNeg6:
            push OFFSET simNeg
            call sout

            mov al,coeficiente6
            neg al
            jmp mostAv6
        
        mostPos6:
            mov al,coeficiente6

            push OFFSET simPos
            call sout
        
        mostAv6: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah, 02h
        mov dl,bl
        add dl,30h
        int 21h

        push OFFSET parC
        call sout

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        mov pivoteCoeficiente,'5' ;reasignando el valor de valor de la elevacion

        push OFFSET espacio
        call sout

    push OFFSET saltoLinea
    call sout

    push OFFSET saltoLinea
    call sout

    push OFFSET separador
    call soutln

    ;salto de linea final ================
    call InterrupcionEnter

ret 
mostrarEcuacion ENDP

calcularDerivada PROC

    push OFFSET saltoLinea
    call sout

    push OFFSET mensageDerivada
    call soutln

    ;imprimir coeDerivada 1 
    mov al,coeficiente1
    mov bl,5d
    mul bl
    mov derivada1,al

    mov si, offset signo1
    mov al, [si]
    cmp al,'-'
    je mostNegDer1
    jne mostPosDer1

        mostNegDer1:
            push OFFSET simNeg
            call sout

            mov al,derivada1
            neg al
            jmp mostAvDer1
        
        mostPosDer1:
            mov al,derivada1

            push OFFSET simPos
            call sout
        
        mostAvDer1: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        call imprimirNumeroAL

        push OFFSET parC
        call sout

        mov pivoteCoeficiente,'4'

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        push OFFSET espacio
        call sout

    ;imprimir coeDerivada 2 
    mov al,coeficiente2
    mov bl,4d
    mul bl
    mov derivada2,al

    mov si, offset signo2
    mov al, [si]
    cmp al,'-'
    je mostNegDer2
    jne mostPosDer2

        mostNegDer2:
            push OFFSET simNeg
            call sout

            mov al,derivada2
            neg al
            jmp mostAvDer2
        
        mostPosDer2:
            mov al,derivada2

            push OFFSET simPos
            call sout
        
        mostAvDer2: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        call imprimirNumeroAL

        push OFFSET parC
        call sout

        mov pivoteCoeficiente,'3'

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        push OFFSET espacio
        call sout

    ;imprimir coeDerivada 3 
    mov al,coeficiente3
    mov bl,3d
    mul bl
    mov derivada3,al

    mov si, offset signo3
    mov al, [si]
    cmp al,'-'
    je mostNegDer3
    jne mostPosDer3

        mostNegDer3:
            push OFFSET simNeg
            call sout

            mov al,derivada3
            neg al
            jmp mostAvDer3
        
        mostPosDer3:
            mov al,derivada3

            push OFFSET simPos
            call sout
        
        mostAvDer3: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        call imprimirNumeroAL

        push OFFSET parC
        call sout

        mov pivoteCoeficiente,'2'

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        push OFFSET espacio
        call sout

    ;imprimir coeDerivada 4
    mov al,coeficiente4
    mov bl,2d
    mul bl
    mov derivada4,al

    mov si, offset signo4
    mov al, [si]
    cmp al,'-'
    je mostNegDer4
    jne mostPosDer4

        mostNegDer4:
            push OFFSET simNeg
            call sout

            mov al,derivada4
            neg al
            jmp mostAvDer4
        
        mostPosDer4:
            mov al,derivada4

            push OFFSET simPos
            call sout
        
        mostAvDer4: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        call imprimirNumeroAL

        push OFFSET parC
        call sout

        mov pivoteCoeficiente,'1'

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        push OFFSET espacio
        call sout

    ;imprimir coeDerivada 5 
    mov al,coeficiente5
    mov bl,1d
    mul bl
    mov derivada5,al

    mov si, offset signo5
    mov al, [si]
    cmp al,'-'
    je mostNegDer5
    jne mostPosDer5

        mostNegDer5:
            push OFFSET simNeg
            call sout

            mov al,derivada5
            neg al
            jmp mostAvDer5
        
        mostPosDer5:
            mov al,derivada5

            push OFFSET simPos
            call sout
        
        mostAvDer5: ;avanzar a uno en mostrar

        push OFFSET parA
        call sout

        call imprimirNumeroAL

        push OFFSET parC
        call sout

        mov pivoteCoeficiente,'0'

        push OFFSET variable ;imprimir x 
        call sout

        push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
        call sout

        push OFFSET espacio
        call sout

        ;==================End


        push OFFSET saltoLinea
        call sout

        push OFFSET saltoLinea
        call sout

        push OFFSET separador
        call soutln

        mov pivoteCoeficiente,'5'

        ;salto de linea final ================
        call InterrupcionEnter

    ret

calcularDerivada ENDP

calcularIntegral PROC

    push OFFSET saltoLinea
    call sout

    push OFFSET mensajeIntegral
    call soutln

    ;Integral 1 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo1
        mov al, [si]
        cmp al,'-'
        je mostNegInt1
        jne mostPosInt1

            mostNegInt1:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente1 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,6d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt1,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt1
                jmp mostAvInt1
            
            mostPosInt1:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente1 
                mov bl,6d   
                div bl
                mov valInt1,al

                mov al,valInt1

                push OFFSET simPos
                call sout
            
            mostAvInt1: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'6'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout

    ;Integral 2 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo2
        mov al, [si]
        cmp al,'-'
        je mostNegInt2
        jne mostPosInt2

            mostNegInt2:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente2 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,5d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt2,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt2
                jmp mostAvInt2
            
            mostPosInt2:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente2 
                mov bl,5d   
                div bl
                mov valInt2,al

                mov al,valInt2

                push OFFSET simPos
                call sout
            
            mostAvInt2: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'5'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout

    ;Integral 3 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo3
        mov al, [si]
        cmp al,'-'
        je mostNegInt3
        jne mostPosInt3

            mostNegInt3:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente3 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,4d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt3,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt3
                jmp mostAvInt3
            
            mostPosInt3:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente3 
                mov bl,4d   
                div bl
                mov valInt3,al

                mov al,valInt3

                push OFFSET simPos
                call sout
            
            
            mostAvInt3: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'4'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout
        
    ;Integral 4 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo4
        mov al, [si]
        cmp al,'-'
        je mostNegInt4
        jne mostPosInt4

            mostNegInt4:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente4 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,3d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt4,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt4
                jmp mostAvInt4
            
            mostPosInt4:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente4 
                mov bl,3d   
                div bl
                mov valInt4,al

                mov al,valInt4

                push OFFSET simPos
                call sout

            mostAvInt4: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'3'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout

    ;Integral 5 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo5
        mov al, [si]
        cmp al,'-'
        je mostNegInt5
        jne mostPosInt5

            mostNegInt5:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente5 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,2d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt5,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt5
                jmp mostAvInt5
            
            mostPosInt5:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente5
                mov bl,2d   
                div bl
                mov valInt5,al

                mov al,valInt5

                push OFFSET simPos
                call sout
            
            mostAvInt5: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'2'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout

    ;Integral 6 =====================

        ;validar si es negativo para realizar la negacion para imprimir
        mov si, offset signo6
        mov al, [si]
        cmp al,'-'
        je mostNegInt6
        jne mostPosInt6

            mostNegInt6:

                xor ax,ax   ;reiniciar el registro
                xor bx,bx   ;reiniciar el registro
                mov al,coeficiente6 ;mover el contenido del coeficiente a la parte baja del registro
                neg al      ;se niega para poder realizar la division
                
                mov bl,1d   ;mover el divisor a la parte baja de BX
                idiv bl     ;realizar la division
                mov valInt6,al  ;realizar la division y asignar el valor a la variable

                push OFFSET simNeg
                call sout

                mov al,valInt6
                jmp mostAvInt6
            
            mostPosInt6:
                xor ax,ax   
                xor bx,bx  
            
                mov al,coeficiente6 
                mov bl,1d   
                div bl
                mov valInt6,al

                mov al,valInt6

                push OFFSET simPos
                call sout
            
            mostAvInt6: ;avanzar a uno en mostrar

            push OFFSET parA
            call sout

            call imprimirNumeroAL   ;en este punto el numero esta en al

            push OFFSET parC
            call sout

            mov pivoteCoeficiente,'1'

            push OFFSET variable ;imprimir x 
            call sout

            push OFFSET pivoteCoeficiente ;imprimir el valor del coeficiente
            call sout

            push OFFSET espacio
            call sout

    ;Imprimir constante ================

        push OFFSET simPos
        call sout

        push OFFSET constante
        call sout

    ;---------------fin calculo

        push OFFSET saltoLinea
        call sout

        push OFFSET saltoLinea
        call sout

        push OFFSET separador
        call soutln

        mov pivoteCoeficiente,'5'

        ;salto de linea final ================
        call InterrupcionEnter

    ret
calcularIntegral ENDP

imprimirNumeroAL PROC
    AAM
    mov bx,ax
    mov ah,02h
    mov dl,bh
    add dl,30h
    int 21h

    mov ah, 02h
    mov dl,bl
    add dl,30h
    int 21h
    ret
imprimirNumeroAL ENDP




end menuPrincipal