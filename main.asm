imprimir macro string
    mov ah,09
    mov dx,offset string
    int 21h
endm

pedirInicial macro
    LOCAL Pedir,Pedir2,pedirneg,pedirneg2,conv2,converitr,PedirFin
    Pedir:
        imprimir intervaloini
        imprimir salto
        getChar
        cmp al,45       ;si primero viene un negativo
            je pedirneg
        cmp al,48          ;0
            je Pedir2
        cmp al,49
            je Pedir2
        cmp al,50
            je Pedir2
        cmp al,51
            je Pedir2
        cmp al,52
            je Pedir2
        cmp al,53
            je Pedir2
        cmp al,54
            je Pedir2
        cmp al,55
            je Pedir2
        cmp al,56
            je Pedir2
        cmp al,57       ;9
            je Pedir2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

        Pedir2:
            sub al,48   ;quitar para obtener el valor real
            mov ah,0
            mov iniX,ax

            getChar
            cmp al,13
                je PedirFin

            cmp al,48          ;0
                je converitr
            cmp al,49
                je converitr
            cmp al,50
                je converitr
            cmp al,51
                je converitr
            cmp al,52
                je converitr
            cmp al,53
                je converitr
            cmp al,54
                je converitr
            cmp al,55
                je converitr
            cmp al,56
                je converitr
            cmp al,57       ;9
                je converitr

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        converitr:
            sub al,48 ; se que quita el ascci
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,iniX
            mov bx,10
            mul bx
            add ax,cx
            mov iniX,ax
            jmp PedirFin

        pedirneg:
            getChar

            cmp al,48          ;0
                je pedirneg2
            cmp al,49
                je pedirneg2
            cmp al,50
                je pedirneg2
            cmp al,51
                je pedirneg2
            cmp al,52
                je pedirneg2
            cmp al,53
                je pedirneg2
            cmp al,54
                je pedirneg2
            cmp al,55
                je pedirneg2
            cmp al,56
                je pedirneg2
            cmp al,57       ;9
                je pedirneg2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        pedirneg2:  
            mov ah,0
            sub al,48   ; se le quita el ascii
            neg ax      ;se niega el numero convierte negativo
            mov iniX,ax ; se guarda en la varible

            getChar

            cmp al,13
            je PedirFin

            cmp al,48          ;0
                je conv2
            cmp al,49
                je conv2
            cmp al,50
                je conv2
            cmp al,51
                je conv2
            cmp al,52
                je conv2
            cmp al,53
                je conv2
            cmp al,54
                je conv2
            cmp al,55
                je conv2
            cmp al,56
                je conv2
            cmp al,57       ;9
                je conv2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal
        conv2:
            sub al,48
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,iniX
            neg ax
            mov bx,10
            mul bx
            add ax,cx
            neg ax
            mov iniX,ax
            jmp PedirFin

        PedirFin:
            PedirFinal
            
            ;PintarPlano
    
endm


