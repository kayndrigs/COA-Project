print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

.model small
.stack 100h
.data 
    msg db "Enter the Decimal Number (000-255): $"
    msg1 db 0dh, 0ah, "Hexadecimal Number is: $"
    lfcr db 0dh, 0ah, "$"
    inv db "Invalid entry! Only use numbers 0 to 9.$" 
    ran db "Invalid entry! Only use numbers 000 to 255.$"
    numhold db 0 
    checker dw 0

.code 
main proc
    mov ax, @data
    mov ds, ax

    print msg

    mov cx, 3

    loop1:
        cmp cx, 2
        je loop2 ; cx=2 false 
        mov ah, 01h
        int 21h
        cmp al, 32h
        ja invalid2
        cmp al, 2Fh
        jb invalid
        cmp al, 39h
        ja invalid
        sub al, 48
        mov cl, al 
        mov al, cl 
        mov bl, 100
        mul bl ; ax
        add numhold, al
        add checker, ax
        loop loop2

    loop2:
        mov ah, 01h
        int 21h
        cmp al, 2Fh
        jb invalid
        cmp al, 39h
        ja invalid
        sub al, 48
        mov cl, al 
        mov al, cl 
        mov bl, 10
        mul bl ; ax
        add numhold, al 
        add checker, ax
        loop loop3

    loop3:
        mov ah, 01h
        int 21h
        cmp al, 2Fh
        jb invalid
        cmp al, 39h
        ja invalid
        sub al, 48
        add numhold, al
        add checker, ax
        push ax   
        
        
    pop ax
    mov al, numhold
    mov ah, 0
    mov bx, 16
    mov dx, 0

    mov cx, 0

    again: 
        div bx
        push dx
        mov ah, 0
        inc cx
        cmp ax, 0
        jne again

    print msg1 

    pop dx 
    ;0-9h first digit        
    disp:
        cmp dx, 9
        ja disp1
        add dx, 48
        mov ah, 02h
        int 21h
        pop dx
        jmp disp2
       
    
    ;A-Fh 
    disp1:
        add dx, 55
        mov ah, 02h
        int 21h
        pop dx
        jmp disp2
    
    ;0-9 second digit
    disp2:
        cmp dx, 9
        ja disp3
        add dx, 48
        mov ah, 02h
        int 21h
        jmp exit
   
    disp3:
        add dx, 55
        mov ah, 02h
        int 21h
        jmp exit
    
    invalid: 
        print lfcr
        print inv
        jmp exit
    
    invalid2: 
        print lfcr
        print ran
        jmp exit     
        
    exit:
    mov ah, 4ch
    int 21h
main endp
end main 
