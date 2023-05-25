print macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

;covertion from octal to binary reference: https://www.youtube.com/watch?v=sdnpee6iogg
.model small
.stack 128
.data
    txt1 db 0ah, "Enter octal number (0-7): $"
    txt2 db 0ah, "binary number: $:" 
    lfcr db 0ah, 0dh, "$"
    inv db "invalid entry! only include numbers 0-7. try again!$"
    inp db 0
.code
    main proc near
    	mov ax, @data
    	mov ds, ax
    	
    	mov si, 0
    	mov cx, 0
    
    	print txt1
    
    	call input
    
    	print txt2
    
    	mov di, 0
    	mov ah, 2
    	dec cx
    	call output
  
    	endprog:
    	mov ah, 4ch
    	int 21h
    	
    			
    main endp

    input proc
        mov ah, 1
    	int 21h     
    	cmp al, 37h
    	ja invalid
    	mov inp[si], al
    	inc cx
    	inc si
    	cmp al, 13
    	jne input
    	ret
    	
    	invalid:
    	    print lfcr
    	    print inv
    	    jmp endprog  
    	    
    input endp
    
    output proc
    	mov bl, inp[di]
    	call convert
    	inc di
    	loop output
    	ret
    output endp
    
    convert proc
    	sub bl,48
       	shl bl,5
        
       	mov dh,0
    	conv:
        	shl bl,1
        	jc disp1
        	jmp disp0
    
    	disp0: 
        	mov dl,'0'
        	int 21h
        	inc dh
        	cmp dh,3
        	je exit
        	jmp conv
     
    	disp1:
        	mov dl,'1'
        	int 21h
        	inc dh
        	cmp dh,3
        	je exit
        	jmp conv
     
    	exit: 
        	mov dl, 20h
        	mov ah, 2h
        	int 21h
        	ret
    convert endp
    
    end main
