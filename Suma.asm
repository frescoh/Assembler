; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"  
    AREA1 db 10 dup (9,4,7,8,2,3,7,9,0,4) ;  4097328749
    AREA2 db 10 dup (3,2,4,2,9,4,7,8,2,9) ;  9287492423
    AREA3 db 11 dup (0);                    13384821172 )
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
    mov di,0; indice para moverse sobre AREA
    mov dh,0;acarreo inicial
inicio:
    mov ah,0; para el ajuste AAA
    mov al, byte ptr ds:AREA1[di]
    add al, byte ptr ds:AREA2[di] ;AREA1[di] = AREA1[di]+AREA2[di]
    add al,dh; al=al+acarreo inicial
    aaa; en AL el digito resultante y en AH el acarreo   
    mov byte ptr ds:AREA3[di],al
    mov dh,ah;guardo el acarreo
    inc di
    cmp di,10
    jne inicio
    mov byte ptr ds:AREA3[di],dh;
    ;FIN

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
