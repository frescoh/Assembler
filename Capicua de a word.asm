; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"    
    AREA db 10 dup(0x1,0x2,0x3,0x4,0x5,0x5,0x4,0x3,0x2,0x1)   
 
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here     
    ;Verificar si AREA es capicua
    ;Si es capicua cx = 1 sino cx=0
    mov di,0 ;inicializo -> di debe incrementar 
    mov si,8 ;inicializo -> si debe decrementar  inicia en 8 porque toma de a 2 bytes
    ;condicion de parada di>=si     
    ;Ejecutar mientras di<si
inicio:
    mov ax, word ptr AREA[di]    ; carga [low,hig] 
    mov bx, word ptr AREA[si]  
    cmp al,bh 
    jne no_capicua
    cmp ah,bl
    jne no_capicua      
    inc di
    inc di
    ;incremento dos veces di
    dec si
    dec si
    ;decremento dos veces si
    cmp di,si
    jl inicio; salta si di es menor
    mov cx,1 ; 1 es capicua
    jmp fin; salto incondicional
no_capicua:
    mov cx,0    ;0 es no capicua
fin:        
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
