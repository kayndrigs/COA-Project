print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

.model small
.stack 100h
.data 
    msg db "Enter 2-digit Hexadecimal Number (0-A, append left zero if 1-digit): $"
    msg1 db 0dh, 0ah, "Binary Number is: $"
    lfcr db 0dh, 0ah, "$" 
    numhold dw 0  

.code 
main proc
    mov ax, @data
    mov ds, ax

    print msg

    mov cx, 3
    
    loop1:
        cmp cx, 1
        je loop2 ; cx=2 false 
        mov ah, 01h
        int 21h 
        cmp al, 39h
        ja a_cap1 
        sub al, 30h  
        cmp al, 15  
        mov bl, 16
        mul bl ; ah
        add numhold, ax
        jmp loop2  
        
    ;for A-Z
    a_cap1:
        cmp al, 46h
        ja a_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        pop ax
        sub al, 37h
        mov bl, 16
        mul bl ; ax
        add numhold, ax
        jmp loop2
    
    ;for a-z
    a_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        pop ax
        sub al, 57h
        mov bl, 16
        mul bl ; ax
        add numhold, ax
        jmp loop2

    ;2nd digit
     loop2:
        mov ah, 01h
        int 21h
        cmp al, 39h
        ja b_cap1 
        sub al, 30h
        cmp al, 15
        add numhold, ax 
        jmp continue
        
    ;for A-Z
     b_cap1:
        cmp al, 46h
        ja b_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        pop ax
        sub al, 37h
        add numhold, ax
        jmp continue  
     
     ;for a-z
    b_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        pop ax
        sub al, 57h
        add numhold, ax
        jmp continue
    

    continue:
        mov ax, numhold
        mov ah, 0
        mov bx, 2
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

    disp:
        pop dx
        add dx, 30h
        mov ah, 02h
        int 21h
        loop disp
        

    mov ah, 4ch
    int 21h
main endp
end main 