PedirFinal macro
    LOCAL PedirFin,FinNeg,Pedir2,converitr,pedirneg2,conv2,Evaluar
    PedirFin:
        imprimir salto
        imprimir intervalofin
        imprimir salto
        getChar
        cmp al, 45
            je FinNeg
            
        cmp al,48          ;0
            je Pedir2
        cmp al,49
            je Pedir2
        cmp al,50
            je Pedir2
        cmp al,51
            je Pedir2
        cmp al,52
            je Pedir2
        cmp al,53
            je Pedir2
        cmp al,54
            je Pedir2
        cmp al,55
            je Pedir2
        cmp al,56
            je Pedir2
        cmp al,57       ;9
            je Pedir2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
        
    Pedir2:
        sub al,48   ;quitar para obtener el valor real
        mov ah,0
        mov finX,ax

        getChar
        cmp al,13
            je Evaluar

        cmp al,48          ;0
            je converitr
        cmp al,49
            je converitr
        cmp al,50
            je converitr
        cmp al,51
            je converitr
        cmp al,52
            je converitr
        cmp al,53
            je converitr
        cmp al,54
            je converitr
        cmp al,55
            je converitr
        cmp al,56
            je converitr
        cmp al,57       ;9
            je converitr

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    converitr:
        sub al,48
        xor cx,cx
        mov cl,al
        xor ax,ax
        mov ax,finX
        mov bx,10
        mul bx
        add ax,cx
        mov finX,ax
        jmp Evaluar
    FinNeg:
        getChar

        cmp al,48          ;0
            je pedirneg2
        cmp al,49
            je pedirneg2
        cmp al,50
            je pedirneg2
        cmp al,51
            je pedirneg2
        cmp al,52
            je pedirneg2
        cmp al,53
            je pedirneg2
        cmp al,54
            je pedirneg2
        cmp al,55
            je pedirneg2
        cmp al,56
            je pedirneg2
        cmp al,57       ;9
            je pedirneg2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    pedirneg2:  
            mov ah,0
            sub al,48   ; se le quita el ascii
            neg ax      ;se niega el numero convierte negativo
            mov finX,ax ; se guarda en la varible

            getChar

            cmp al,13
            je Evaluar

            cmp al,48          ;0
                je conv2
            cmp al,49
                je conv2
            cmp al,50
                je conv2
            cmp al,51
                je conv2
            cmp al,52
                je conv2
            cmp al,53
                je conv2
            cmp al,54
                je conv2
            cmp al,55
                je conv2
            cmp al,56
                je conv2
            cmp al,57       ;9
                je conv2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        conv2:
            sub al,48
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,finX
            neg ax
            mov bx,10
            mul bx
            add ax,cx
            neg ax
            mov finX,ax
            jmp Evaluar

        Evaluar:
            EvaluarIntervalo
endm


getChar macro
    mov ah,0dh
    int 21h
    mov ah,01h
    int 21h
endm

InterrupcionEnter MACRO 
    mov ah,0dh
    int 21h
    mov ah,01h
    int 21h
ENDM

; macros de uso general
print macro cadena
          mov ah, 09h
          mov dx, offset cadena
          int 21h
endm

pintar macro x,y ,color
	mov ah, 0ch
	mov cx, x ; columna
	mov dx, y ; fila
	mov al, color ;en al almacena el color
	mov bh, 0
	int 10h
endm

; funcion encarga de pintar el plano
PintarPlano macro 
    LOCAL pintarx,parar,pintaryll,salir,G1,G2,G3
	mov ax, 0013h ;este es para 40x25 46 colores 320x200
	int 10h
    xor si,si

    pintarx:
        cmp si,320 ;maximo de la pantalla en x
            je parar
        pintar si,99,2
        inc si
        jmp pintarx
    parar:
        xor si,si
        jmp pintaryll
    pintaryll:
        cmp si,200 ; en y
		je salir
        pintar 150, si, 2
        inc si
        jmp pintaryll
    salir:
        jmp G1

    G1:
        GraficarNormal    
endm

EvaluarIntervalo macro
    LOCAL Evaluar1,Evaluar2,Evaluar3,error,plano,Ev1
    Evaluar1:
        xor ax,ax
        mov ax,iniX
        add ax,0
        js Evaluar2
        xor ax,ax
        mov ax,iniX
        cmp ax,finX
            ja error
        jmp plano


    Evaluar2:
        xor ax,ax
        mov ax,finX
        add ax,0
        js Evaluar3
        jmp plano

    Evaluar3:
        xor ax,ax
        xor bx,bx
        mov ax, iniX
        mov bx,finX
        neg ax
        neg bx
        cmp ax,bx
        jb error
        jmp plano
    error:
        imprimir salto
        imprimir msjerror2
        jmp Crear
    plano:
        PintarPlano
        jmp MenuPrincipal
        
        
endm


