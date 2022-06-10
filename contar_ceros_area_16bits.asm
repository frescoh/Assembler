; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    AREA db 10 dup(0x1,0x0,0x3,0x4,0x0,0x5,0x0,0x3,0x2,0x1)
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
    
    mov cx, 0   ;  ax,bx,cx,dx .....  ax:ah-al
    mov di, 0   ; di, si
inicio:
    mov ax, word ptr AREA[di]
    cmp al, 0
    jne siga     
    inc cx     
siga:
    cmp ah, 0
    jne siga1 
    inc cx
siga1:
    inc di
    inc di
    cmp di, 10
    jne inicio            
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
