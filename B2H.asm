;Binary to Hex

print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm


.model small
.stack 100h
.data
    ; messages
    msginput    db "Enter a 8-Bit Binary Number (0-1, append trailing zeroes): $"
    lfcr        db 0dh, 0ah, "$"
    msgafter    db "Hexadecimal Conversion: $"
    msginvalid  db 0dh, 0ah, "Invalid input! Please enter a valid 4-bit binary number.", 0dh, 0ah, "$"
    temp dw 3 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 0
    input_loop:
        mov dx, offset msginput ; display input message
        mov ah, 9
        int 21h

        xor bx, bx ; clear BX register for storing the binary number
        xor dx, dx ; clear DX register for hexadecimal conversion 
        lea si, temp
    
    input:
        mov ah, 01h ; read a character
        int 21h
    
        cmp al, 0Dh ; check for Enter key
        je pass_block
    
        cmp al, '0' ; compare with '0'
        je set_bit_0
        cmp al, '1' ; compare with '1'
        je set_bit_1
    
        jmp invalid_input 
        
     
    
    set_bit_0:
        inc cx
        shl bx, 1 ; shift left by 1 
        cmp cx, 4
        je push_digits 
        jmp input
    
    set_bit_1:
        inc cx
        shl bx, 1 ; shift left by 1
        or bx, 1 ; set the lowest bit to 1 
        cmp cx, 4
        je push_digits 
        jmp input
        
    push_digits:
        mov [si],bx 
        inc si
        mov cx, 00
        mov bx, 00
        jmp input
    
    pass_block:
        mov cx, 2
        lea si, temp
        passing:
            mov dx, [si]
            push dx
            inc si
            loop passing
        jmp continue
     
    continue:
        mov cx, 2
        print lfcr
        print msgafter
    convert:
        pop bx
        mov dl, bl ; copy the 8-bit segment to DL register
    
        cmp dl, 9 ; check if it's 0-9
        jbe convert_digit
        add dl, 7 ; convert to A-F
    
    convert_digit:
        add dl, 30h ; convert to ASCII character
    
        jmp try_again
    
    try_again:
       
        
        mov dl, bl ; copy the 4-bit segment to DL register
    
        cmp dl, 9 ; check if it's 0-9
        jbe convert_digit_after
        add dl, 7 ; convert to A-F
    
    convert_digit_after:
        add dl, 30h ; convert to ASCII character
    
        mov ah, 02h ; print character
        int 21h 
        dec cx 
        cmp cx, 1
        je convert
    
    
    exit_program:
    
        mov ah, 4Ch ; terminate program function
        mov al, 0 ; return code
        int 21h
     
    
    invalid_input:
        mov dx, offset msginvalid ; display invalid input message
        mov ah, 9
        int 21h
    
        jmp exit_program
    
main endp
end main