GraficarDerivada macro
    LOCAL Grafica,PosXX,PosX1,PosX2,PosX3,PosX4,PosX5,PosX6,Positivo,negativo,Fin
    Grafica:
        mov result, 0
        xor ax,ax
        
        mov ax,iniX ;paso el intervalo inicial
        mov posx,ax ; a posicion x
        xor ax,ax   ;se limpia ax
        xor si,si
        mov ax,finX ;paso intervalo final 
        mov si,ax   ;a si
        inc si      ;y se incrementa
        xor di,di
    PosXX:
        cmp posx,si
            je Fin
        jmp PosX2

    PosX2:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        mul bx   ; x*x*x*x
        xor bx,bx
        mov bx,derivada4
        mul bx       ; coeficiente * x4
        mov result,ax
    PosX3: ;x3
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        mul bx
        xor bx,bx
        mov bx,coeficiente3
        mul bx
        add ax,result
        mov result,ax
    PosX4:   ;x2
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        xor bx,bx
        mov bx,coeficiente2
        mul bx
        add ax,result
        mov result,ax
    PosX5: ;x1
        xor ax,ax
        xor bx,bx
        mov ax,posx
        xor bx,bx
        mov bx,coeficiente1
        mul bx
        add ax,result
        mov result,ax
    
    PosX6:   ; coeficiente 0 solo se suma 
        xor ax,ax
        mov ax,coeficiente0
        add ax,result
        mov result,ax
        add ax,0
        js negativo
        jmp Positivo
    Positivo:
        inc posx
        mov bx,result
        cmp bx,99
            ja PosXX
        xor ax,ax
        mov ax,99
        sub ax,bx

        mov posy,ax
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15

        inc cx
        xor ax,ax
        xor bx,bx
        mov ax,result

        jmp PosXX
    
    negativo:
        inc posx
        mov bx,result
        neg bx
        cmp bx,99
            ja PosXX

        xor ax,ax
        mov ax,99
        add ax,bx
        inc ax
        mov posy,ax
        
        mov cx,posx
        dec cx
        add cx,150
        
        pintar cx,posy,15

        xor ax,ax
        xor bx,bx
        jmp PosXX
    Fin:
        getChar
        mov ah,00h
        mov al,03h
        int 10h
        
        jmp menuPrincipal

endm



; Grafica de la funcion Normal
GraficarNormal macro
    LOCAL Grafica,PosXX,PosX1,PosX2,PosX3,PosX4,PosX5,PosX6,Positivo,negativo,Fin
    Grafica:
        mov result, 0
        xor ax,ax
        
        mov ax,iniX ;paso el intervalo inicial
        mov posx,ax ; a posicion x
        xor ax,ax   ;se limpia ax
        xor si,si
        mov ax,finX ;paso intervalo final 
        mov si,ax   ;a si
        inc si      ;y se incrementa
        xor di,di
    PosXX:
        cmp posx,si
            je Fin
        jmp PosX1

    PosX1:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        mul bx   ; x*x*x*x
        mul bx   ; x*x*x*x*x
        xor bx,bx
        mov bx,coeficiente5
        mul bx       ; coeficiente * x5
        mov result,ax
    PosX2:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        mul bx   ; x*x*x*x
        xor bx,bx
        mov bx,coeficiente4
        mul bx       ; coeficiente * x4
        mov result,ax
    PosX3: ;x3
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        mul bx
        xor bx,bx
        mov bx,coeficiente3
        mul bx
        add ax,result
        mov result,ax
    PosX4:   ;x2
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        xor bx,bx
        mov bx,coeficiente2
        mul bx
        add ax,result
        mov result,ax
    PosX5: ;x1
        xor ax,ax
        xor bx,bx
        mov ax,posx
        xor bx,bx
        mov bx,coeficiente1
        mul bx
        add ax,result
        mov result,ax
    
    PosX6:   ; coeficiente 0 solo se suma 
        xor ax,ax
        mov ax,coeficiente0
        add ax,result
        mov result,ax
        add ax,0
        js negativo
        jmp Positivo
    Positivo:
        inc posx
        mov bx,result
        cmp bx,99
            ja PosXX
        xor ax,ax
        mov ax,99
        sub ax,bx

        mov posy,ax
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15

        inc cx
        xor ax,ax
        xor bx,bx
        mov ax,result

        jmp PosXX
    
    negativo:
        inc posx
        mov bx,result
        neg bx
        cmp bx,99
            ja PosXX

        xor ax,ax
        mov ax,99
        add ax,bx
        inc ax
        mov posy,ax
        
        mov cx,posx
        dec cx
        add cx,150
        
        pintar cx,posy,15

        xor ax,ax
        xor bx,bx
        jmp PosXX
    Fin:
        getChar
        mov ah,00h
        mov al,03h
        int 10h
        
        jmp menuPrincipal

