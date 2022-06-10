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
    ; verificar si AREA es capicua
    ; si es capicua CX=1 y sino CX=0
    
    mov di,0  ; incrementar
    mov si,9  ; decrementar 
              ; condicion de parada di>=si
              ; ejecutar mientras di<si
    
inicio:
    mov al, byte ptr AREA[di]
    mov ah, byte ptr AREA[si] 
    cmp al, ah
    jne no_capicua
    inc di
    dec si
    cmp di, si
    jl  inicio ; jump less salte si es menor (di<si)
               ; JE, JNE, JL, JLE, JG, JGE salto condicional 
               ; JC salte si hay acarreo     
    mov cx,1  ; es capicua
    jmp fin   ; salto incondicional
no_capicua:
    mov cx,0  ; no es capicua
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
