print macro str   ;prints string
    mov ah, 09h 
    lea dx, str
    int 21h
endm    

print2 macro str   ;prints string as well
    mov ah, 09h 
    mov dx, offset str
    int 21h
    endm
           
setcur macro ;sets the cursor
    mov ah, 02
    mov bh, 00
    int 10h 
    endm
       
cls macro ; (blue and bright yellow)
    mov ax, 0600h
    mov bh, 30
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm

cls2 macro;css theme 2 (gray and bright yellow font)
    mov ax, 0600h
    mov bh, 126
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm  

cls3 macro;css theme 3 (black bg and bright yellow font
    mov ax, 0600h
    mov bh, 14
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm    

cls4 macro;css theme 4 (dark red bg and white font)
    mov ax, 0600h
    mov bh, 79
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm      

cls5 macro ; dark green bg and white font
    mov ax, 0600h
    mov bh, 47
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm        

cls6 macro ; white bg and dark font
    mov ax, 0600h
    mov bh, 240
    mov cx, 0000
    mov dx, 184fh
    int 10h 
endm
                              
                  
.model small
;.386 remove comment when using it on dosbox
.stack 100h
   
.data           
    ;octal to decimal (placed at the top to avoid stack issues)  
    o2d_msg db "Enter 3-digit Octal Number: $"
    o2d_msg1 db "Decimal Number is: $"
    o2d_inv db "Invalid! Only put numbers 0-7. Try again.$"
    o2d_numhold dw 0 
    o2d_ins db "Note: The 3-digit Octal number is available up to 000 to 777 only!$"
    o2d_ins2 db "(377 base 8 = 255 bytes, Use 0-7 digits only!)$"
    o2d_ins3 db "Do not omit the zeroes per number place.$"
    o2d db "> Octal to Decimal Converter$"      
    
    
    ;opening panel
    intr db "BSCS 2-1, Group-2 Presents...$"   
    
    ;opening panel
    leave1 db "Thank you for using our program!$"     
    
    
    ;Title Page
    border db "================================================================================$"
    school db "Pamantasan ng Lungsod ng Maynila$"
    css db "Computer Science Society$"          
    section db "Group-2 COA - BSCS 2-1$"  
    developers db "Developed by:$"
    kayne db "Kayne Uriel K. Rodrigo$"
    kricel db "Kricel M. Belmonte$"   
    nicole db "Nicole Angelica C. Junio$"
    samantha db "Samantha Vivien L. Servo$"
    shieryl db "Shieryl E. Tendilla$"
    prof db "Submitted to: Prof. Elsa Pascual$" 
    
    ;Main Menu  
    main0 db "Welcome to 8-bit Number Conversion Calculator!$"   
    main00 db "== Powered by Assembly 8086 ==$"
    main1 db "> Select 8-bit Number Conversion Option: $"
    main2 db "a. Decimal Conversions $"
    main3 db "b. Octal Conversions $"
    main4 db "c. Hexadecimal Conversions $"
    main5 db "d. Exit Program $"
    
    ;Decimal Conversions Pane
    dec0 db "8-bit Decimal Conversions: $"  
    dec1 db "> Select 8-bit Decimal Number Conversion: $" 
    dec2 db "a. Decimal to Binary $"
    dec3 db "b. Decimal to Octal $"
    dec4 db "c. Decimal to Hexadecimal $"
    dec5 db "d. Return to Main Menu $"
    
    ;Octal Conversions Pane    
    oct0 db "8-bit Octal Conversions: $"  
    oct1 db "> Select 8-bit Octal Number Conversion: $"
    oct2 db "a. Octal to Decimal $"
    oct3 db "b. Octal to Binary $"
    oct4 db "c. Return to Main Menu $"
    
    ;Hexadecimal Conversions Pane
    hex0 db "8-bit Hexadecimal Conversions: $"  
    hex1 db "> Select 8-bit Hexadecimal Number Conversion: $" 
    hex2 db "a. Hexadecimal to Decimal $"
    hex3 db "b. Hexadecimal to Binary $" 
    hex4 db "c. Return to Main Menu $" 
    
    ;after program
    aft1 db "A conversion has been finished.$"
    aft2 db "Kindly select the next option below: $"
    aft5 db "a. Return to Main Menu $"
    aft6 db "b. Exit the Program$"     
    
    ;Decimal Conversions         
    
    ;decimal to binary calculator    
    d2b db "> Decimal to Binary Converter$"
    d2b_msg db "Enter 8-bit Decimal Number (000-255): $"
    d2b_msg1 db "Binary Number is: $"
    d2b_numhold db 0    
    
    ;decimal to octal calculator    
    d2o db "> Decimal to Octal Converter$"
    d2o_msg db "Enter 8-bit Decimal Number (000-255): $"
    d2o_msg1 db "Octal Number is: $"
    d2o_numhold db 0  

    
    ;decimal to hexadecimal calculator 
    d2h db "> Decimal to Hexadecimal Converter$"
    d2h_msg db "Enter the Decimal Number (000-255): $"
    d2h_msg1 db "Hexadecimal Number is: $"
    d2h_inv db "Invalid entry! Only use numbers 0 to 9.$" 
    d2h_ran db "Invalid entry! Only use numbers 000 to 255.$"
    d2h_numhold db 0 
    d2h_checker dw 0 
                     
    ;Octal Conversions
    
    ;Octal to Decimal (set above)
    
    ;Octal to Binary 
    o2b db "> Octal to Binary Converter$"
    o2b_txt1 db "Enter 3-digit Octal Number: $"
    o2b_txt2 db "Binary number: $:"
    o2b_ins db "Note: The 3-digit Octal number is available up to 000 to 777 only!$"
    o2b_ins2 db "(377 base 8 = 255 bytes, Use 0-7 digits only!)$" 
    o2b_inv db "Invalid entry! only include numbers 0-7. try again!$" 
    o2b_inp db 0
  
    ;Hexadecimal Conversions
    
    ;hexadecimal to decimal calculator 
    h2d db "> Hexadecimal to Decimal Converter$"
    h2d_str1  db 10 dup ('$')
    h2d_msg db "Enter 2-digit Hexadecimal Number: $"
    h2d_note db "Note: Use 0-F, append trailing zero if 1 digit only.$"
    h2d_msg1 db "Decimal Number is: $"
    h2d_inv db "Invalid! Only put numbers 0-F. Try again.$"   
    h2d_numhold dw 0  
    
    ;hexadecimal to binary calculator         
    h2b db "> Hexadecimal to Binary Converter$"
    h2b_msg db "Enter 2-digit Hexadecimal Number: $"  
    h2b_note db "Note: Use 0-F, append trailing zero if 1 digit only.$"
    h2b_msg1 db "Binary Number is: $"                                                  
    h2b_inv db "Invalid! Only put numbers 0-F. Try again.$"   
    h2b_numhold dw 0  

    ;tools 
    maindev db "Developed by @Group-2 BSCS 2-1, All Rights Reserved$." 
    inv db "Invalid entry! Press any key to try again.$"     ;invalid
    resp db "Your choice: $"   ;response
    next db "Press enter key to continue...$"  
    endl db 0ah, 0dh, "$"   ;endline
    space db "                                                                                $",0ah,0dh    ;space

.code      

main proc ;main function
    mov ax, @data
    mov ds, ax   
    
    cls6 ; clear screen 
   
    ;opening pain
    mov dh, 10  ;height
    mov dl, 26  ;width     
    setcur
    print intr  
    mov ah, 01
    int 21h
    mov al, 0
    
    cls ; clear screen

    ;opening pane
    title1: 
    
        mov dh, 01  ;height
        mov dl, 00  ;width
        setcur
        print border 

        
        mov dh, 23  ;height
        mov dl, 00  ;width
        setcur
        print border 
        
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur
        print school  
        
        mov dh, 04  ;height
        mov dl, 28  ;width
        setcur
        print css   

        mov dh, 06  ;height
        mov dl, 29  ;width
        setcur
        print section
        
        mov dh, 08  ;height
        mov dl, 33  ;width
        setcur
        print developers     
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur
        print kayne   
        
        mov dh, 11  ;height
        mov dl, 31  ;width
        setcur
        print kricel
        
        mov dh, 12  ;height
        mov dl, 28  ;width
        setcur
        print nicole 
        
        mov dh, 13  ;height
        mov dl, 28  ;width
        setcur
        print samantha
        
        mov dh, 14  ;height
        mov dl, 31  ;width
        setcur
        print shieryl
        
        
        mov dh, 19  ;height
        mov dl, 23  ;width
        setcur
        print prof
        
        mov dh, 21  ;height
        mov dl, 25  ;width
        setcur
        print next 
        
    ;option 
    title_cont:
    mov ah, 00h
    int 16h
    cmp al, 0dh
    je continue
    cmp al, 0dh
    jne title_cont
     
    continue:
    
    ;main menu
    main_menu:
        cls4 
    try: 
       
        
        mov dh, 02  ;height
        mov dl, 17  ;width
        setcur 
        print main0    
        
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur 
        print main00
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 07  ;height
        mov dl, 19  ;width
        setcur 
        print main1
        
        
        mov dh, 09  ;height
        mov dl, 29  ;width
        setcur  
        print main2
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur  
        print main3
        
        mov dh, 11  ;height
        mov dl, 29  ;width
        setcur  
        print main4
        
        mov dh, 12  ;height
        mov dl, 29  ;width
        setcur  
        print main5  
        
        mov dh, 16  ;height
        mov dl, 27  ;width
        setcur  
        print resp
        
        ;options
        mov ah, 01h                                  
        int 21h  
        cmp al, 'a'
        je decimal_conversions  
        cmp al, 'b'
        je octal_conversions
        cmp al, 'c'
        je hexadecimal_conversions
        cmp al, 'd' 
        je exit_program
        cmp al, 'A'
        je decimal_conversions  
        cmp al, 'B'
        je octal_conversions
        cmp al, 'C'
        je hexadecimal_conversions
        cmp al, 'D' 
        je exit_program    
        
        ;error handling   
        cmp al, 45h
        ja catch
        cmp al, 41h
        jb catch
        cmp al, 64h
        ja catch
        cmp al, 61h
        jb catch  
        
                     
   catch:
        mov dh, 16  ;height
        mov dl, 19  ;width
        setcur  
        print inv 
        mov ah, 01h
        int 21h
        mov al, 0
        jmp continue   
        

     main endp    
     
    ;decimal conversion
    decimal_conversions proc far 
        mov ax, @data
        mov ds, ax  
    
        dc_try: 
        
        cls5 ; clear screen 
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur 
        print dec0
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 07  ;height
        mov dl, 19  ;width
        setcur 
        print dec1
        
        
        mov dh, 09  ;height
        mov dl, 29  ;width
        setcur  
        print dec2
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur  
        print dec3
        
        mov dh, 11  ;height
        mov dl, 29  ;width
        setcur  
        print dec4
        
        mov dh, 12  ;height
        mov dl, 29  ;width
        setcur  
        print dec5  
        
        mov dh, 16  ;height
        mov dl, 27  ;width
        setcur  
        print resp
        
        ;enter input
        mov ah, 01h                                  
        int 21h
        ;choices  
        cmp al, 'a'  
        je decimal_to_binary  
        cmp al, 'b'
        je decimal_to_octal
        cmp al, 'c'
        je decimal_to_hex
        cmp al, 'd' 
        je main_menu  
        cmp al, 'A'
        je decimal_to_binary 
        cmp al, 'B'
        je decimal_to_octal
        cmp al, 'C'
        je decimal_to_hex
        cmp al, 'D' 
        je main_menu 
        
        ;error handling
        cmp al, 45h
        ja dc_catch
        cmp al, 41h
        jb dc_catch
        cmp al, 64h
        ja dc_catch
        cmp al, 61h
        jb dc_catch 
        
        dc_catch: 
           mov dh, 16  ;height
           mov dl, 19  ;width
           setcur
           print inv 
           mov ah, 01h
           int 21h
           mov al, 0
           jmp dc_try  
        
    decimal_conversions endp 
    
    ;decimal to binary
    decimal_to_binary proc far
        mov ax, @data
        mov ds, ax 
          
        mov d2b_numhold, 0 ; temp variable reset
     
        cls3 ; clear screen
        
        mov dh, 03  ;height
        mov dl, 26  ;width   
        setcur
        print d2b 
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        
        mov dh, 05  ;height
        mov dl, 18  ;width   
        setcur
        print d2b_msg   
        
    
        mov cx, 3
        
        d2b_loop1:
            mov ah, 01h
            int 21h
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 100
            mul bl ; ax
            add d2b_numhold, al
            loop d2b_loop2
    
        d2b_loop2:
            mov ah, 01h
            int 21h
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 10
            mul bl ; ax
            add d2b_numhold, al
            loop d2b_loop3
    
        d2b_loop3:
            mov ah, 01h
            int 21h
            sub al, 48
            add d2b_numhold, al 
    
    
        mov al, d2b_numhold
        mov ah, 0
        mov bx, 2
        mov dx, 0
    
        mov cx, 0
    
        d2b_again: 
            div bx
            push dx
            mov ah, 0
            inc cx
            cmp ax, 0
            jne d2b_again
    
        mov dh, 07  ;height
        mov dl, 18  ;width   
        setcur
        print d2b_msg1 
    
        d2b_disp:
            pop dx
            add dx, 48
            mov ah, 02h
            int 21h
            loop d2b_disp
            
            
        mov dh, 14  ;height
        mov dl, 18  ;width   
        setcur    
        print next
        
        
        d2b_cont:
        mov ah, 00h
        int 16h
        cmp al, 0dh
        je after_prog
        cmp al, 0dh
        jne d2b_cont
        
        decimal_to_binary endp
    
    ;decimal to octal
    decimal_to_octal proc far
        mov ax, @data
        mov ds, ax 
        
        cls3  
        mov d2o_numhold, 0
        
        mov dh, 03  ;height
        mov dl, 26  ;width   
        setcur
        print d2o
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        
        mov dh, 05  ;height
        mov dl, 18  ;width   
        setcur
        print d2o_msg 
        
    
        mov cx, 3
    
       d2o_loop1:
            mov ah, 01h
            int 21h
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 100
            mul bl ; ax
            add d2o_numhold, al
            loop d2o_loop2
    
        d2o_loop2:
            mov ah, 01h
            int 21h
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 10
            mul bl ; ax
            add d2o_numhold, al
            loop d2o_loop3
    
        d2o_loop3:
            mov ah, 01h
            int 21h
            sub al, 48
            add d2o_numhold, al 
    
    
        mov al, d2o_numhold
        mov ah, 0
        mov bx, 8
        mov dx, 0
    
        mov cx, 0
    
        d2o_again: 
            div bx
            push dx
            mov ah, 0
            inc cx
            cmp ax, 0
            jne d2o_again
    
        mov dh, 07  ;height
        mov dl, 18  ;width   
        setcur
        print d2o_msg1 
    
        d2o_disp:
            pop dx
            add dx, 48
            mov ah, 02h
            int 21h
            loop d2o_disp 
            
        mov dh, 14  ;height
        mov dl, 18  ;width   
        setcur    
        print next
            
        d2o_cont:
        mov ah, 00h
        int 16h
        cmp al, 0dh
        je after_prog
        cmp al, 0dh
        jne d2o_cont
        
        decimal_to_octal endp 
    
    ;decimal to hexadecimal
    decimal_to_hex proc far
          mov ax, @data
          mov ds, ax

        mov d2h_numhold, 0
        mov d2h_checker, 0

        cls3 
        
        mov dh, 03  ;height
        mov dl, 26  ;width   
        setcur
        print d2h
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        
        mov dh, 05  ;height
        mov dl, 18  ;width   
        setcur
        print d2h_msg 
          
        mov cx, 3
    
        d2h_loop1:
            mov ah, 01h
            int 21h
            cmp al, 32h
            ja d2h_invalid2
            cmp al, 2Fh
            jb d2h_invalid
            cmp al, 39h
            ja d2h_invalid
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 100
            mul bl ; ax
            add d2h_numhold, al
            add d2h_checker, ax
            loop d2h_loop2
    
        d2h_loop2:
            mov ah, 01h
            int 21h
            cmp al, 2Fh
            jb d2h_invalid
            cmp al, 39h
            ja d2h_invalid
            sub al, 48
            mov cl, al 
            mov al, cl 
            mov bl, 10
            mul bl ; ax
            add d2h_numhold, al 
            add d2h_checker, ax
            loop d2h_loop3
    
        d2h_loop3:
            mov ah, 01h
            int 21h
            cmp al, 2Fh
            jb d2h_invalid
            cmp al, 39h
            ja d2h_invalid
            sub al, 48
            add d2h_numhold, al
            add d2h_checker, ax
            push ax            
            
        pop ax
        mov al, d2h_numhold
        mov ah, 0
        mov bx, 16
        mov dx, 0
    
        mov cx, 0
    
        d2h_again: 
            div bx
            push dx
            mov ah, 0
            inc cx
            cmp ax, 0
            jne d2h_again
    
        mov dh, 07  ;height
        mov dl, 18  ;width   
        setcur
        print d2h_msg1  
    
        pop dx 
        ;0-9h first digit        
        d2h_disp:
            cmp dx, 9
            ja d2h_disp1
            add dx, 48
            mov ah, 02h
            int 21h
            pop dx
            jmp d2h_disp2
           
        
        ;A-Fh 
        d2h_disp1:
            add dx, 55
            mov ah, 02h
            int 21h
            pop dx
            jmp d2h_disp2
        
        ;0-9 second digit
        d2h_disp2:
            cmp dx, 9
            ja d2h_disp3
            add dx, 48
            cmp dx, '0'
            jb d2h_next 
            mov ah, 02h
            int 21h
            jmp d2h_next
       
        d2h_disp3:
            add dx, 55
            mov ah, 02h
            cmp dl, 'F'
            ja d2h_next
            int 21h
            jmp d2h_next
        
        d2h_invalid: 
            mov dh, 10  ;height
            mov dl, 16  ;width   
            setcur 
            mov ah, 01h
            int 21h
            mov al, 0
            print d2h_inv
            jmp  d2h_next
        
        d2h_invalid2: 
            mov dh, 10  ;height
            mov dl, 16  ;width   
            setcur 
            print d2h_ran 
            mov ah, 01h
            int 21h
            mov al, 0
            jmp d2h_next   
        
        d2h_next:
        mov dh, 14  ;height
        mov dl, 18  ;width   
        setcur    
        print next
            
        d2h_cont:
        mov ah, 00h
        int 16h
        cmp al, 0dh
        je after_prog
        cmp al, 0dh
        jne d2h_cont    
        
        
        d2h_exit: 
            jmp after_prog
        
        decimal_to_hex endp 

    ;octal conversions
    octal_conversions proc far 
        mov ax, @data
        mov ds, ax  
        
        oc_try: 
        
        cls5 
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur 
        print oct0
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 07  ;height
        mov dl, 19  ;width
        setcur 
        print oct1
        
        
        mov dh, 09  ;height
        mov dl, 29  ;width
        setcur  
        print oct2
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur  
        print oct3
        
        mov dh, 11  ;height
        mov dl, 29  ;width
        setcur  
        print oct4
        
        mov dh, 16  ;height
        mov dl, 27 ;width
        setcur  
        print resp
        
        ;enter input
        mov ah, 01h                                  
        int 21h
        ;choices  
        cmp al, 'a'  
        je octal_to_decimal  
        cmp al, 'b'
        je octal_to_binary
        cmp al, 'c'
        je main_menu  
        cmp al, 'A'
        je octal_to_decimal
        cmp al, 'B'
        je octal_to_binary
        cmp al, 'C'
        je main_menu
           
        ;error handling
        cmp al, 45h
        ja oc_catch
        cmp al, 41h
        jb oc_catch
        cmp al, 64h
        ja oc_catch
        cmp al, 61h
        jb oc_catch
        
        oc_catch:
          mov dh, 16  ;height
          mov dl, 19  ;width
          setcur  
          print inv
          mov ah, 01h
          int 21h
          mov al, 0
          jmp oc_try  
        
    octal_conversions endp   
    
    
 ;octal to decimal 
    octal_to_decimal proc far 
        mov ax, @data
        mov ds, ax    
        mov o2d_numhold, 0
        
        cls3
        mov dh, 03  ;height
        mov dl, 26  ;width   
        setcur
        print o2d  
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 15  ;height
        mov dl, 7  ;width   
        setcur
        print o2d_ins    
        
        mov dh, 16  ;height
        mov dl, 17  ;width   
        setcur 
        print o2d_ins2  
        
        
        mov dh, 05  ;height
        mov dl, 18  ;width   
        setcur
        print2 o2d_msg  
    
        mov cx, 3 
        
        o2d_loop1:
            cmp cx, 2
            je o2d_loop1 ; cx=3 false 
            mov ah, 01h
            int 21h
            sub al, 48
            cmp al, 7
            ja o2d_invalid
            mov bl, 64
            mul bl ; ax
            add o2d_numhold, ax
            loop o2d_loop2
    
        o2d_loop2:
            cmp cx, 1
            je o2d_loop2 ; cx=2 false 
            mov ah, 01h
            int 21h
            sub al, 48
            cmp al, 7
            ja o2d_invalid
            mov bl, 8
            mul bl ; ax
            add o2d_numhold, ax
            loop o2d_loop3
    
        o2d_loop3:
            mov ah, 01h
            int 21h
            sub al, 48
            cmp al, 7
            ja o2d_invalid
            add o2d_numhold, ax 
    
             
        mov dh, 7  ;height
        mov dl, 18  ;width   
        setcur 
        print o2d_msg1
                  
        mov ax, o2d_numhold
        mov bx, 100
        div bx
        push dx 
        
        mov dl, al
        sub dl, 16
        push ax
        mov ah, 02h
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
        
        o2d_next:
        mov dh, 13  ;height
        mov dl, 18  ;width   
        setcur    
        print next
            
        o2d_cont:
        mov ah, 00h
        int 16h
        cmp al, 0dh
        je after_prog
        cmp al, 0dh
        jne o2d_cont   
    
         o2d_invalid:
            mov dh, 14  ;height
            mov dl, 18  ;width   
            setcur 
            print inv 
            mov ah, 01h
            int 21h
            mov al, 0
            
          exit:
            jmp after_prog
            octal_to_decimal endp


    octal_to_binary proc near ;o2b main proc  
        mov ax, @data
        mov ds, ax                               
        
        mov bx, 00
        
        cls3
        
        mov si, 0
        mov cx, 0 
        
        mov dh, 03  ;height
        mov dl, 26  ;width   
        setcur
        print o2b    
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev 
        
        mov dh, 15  ;height
        mov dl, 7  ;width   
        setcur
        print o2b_ins
        
        mov dh, 16  ;height
        mov dl, 17  ;width   
        setcur 
        print o2b_ins2     
    
        mov dh, 05  ;height
        mov dl, 18  ;width   
        setcur
        print o2b_txt1
    
        call octal_to_binary2
    
        mov dh, 07  ;height
        mov dl, 17  ;width   
        setcur
        print o2b_txt2
    
        mov di, 0
        mov ah, 2
        dec cx
        call octal_to_binary3
  
        endprog:   
            
            mov ah, 01h
            int 21h 
            mov al, 0
            jmp after_prog
        
                
    octal_to_binary endp

    octal_to_binary2 proc ;o2b input proc
        mov ah, 1
        int 21h     
        cmp al, 37h
        ja invalid
        mov o2b_inp[si], al
        inc cx
        inc si
        cmp al, 13
        jne octal_to_binary2
        ret
        
        invalid:
            mov dh, 14  ;height
            mov dl, 18  ;width   
            setcur
            jmp endprog  
            
   octal_to_binary2 endp
    
    octal_to_binary3 proc    ;o2b output proc
        mov bl, o2b_inp[di]
        call octal_to_binary4
        inc di
        loop octal_to_binary3
        ret
    octal_to_binary3 endp
    
    octal_to_binary4 proc ;o2b convert proc
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
            je o2b_exit
            jmp conv
     
        disp1:
            mov dl,'1'
            int 21h
            inc dh
            cmp dh,3
            je o2b_exit
            jmp conv
     
        o2b_exit:  
            mov dl, 20h
            mov ah, 2h
            int 21h
            ret
    octal_to_binary4 endp
       
        
      
    ;hex conversion    
    hexadecimal_conversions proc far
        mov ax, @data
        mov ds, ax  
        
        hc_try: 
        
        cls5 
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur 
        print hex0
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 07  ;height
        mov dl, 19  ;width
        setcur 
        print hex1
        
        
        mov dh, 09  ;height
        mov dl, 29  ;width
        setcur  
        print hex2
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur  
        print hex3
        
        mov dh, 11  ;height
        mov dl, 29  ;width
        setcur  
        print hex4
        
        mov dh, 16  ;height
        mov dl, 27  ;width
        setcur  
        print resp
        
        ;enter input
        mov ah, 01h                                  
        int 21h
        ;choices  
        cmp al, 'a'  
        je hexadecimal_to_decimal  
        cmp al, 'b'
        je hexadecimal_to_binary
        cmp al, 'c'
        je main_menu  
        cmp al, 'A'
        je hexadecimal_to_decimal
        cmp al, 'B'
        je hexadecimal_to_binary
        cmp al, 'C'
        je main_menu
           
        ;error handling
        cmp al, 45h
        ja hc_catch
        cmp al, 41h
        jb hc_catch
        cmp al, 64h
        ja hc_catch
        cmp al, 61h
        jb hc_catch 
        
        hc_catch:
            mov dh, 16  ;height
            mov dl, 19  ;width
            setcur  
            print inv 
            mov ah, 01h
            int 21h
            mov al, 0
           jmp hc_try  
        
        hexadecimal_conversions endp
        
    hexadecimal_to_decimal proc far

        mov ax, @data
        mov ds, ax   
        mov o2d_numhold, 0
        
        cls3 
        mov dh, 03 ;height
        mov dl, 23  ;width  
        setcur
        print h2d  
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev  
        
        mov dh, 20  ;height
        mov dl, 14  ;width   
        setcur 
        print h2d_note
        mov cx, 3 
         
        mov dh, 08  ;height
        mov dl, 15  ;width   
        setcur 
        print h2d_msg
        mov cx, 3
                   
        
  
    ;First digit
    h2d_loop1:
        cmp cx, 1
        je h2d_loop2 ; cx=2 false 
        mov ah, 01h
        int 21h 
        cmp al, 39h
        ja a_cap1 
        sub al, 30h  
        cmp al, 15  
        ja h2d_invalid
        mov bl, 16
        mul bl ; ax
        add h2d_numhold, ax
        jmp h2d_loop2
        
    ;for A-Z
    a_cap1:
        cmp al, 46h
        ja a_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        ja h2d_invalid
        pop ax
        sub al, 37h
        mov bl, 16
        mul bl ; ax
        add h2d_numhold, ax
        jmp h2d_loop2
    
    ;for a-z
    a_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        ja h2d_invalid
        pop ax
        sub al, 57h
        mov bl, 16
        mul bl ; ax
        add h2d_numhold, ax
        jmp h2d_loop2
    
     ;2nd digit
     h2d_loop2:
        mov ah, 01h
        int 21h
        cmp al, 39h
        ja b_cap1 
        sub al, 30h
        cmp al, 15
        ja h2d_invalid
        add h2d_numhold, ax 
        jmp h2d_continue
        
    ;for A-Z
     b_cap1:
        cmp al, 46h
        ja b_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        ja h2d_invalid
        pop ax
        sub al, 37h
        add h2d_numhold, ax
        jmp h2d_continue  
    
      ;for a-z
    b_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        ja h2d_invalid
        pop ax
        sub al, 57h
        add h2d_numhold, ax
        jmp h2d_continue
        
    h2d_continue: 
        mov ax, h2d_numhold
        mov ah, 00
      
    lea si, h2d_str1
    call h2d_convert
    
    mov dh, 11  ;height
    mov dl, 15 ;width   
    setcur 
    print h2d_msg1
    print h2d_str1
                    
                
    h2d_next:
    mov dh, 13  ;height
    mov dl, 18  ;width   
    setcur    
    print next
        
    h2d_cont:
    mov ah, 00h
    int 16h
    cmp al, 0dh
    je after_prog
    cmp al, 0dh
    jne h2d_cont   

     h2d_invalid:
        mov dh, 14  ;height
        mov dl, 18  ;width   
        setcur 
        print h2d_inv 
        mov ah, 01h
        int 21h
        mov al, 0
        jmp after_prog

    hexadecimal_to_decimal endp
            

h2d_convert proc near
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
h2d_convert endp      
        
hexadecimal_to_binary proc far
    mov ax, @data
    mov ds, ax
    cls3
        
        mov h2b_numhold,0
        mov dh, 03 ;height
        mov dl, 23  ;width  
        setcur
        print h2b
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
         
        mov dh, 20  ;height
        mov dl, 14  ;width   
        setcur 
        print h2b_note
        mov cx, 3 
            
        
        mov dh, 08  ;height
        mov dl, 15  ;width   
        setcur 
        print h2b_msg
        mov cx, 3


    mov cx, 3
    
    h2b_loop1:
        cmp cx, 1
        je h2b_loop2 ; cx=2 false 
        mov ah, 01h
        int 21h 
        cmp al, 39h
        ja h2b_a_cap1 
        sub al, 30h  
        cmp al, 15  
        mov bl, 16
        mul bl ; ah
        add h2b_numhold, ax
        jmp h2b_loop2  
        
    ;for A-Z
    h2b_a_cap1:
        cmp al, 46h
        ja h2b_a_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        pop ax
        sub al, 37h
        mov bl, 16
        mul bl ; ax
        add h2b_numhold, ax
        jmp h2b_loop2
    
    ;for a-z
    h2b_a_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        pop ax
        sub al, 57h
        mov bl, 16
        mul bl ; ax
        add h2b_numhold, ax
        jmp h2b_loop2

    ;2nd digit
     h2b_loop2:
        mov ah, 01h
        int 21h
        cmp al, 39h
        ja h2b_b_cap1 
        sub al, 30h
        cmp al, 15
        add h2b_numhold, ax 
        jmp h2b_continue
        
    ;for A-Z
     h2b_b_cap1:
        cmp al, 46h
        ja h2b_b_cap2
        push ax
        sub al, 40h  
        cmp al, 15    
        pop ax
        sub al, 37h
        add h2b_numhold, ax
        jmp h2b_continue  
     
     ;for a-z
    h2b_b_cap2:
        push ax
        sub al, 60h  
        cmp al, 15    
        pop ax
        sub al, 57h
        add h2b_numhold, ax
        jmp h2b_continue
    

    h2b_continue:
        mov ax, h2b_numhold
        mov ah, 0
        mov bx, 2
        mov dx, 0

    mov cx, 0

    h2b_again: 
        div bx
        push dx
        mov ah, 0
        inc cx
        cmp ax, 0
        jne h2b_again

    
    mov dh, 11  ;height
    mov dl, 15  ;width   
    setcur 
    print h2b_msg1 

    h2b_disp:
        pop dx
        add dx, 30h
        mov ah, 02h
        int 21h
        loop h2b_disp     
        
    h2b_next:
        mov dh, 13  ;height
        mov dl, 18  ;width   
        setcur    
        print next
          
        
    h2b_cont:
        mov ah, 00h
        int 16h
        cmp al, 0dh
        je after_prog
        cmp al, 0dh
        jne h2b_cont   

     h2b_invalid:
        mov dh, 14  ;height
        mov dl, 18  ;width   
        setcur 
        print h2b_inv
        jmp after_prog    
        
hexadecimal_to_binary endp
    
    after_prog proc far
        
        aft_try: 
        cls4
        mov dh, 03  ;height
        mov dl, 25  ;width
        setcur 
        print aft1
        
        mov dh, 23 ;height
        mov dl, 00  ;width
        setcur 
        print maindev
        
        mov dh, 07  ;height
        mov dl, 22  ;width
        setcur 
        print aft2
        
        
        mov dh, 10  ;height
        mov dl, 29  ;width
        setcur  
        print aft5
        
        mov dh, 11  ;height
        mov dl, 29  ;width
        setcur  
        print aft6
              
        mov dh, 16  ;height
        mov dl, 27  ;width
        setcur  
        print resp    
        
        ;enter input
        mov ah, 01h                                  
        int 21h
        ;choices  

        cmp al, 'a'
        je main_menu 
        cmp al, 'b'
        je exit_program

        cmp al, 'A'
        je main_menu
        cmp al, 'B'
        je exit_program
        
        ;error handling
        cmp al, 45h
        ja aft_catch
        cmp al, 41h
        jb aft_catch
        cmp al, 64h
        ja aft_catch
        cmp al, 61h
        jb aft_catch
                     
        
        aft_catch:
        mov dh, 16  ;heigh
        mov dl, 19  ;width
        setcur  
        print inv 
        mov ah, 01h
        int 21h
        mov al, 0
        jmp aft_try 
        
     after_prog endp
    
    exit_program:
        cls6
        mov dh, 10  ;height
        mov dl, 24  ;width     
        setcur
        print leave1  
        mov ah, 01
        int 21h
        mov al, 0
        mov ah, 4ch
        int 21h    
   
   
end main