endm

.model small
.stack
.386
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
    
    msgCoeficiente5 db "Ingrece coeficiente para X^5: $"
    msgCoeficiente4 db "Ingrece coeficiente para X^4: $"
    msgCoeficiente3 db "Ingrece coeficiente para X^3: $"
    msgCoeficiente2 db "Ingrece coeficiente para X^2: $"
    msgCoeficiente1 db "Ingrece coeficiente para X^1: $"
    msgCoeficiente0 db "Ingrece coeficiente para X^0: $"

    exponente6 db " X^6 $"
    exponente5 db " X^5 $"
    exponente4 db " X^4 $"
    exponente3 db " X^3 $"
    exponente2 db " X^2 $"
    exponente1 db " X^1 $"
    exponente0 db " X^0 $"
    constante db ' + C$'
    noes db' << ERROR SOLO SE ACEPTAN NUMEROS (0-9)',13,10,'$'
    invalidMsg db "Numero invalido, ingrese oto$"
    indicador db "consola>", '$'
    saltoLinea db " ",0ah,'$'
    newLine db 13,10,'$'
    error1       db 10,10,13,"Error: Opcion invalida",10,10,13,'$'
    debug db "Aca andoooo", '$'
    val dw 0
    counter db 0
    salto db 13,10,'$'
    msjerror2 db '<< Error el intervalo inicial es mayor al final ',13,10,"$"
    intervaloini db 'Ingrese el valor inicial del intervalo: $',10
    intervalofin db 'Ingrese el valor final del intervalo: $',13,10
;----------------para intervalos----------------
iniX dw 0
finX dw 10

;----------------para graficar normal-----------
posx dw 0
posy dw 10

result dw 0
; falta para coeficiente 5

    ; Coeficientes de la funcion
    coeficiente0 dw 0d
    coeficiente1 dw 0d
    coeficiente2 dw 0d
    coeficiente3 dw 0d
    coeficiente4 dw 0d
    coeficiente5 dw 0d
    coeficiente6 dw 0d

    ; Coeficientes de la integral
    coeficienteIntegral0 dw 0d
    coeficienteIntegral1 dw 0d
    coeficienteIntegral2 dw 0d
    coeficienteIntegral3 dw 0d
    coeficienteIntegral4 dw 0d
    coeficienteIntegral5 dw 0d
    coeficienteIntegral6 dw 0d

    ; derivadas
    derivada1 dw 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada2 dw 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada3 dw 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada4 dw 0d  ;variable para almacenar la derivada de su respectivo coeficiente
    derivada5 dw 0d  ;variable para almacenar la derivada de su respectivo coeficiente


    ; signos
    signoCoeficiente0 db '+','$'
    signoCoeficiente1 db '+','$'
    signoCoeficiente2 db '+','$'
    signoCoeficiente3 db '+','$'
    signoCoeficiente4 db '+','$'
    signoCoeficiente5 db '+','$'
    signoCoeficiente6 db '+','$'

    signoPositivo db '+$'



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
        mov ah,01h 
        int 21h

        push OFFSET saltoLinea
        call sout

        cmp al,'1'               ; comprueba si es uno
        je ingresarCoeficientes
        cmp al,'2'               ; comprueba si es uno
        je imprimirFuncion
        cmp al,'3'
        je imprimirDerivada
        cmp al,'4'
        je imprimirIntegral
        cmp al, '5'
        je  graficarFuncion
        cmp al, '8'
        je  exit
        jmp invalidOption


saltoEtiqueta:
    mov ah,09h
	mov dx, offset debug
    int 21h

imprimirFuncion:
    call imprimirEcuacion
    InterrupcionEnter
    jmp menuPrincipal

