; macros de uso general
print macro cadena
          mov ah, 09h
          mov dx, offset cadena
          int 21h
endm
