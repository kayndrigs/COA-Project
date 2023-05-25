print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

;Covertion From Octal to Binary reference: https://www.youtube.com/watch?v=sdnpeE6iogg
.model small
.stack 128
.data
    msg1 db 0ah, "Enter 8-digit Binary Number (0-1, append zeroes): $"
    msg2 db 0ah, "Octal number: $" 
    inv db "Invalid Entry! Only include numbers 0-1. Try again!$"
    numhold dw 0
    lfcr db 0ah, 0dh, "$" 
    num dw 3 dup(?)
.code
    main proc near
         mov ax, @data
         mov ds, ax
     
        print msg1
        ;input
        
        append:
            mov dl, 30h
            push dx
        mov cx, 8
        input:
            mov ah, 01h
            int 21h 
            cmp al, 31h
            ja invalid
            mov dl, al
            push dx    
        loop input
        
        continue:
        print lfcr
        print msg2 
        
        ;output
        mov cx, 3
        lea si, num
        process:
            ; check by ones
            pop dx
            sub dl, 30h
            mov al, dl 
            mov bl, 1
            mul bl
            add numhold, ax
            ; check by tens
            pop dx
            sub dl, 30h
            mov al, dl
            mov bl, 2
            mul bl
            add numhold, ax
             ; check by hundreds
            pop dx
            sub dl, 30h
            mov al, dl
            mov bl, 4
            mul bl
            add numhold, ax
            
            mov ax, numhold
            mov [si],ax 
            inc si
            mov numhold, 0
            mov ax, 0  
            loop process
            
            mov cx, 03
            lea si, num
            passing:
                mov dx, [si]
                push dx
                inc si
                loop passing 
            
            mov cx, 03
            display:
                pop dx
                add dl, 30h
                mov ah, 02h
                int 21h
                loop display
                
            jmp exit
           
            
        
            
        invalid:
            print lfcr
            print inv 
            jmp exit
         
         
         exit:
         mov ah, 4ch
         int 21h

    main endp     
    end main