imprimirDerivada:
    call calcularDerivada
    call imprimirEcuacionDerivada
    InterrupcionEnter
    jmp menuPrincipal

imprimirIntegral:
    call calcularIntegral
    call imprimirEcuacionIntegral
    InterrupcionEnter
    jmp menuPrincipal

ingresarCoeficientes:
    call LimpiarConsola

    ; Se ingresa el valor para el coeficiente 0
    mov ah,09h
	mov dx, offset msgCoeficiente0
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente0, al
    call inputNumber
    mov ax, val
    mov coeficiente0, ax

    cmp signoCoeficiente0, '-'
    je negacionC0
    jne pos0

    negacionC0: 
        neg coeficiente0

    pos0:

    ; Se ingresa el valor para el coeficiente 1
    mov ah,09h
	mov dx, offset msgCoeficiente1
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente1, al
    call inputNumber
    mov ax, val
    mov coeficiente1, ax

    cmp signoCoeficiente1, '-'
    je negacionC1
    jne pos1 

    negacionC1: 
        neg coeficiente1

    pos1:

    ; Se ingresa el valor para el coeficiente 2
    mov ah,09h
	mov dx, offset msgCoeficiente2
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente2, al
    call inputNumber
    mov ax, val
    mov coeficiente2, ax

    cmp signoCoeficiente2, '-'
    je negacionC2
    jne pos2

    negacionC2: 
        neg coeficiente2

    pos2:
    ; Se ingresa el valor para el coeficiente 3
    mov ah,09h
	mov dx, offset msgCoeficiente3
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente3, al
    call inputNumber
    mov ax, val
    mov coeficiente3, ax

    cmp signoCoeficiente3, '-'
    je negacionC3
    jne pos3

    negacionC3:
        neg coeficiente3

    pos3:

    ; Se ingresa el valor para el coeficiente 4
    mov ah,09h
	mov dx, offset msgCoeficiente4
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente4, al
    call inputNumber
    mov ax, val
    mov coeficiente4, ax

    cmp signoCoeficiente4, '-'
    je negacionC4
    jne pos4

    negacionC4: 
        neg coeficiente4
    
    pos4:

    ; Se ingresa el valor para el coeficiente 5
    mov ah,09h
	mov dx, offset msgCoeficiente5
    int 21h
    mov ah, 1
	int 21h
    mov signoCoeficiente5, al
    call inputNumber
    mov ax, val
    mov coeficiente5, ax

    cmp signoCoeficiente5, '-'
    je negacionC5
    jne pos5

    negacionC5: 
        neg coeficiente5

    pos5:

    jmp menuPrincipal

; Falta reiniciar las variables

Crear:
    PedirInicial

exit:             
                         mov             ah, 4ch
                         int             21h
graficarFuncion:     
                        PedirInicial
                        InterrupcionEnter
                        jmp             menuPrincipal

invalidOption:       
                        push OFFSET            error1
                        call soutln
                        InterrupcionEnter
                        jmp             menuPrincipal

imprimirCoeficiente1:
    mov ax, coeficiente0
    mov val, ax
    mov ah, 09h
    mov dx, offset debug
    int 21h
    call printNumber
    InterrupcionEnter
    jmp menuPrincipal

; Procedimientos

calcularDerivada PROC
    ;derivada 1
    mov ax, coeficiente1
    mov derivada1, ax

    ;derivada coeficiente 2 *2
    mov ax, coeficiente2
    mov bx, 2
    mov dx, 0
    mul bx
    mov derivada2, ax

    ;derivada coeficiente 3 *3
    mov ax, coeficiente3
    mov bx, 3
    mov dx, 0
    mul bx
    mov derivada3, ax

    ;derivada coeficiente 4 *4
    mov ax, coeficiente4
    mov bx, 4
    mov dx, 0
    mul bx
    mov derivada4, ax

    ;derivada coeficiente 5 *5
    mov ax, coeficiente5
    mov bx, 5
    mov dx, 0
    mul bx
    mov derivada5, ax
    ret
calcularDerivada ENDP


