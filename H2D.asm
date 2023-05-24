print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

.model small
.stack
.data
     str1  db 10 dup ('$')
     msg db "Enter 2-digit Hexadecimal Number: $"
    msg1 db 0dh, 0ah, "Decimal Number is: $"
    inv db 0dh, 0ah,"Invalid! Only put numbers 0-15. Try again.$"  
    lfcr db 0dh, 0ah, "$" 
    numhold dw 0  
.code
    main proc near
        mov ax, @data
        mov ds, ax
        
        print msg
        mov cx, 3
        
    ;First digit
    loop1:
        cmp cx, 1
        je loop2 ; cx=2 false 
        mov ah, 01h
        int 21h 
        cmp al, 39h
        ja a_cap1 
        sub al, 30h  
        cmp al, 15  
        ja invalid
        mov bl, 16
        mul bl ; ax
        add numhold, ax
        jmp loop2
        
    ;for A-Z
    a_cap1:
        cmp al, 46h
        ja a_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        ja invalid
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
        ja invalid
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
        ja invalid
        add numhold, ax 
        jmp continue
        
    ;for A-Z
     b_cap1:
        cmp al, 46h
        ja b_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        ja invalid
        pop ax
        sub al, 37h
        add numhold, ax
        jmp continue  
    
      ;for a-z
    b_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        ja invalid
        pop ax
        sub al, 57h
        add numhold, ax
        jmp continue
                
    invalid:
        print inv
        jmp exit
        
    continue: 
        mov ax, numhold
        mov ah, 00
      
    lea si, str1
    call convert
    
    print lfcr
    print msg1
    print str1
  
            
    exit:
    mov ah, 4ch
    int 21h      
    main endp

convert proc near
    mov cx, 0
    mov bx, 10
   
    L1: 
        mov dx,0
        div bx
        add dl,30h
        push dx
        inc cx
        cmp ax,9
        jg L1
        
        add al,30h
        mov [si],al
     
    L2: 
        pop ax
        inc si
        mov [si],al
        loop L2
        ret
convert endp           
   
end main