include macros.asm
.model small
.stack 400h
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

    signo1 db 0d  ; define la variable signo como un carácter (1 byte)
    signo2 db 0d  ; define la variable signo como un carácter (1 byte)
    signo3 db 0d  ; define la variable signo como un carácter (1 byte)
    signo4 db 0d  ; define la variable signo como un carácter (1 byte)
    signo5 db 0d  ; define la variable signo como un carácter (1 byte)
    signo6 db 0d  ; define la variable signo como un carácter (1 byte)

    derivada1 db 0d  ;variables para almacenar el contenido de la derivada
    derivada2 db 0d
    derivada3 db 0d
    derivada4 db 0d
    derivada5 db 0d

    valInt1 db 0d   ;variables para almacenar el contenido de la integral
    valInt2 db 0d
    valInt3 db 0d
    valInt4 db 0d
    valInt5 db 0d
    valInt6 db 0d

    ;almacenadores
    decenas db 0
    unidades db 0
    numTmp db 0d
    signoTmp db 0
    
    msgAdvertenciaNegativo db "*******************************",0ah, 
        "No puede ingresar una opcion negativa",0ah,
        "Intente nuevamente...",0ah,
        "*******************************",0ah,0ah,'$'

    msgAdvertenciaSalto db "*******************************",0ah, 
        "Ingrese una opcion valida",0ah,
        "Intente nuevamente...",0ah,
        "*******************************",0ah,0ah,'$'
    
    msgInterrupcion db 'Presiona enter para continuar','$'

    ;Mensajes de informacion
    mensageDerivada db "**************** DERIVADA ***************",0ah,'$'
    mensajeIntegral db "**************** DERIVADA ***************",0ah,'$'
    separador db "*******************************",0ah,'$'
    
    indicador db "consolap>", '$'
    
    msgSigno db "ingresa el signo del coeficiente que deseas agregar (+/-)",'$'

    pivoteCoeficiente db "5",'$' ; para indicar que coeficiente se ingresa

    msgCoeficiente db "Ingresa el valor del coeficiente para x^",'$'

    saltoLinea db " ",0ah,'$'

    espacio db " ",'$'

    parA db "(",'$'

    parC db ")",'$'

    variable db 'x^','$'

    aviso db '','$'

    simPos db '+','$'
    simNeg db '-','$'

    constante db 'C','$'

    ;==============Mensajes de la opcion uno=========================
    msIndicador db "El valor del coeficiente es ",'$'

    msgMayor db "Es mayor",0ah,'$'

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

        cmp al,'-'               ; comprueba si es el signo es menos
        je  es_negativo
        cmp al,13                ; comprueba si es el carácter de nueva línea
        je  es_salto 
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
        ;jmp invalidOption
        
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
                         print           error1
                         jmp             menuPrincipal

    errorChar:           
                         print           error4
                         jmp             menuPrincipal
es_salto:           
    mov ah,9
    mov dx,offset msgAdvertenciaSalto
    int 21h

    call InterrupcionEnter

    jmp menuPrincipal

es_negativo:   
    push OFFSET msgAdvertenciaNegativo
    call soutln

    call InterrupcionEnter

    jmp menuPrincipal

soutln PROC
    ;------------------------------------------------------------------------------
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

sout PROC
    ;------------------------------------------------------------------------------
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

ingresoCoeficiente PROC ;para solicitud del coeficiente y lo vamos a guardar en numTmp
    ;------------------------------------------------------------------------------

    ;solicitud de un coeficiente
    push OFFSET saltoLinea
    call sout

    push OFFSET msgCoeficiente
    call sout

    push OFFSET pivoteCoeficiente
    call soutln

    push OFFSET indicador
    call sout

    ;definiendo su signo
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

    ; ; Avanza el puntero de la cadena de destino
    ; INC DI

    ; ; Avanza el puntero de la cadena de origen
    ; INC SI
    ; ; Vuelve al menuPrincipal del bucle
    ; JMP mov_loop

; Fin del programa
done:

    ret
mover ENDP

mostrarEcuacion PROC

    ;salto de linea incial
    push OFFSET saltoLinea
    call sout

    push OFFSET separador
    call soutln
    
    ;=============Imprimirneodo: signo(coeficiente_1)x^n 
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

    ;=============Imprimirneodo: signo(coeficiente_2)x^n 
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

    
    ;=============Imprimirneodo: signo(coeficiente_3)x^n 
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

mostrarC1 PROC

    push OFFSET saltoLinea
    call sout
    
    push OFFSET separador
    call sout

    ; Utiliza la interrupción 21h para imprimir la cadena de destino
    mov si, offset signo1
    mov dx, [si]
    mov ah, 02h
    int 21h
    ;fin >>>>>>>>

    push OFFSET parA
    call sout

    
    mov al,coeficiente1 ;imprimir el numero
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

    ;coeficiente2
    mov ah, 09h
    mov dx, offset signo2[0]
    int 21h

    push OFFSET parA
    call sout

    

    mov al,coeficiente2 ;imprimir el numero
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
    ;FIN============================

    push OFFSET saltoLinea
    call sout
    push OFFSET separador
    call sout

ret
mostrarC1 ENDP

banderazo PROC
    push OFFSET  aviso
    call soutln
    ret
banderazo ENDP

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


end menuPrincipal