calcularIntegral PROC

    ; coeficiente 0 solo se divide entre 1 
    mov ax, coeficiente0
    mov coeficienteIntegral0, ax

    ;Integral coeficiente1 /2
    mov ax, coeficiente1
    mov bx, 2
    mov dx, 0
    div bx
    mov coeficienteIntegral1, ax

    ;Integral coeficiente2 /3
    mov ax, coeficiente2
    mov bx, 3
    mov dx, 0
    div bx
    mov coeficienteIntegral2, ax

    ;Integral coeficiente3 /4
    mov ax, coeficiente3
    mov bx, 4
    mov dx, 0
    div bx
    mov coeficienteIntegral3, ax

    ;Integral coeficiente4 /5
    mov ax, coeficiente4
    mov bx, 5
    mov dx, 0
    div bx
    mov coeficienteIntegral4, ax

    ;Integral coeficiente5 /6
    mov ax, coeficiente5
    mov bx, 6
    mov dx, 0
    div bx
    mov coeficienteIntegral5, ax

    ret
  
calcularIntegral ENDP

imprimirEcuacionIntegral proc
    ;imprimir coeficiente integral 6

    ;imprimir coeficiente integral 5
    mov ax, coeficienteIntegral5
    cmp ax, 0
    jl integra5

    imprimirPositivoI5:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra5:
        mov ax, coeficienteIntegral5
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente5
        int 21h

    ;imprimir coeficiente integral 4
    mov ax, coeficienteIntegral4
    cmp ax, 0
    jl integra4

    imprimirPositivoI4:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra4:
        mov ax, coeficienteIntegral4
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente4
        int 21h

    ;imprimir coeficiente integral 3
    mov ax, coeficienteIntegral3
    cmp ax, 0
    jl integra3

    imprimirPositivoI3:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra3:
        mov ax, coeficienteIntegral3
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente3
        int 21h

    ;imprimir coeficiente integral 2
    mov ax, coeficienteIntegral2
    cmp ax, 0
    jl integra2

    imprimirPositivoI2:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra2:
        mov ax, coeficienteIntegral2
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente2
        int 21h
    
    ;imprimir coeficiente integral 1
    mov ax, coeficienteIntegral1
    cmp ax, 0
    jl integra1

    imprimirPositivoI1:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra1:
        mov ax, coeficienteIntegral1
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente1
        int 21h
    
    ;imprimir coeficiente integral 0
    mov ax, coeficienteIntegral0
    cmp ax, 0
    jl integra0

    imprimirPositivoI0:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    integra0:
        mov ax, coeficienteIntegral0
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente0
        int 21h

        mov ah, 09h
        mov dx, offset constante
        int 21h

    ret

imprimirEcuacionIntegral endp


imprimirEcuacionDerivada proc

    ;imprimir  derivada 5
    mov ax, derivada5
    cmp ax, 0
    jl deriv5

    imprimirPositivod5:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    deriv5:
        mov ax, derivada5
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente4
        int 21h

    ;imprimir  derivada 4
    mov ax, derivada4
    cmp ax, 0
    jl deriv4

    imprimirPositivod4:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    deriv4:
        mov ax, derivada4
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente3
        int 21h
    
    ;imprimir  derivada 3
    mov ax, derivada3
    cmp ax, 0
    jl deriv3

    imprimirPositivod3:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    deriv3:
        mov ax, derivada3
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente2
        int 21h

    ;imprimir  derivada 2
    mov ax, derivada2
    cmp ax, 0
    jl deriv2

    imprimirPositivod2:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    deriv2:
        mov ax, derivada2
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente1
        int 21h
    
    ;imprimir  derivada 1
    mov ax, derivada1
    cmp ax, 0
    jl deriv1

    imprimirPositivod1:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h


    deriv1:
        mov ax, derivada1
        mov val, ax
        call printNumber
        mov ah, 09h
        mov dx, offset exponente1
        int 21h
    ret

imprimirEcuacionDerivada endp



