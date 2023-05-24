print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

.model small
.stack 100h
.data
    msg db "Enter 3-digit Octal Number: $"
    msg1 db 0dh, 0ah, "Decimal Number is: $"
    inv db 0dh, 0ah,"Invalid! Only put numbers 0-7. Try again.$"
    numhold dw 0 
    ins db "Instructions: Enter 3-digit Octal Base 8 number up to 000 to 777 only!",0dh,0ah,"Do not omit the zeroes per number place.$"
    lfcr db 0dh, 0ah, "$"


.code 
main proc
    mov ax, @data
    mov ds, ax

    print ins
    print lfcr
    print lfcr
    print msg
    

    mov cx, 3 
    
    loop1:
        cmp cx, 2
        je loop1 ; cx=3 false 
        mov ah, 01h
        int 21h
        sub al, 48
        cmp al, 7
        ja invalid
        mov bl, 64
        mul bl ; ax
        add numhold, ax
        loop loop2

    loop2:
        cmp cx, 1
        je loop2 ; cx=2 false 
        mov ah, 01h
        int 21h
        sub al, 48
        cmp al, 7
        ja invalid
        mov bl, 8
        mul bl ; ax
        add numhold, ax
        loop loop3

    loop3:
        mov ah, 01h
        int 21h
        sub al, 48
        cmp al, 7
        ja invalid
        add numhold, ax 

         
    print msg1
              
    mov ax, numhold
    mov bx, 100
    div bx
    push dx 
    
    mov dl, al
    sub dl, 16
    push ax
    MOV AH, 02h
    int 21h
    pop ax
    pop dx
    
    mov ax, dx
    aam
    add ax, 03030h 
    mov bx, ax    
    
    mov dl, bh
    mov ah, 02h
    int 21h
    
    mov dl, bl
    mov ah, 02h
    int 21h 
    jmp exit  


    jmp exit

     invalid:
        print inv
        
   

    exit:
    mov ah, 4ch
    int 21h
main endp
end main 