imprimirEcuacion proc

    ;imprimir coeficiente
    cmp signoCoeficiente5, '+'
    je imprimirPositivo5
    jne imprimirNeg5;

    imprimirPositivo5:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg5:


    mov ax, coeficiente5
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente5
    int 21h

    ;imprimir coeficiente
    cmp signoCoeficiente4, '+'
    je imprimirPositivo4
    jne imprimirNeg4;

    imprimirPositivo4:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg4:
        

    mov ax, coeficiente4
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente4
    int 21h

    ;imprimir coeficiente
    cmp signoCoeficiente3, '+'
    je imprimirPositivo3
    jne imprimirNeg3;

    imprimirPositivo3:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg3:
        

    mov ax, coeficiente3
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente3
    int 21h

    ;imprimir coeficiente
    cmp signoCoeficiente2, '+'
    je imprimirPositivo2
    jne imprimirNeg2;

    imprimirPositivo2:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg2:
        

    mov ax, coeficiente2
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente2
    int 21h
    
    ;imprimir coeficiente
    cmp signoCoeficiente1, '+'
    je imprimirPositivo1
    jne imprimirNeg1;

    imprimirPositivo1:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg1:
        

    mov ax, coeficiente1
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente1
    int 21h

    ;imprimir coeficiente
    cmp signoCoeficiente0, '+'
    je imprimirPositivo0
    jne imprimirNeg0;

    imprimirPositivo0:
        mov ah, 09h
        mov dx, offset signoPositivo
        int 21h
    
    imprimirNeg0:
        
    mov ax, coeficiente0
    mov val, ax
    call printNumber
    mov ah, 09h
    mov dx, offset exponente0
    int 21h
    ret
imprimirEcuacion endp

inputNumber proc
    mov val,0
    mov ax,0
again: 
    mov val,ax
    mov ah,01h
    int 21h
    cmp al,0dh
    JE endLoop
    cmp al,' '
    JE endLoop
    cmp al,'0'
    JB inv
    cmp al,'9'
    JA inv
    JMP store
inv:   
	
	call printNewLine
	mov ah,09h
	mov dx,offset invalidMsg
	int 21h
	mov val,0
	mov ax, 0
	JMP again
    JMP endLoop
store:
    sub al,30h
    mov ch,al
    mov cl,10
    mov ax,val
    mul cl
    mov cl,ch
    mov ch,0
    add ax,cx
    mov val,ax
    JMP again
endLoop:

    ret
inputNumber endp

;Imprime un numero de 16 bits en pantalla
printNumber PROC
	push ax
	push bx
	push cx
	push dx
	
	mov ax, val
	cmp ax, 0
	JNL lab
	not ax
	add ax, 1
	mov val, ax
	mov ah, 02h
	mov dl, '-'
	int 21h
	
lab:
	mov counter,0						; counter = no of digitst in num, set no of digit = 0
	mov bx,10							
	mov ax,val							; save value in ax
	cmp ax,0							; if num is zero, then print 0 and exit
	JNE saveDigit						; if num is not zero then save digit
	mov ah,02h		
	mov dl,'0'	
	int 21h
	JMP stopPrint						; if val = 0 , then display zero only and exit						
saveDigit:
	cmp ax,0							; stop when val become zero or less mean when ax<0					
	JBE stopSaveDigit 
	mov dx,0							; set dx=0
	div bx								; div ax by bx, divide number by base 
	push dx								; remainder will save on dx, we will push it on stack	
	inc counter							; inc counter, increase the no of digits	
	JMP saveDigit						; save next digit
stopSaveDigit:
	
	mov cl,1							;loop counter cl =1
startPrint:
	cmp cl,counter						;check if cl > no of digitst , then stop printing the digit
	JA stopPrint						
	mov ah,02h					
	pop dx	
	add dl,'0'							; digit to character
	int 21h
	inc cl								; inc the loop counter
	JMP startPrint						; print next digit
stopPrint:								;stop print
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret
printNumber ENDP

printNewLine proc
	mov ah,09h
	mov dx, offset newLine
	int 21h
	ret
printNewLine endp

LimpiarConsola PROC
    mov ah,0Fh
    INT 10h
    mov ah,0
    INT 10h
    ret
LimpiarConsola ENDP

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

end menuPrincipal