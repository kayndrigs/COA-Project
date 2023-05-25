printf macro str 
    mov ah, 09h 
    lea dx, str
    int 21h
    endm

include emu8086.inc
.model small
.stack 100h
.data
    msg db "Enter 8-bit Binary Number (Do not append any 0 on the left!): $"
    msg1 db 0dh, 0ah, "Decimal Number is: $"
    inv db 0dh, 0ah,"Invalid! Only put numbers 0-1. Try again.$"
    numhold dw 0     
    wrn db "The binary exeeds 8bit register, try again!$"
    lfcr db 0dh, 0ah, "$" 
.code
main proc 
    mov ax, @data
    mov ds, ax
    
    printf msg
    
    mov bx, 0
    mov ah, 1
    for1:
        int 21h
        
    cmp al, 0dh
    je end_for1
    sub al, 30h
    shl bx,1
    or bl, al
    jmp for1
    
    end_for1:
    printf msg1
          
        
    cmp bl, 206
    ja dbl_dgt20
    
    mov ah, 2
    add bl, 48
    cmp bl, 57
    ja dbl_dgt1
    
    mov dl, bl
    int 21h
    jmp exit
    
   
   ;adding decimal values
   dbl_dgt1:
        cmp bl, 67
        ja dbl_dgt2
        mov dl, 31h 
        mov ah, 02h
        int 21h
        sub bl, 10
        mov dl, bl
        int 21h
        jmp exit
    
   dbl_dgt2:
        cmp bl, 77
        ja dbl_dgt3
        mov dl, 32h 
        mov ah, 02h
        int 21h
        sub bl, 20
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt3:
        cmp bl, 87
        ja dbl_dgt4
        mov dl, 33h 
        mov ah, 02h
        int 21h
        sub bl, 30
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt4:
        cmp bl, 97
        ja dbl_dgt5
        mov dl, 34h 
        mov ah, 02h
        int 21h
        sub bl, 40
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt5:
        cmp bl, 107
        ja dbl_dgt6    
        mov dl, 35h 
        mov ah, 02h
        int 21h
        sub bl, 50
        mov dl, bl
        int 21h
        jmp exit
        
        
    dbl_dgt6:
        cmp bl, 117
        ja dbl_dgt7    
        mov dl, 36h 
        mov ah, 02h
        int 21h
        sub bl, 60
        mov dl, bl
        int 21h
        jmp exit   
        
    dbl_dgt7:
        cmp bl, 127
        ja dbl_dgt8    
        mov dl, 37h 
        mov ah, 02h
        int 21h
        sub bl, 70
        mov dl, bl
        int 21h
        jmp exit     
        
    dbl_dgt8:
        cmp bl, 137
        ja dbl_dgt9    
        mov dl, 38h 
        mov ah, 02h
        int 21h
        sub bl, 80
        mov dl, bl
        int 21h
        jmp exit 
    
    dbl_dgt9:
        cmp bl, 147
        ja dbl_dgt10 
        mov dl, 39h 
        mov ah, 02h
        int 21h
        sub bl, 90
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt10:
        cmp bl, 157
        ja dbl_dgt11 
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 30h 
        mov ah, 02h
        int 21h
        sub bl, 100
        mov dl, bl
        int 21h
        jmp exit
        
    dbl_dgt11:
        cmp bl, 167
        ja dbl_dgt12 
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 31h 
        mov ah, 02h
        int 21h
        sub bl, 110
        mov dl, bl
        int 21h
        jmp exit
        
    dbl_dgt12:
        cmp bl, 177
        ja dbl_dgt13
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 32h 
        mov ah, 02h
        int 21h
        sub bl, 120
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt13:
        cmp bl, 187
        ja dbl_dgt14
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 33h 
        mov ah, 02h
        int 21h
        sub bl, 130
        mov dl, bl
        int 21h
        jmp exit 
    
    dbl_dgt14:
        cmp bl, 197
        ja dbl_dgt15
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 34h 
        mov ah, 02h
        int 21h
        sub bl, 140
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt15:
        cmp bl, 207
        ja dbl_dgt16
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 35h 
        mov ah, 02h
        int 21h
        sub bl, 150
        mov dl, bl
        int 21h
        jmp exit
        
    dbl_dgt16:
        cmp bl, 217
        ja dbl_dgt17
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 36h 
        mov ah, 02h
        int 21h
        sub bl, 160
        mov dl, bl
        int 21h
        jmp exit
    
    dbl_dgt17:
        cmp bl, 227
        ja dbl_dgt18
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 37h 
        mov ah, 02h
        int 21h
        sub bl, 170
        mov dl, bl
        int 21h
        jmp exit
   
   dbl_dgt18:
        cmp bl, 237
        ja dbl_dgt19
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 38h 
        mov ah, 02h
        int 21h
        sub bl, 180
        mov dl, bl
        int 21h
        jmp exit
   
   dbl_dgt19:
        cmp bl, 247
        ja dbl_dgt20
        mov dl, 31h 
        mov ah, 02h
        int 21h
        mov dl, 39h 
        mov ah, 02h
        int 21h
        sub bl, 190
        mov dl, bl
        int 21h
        jmp exit
   
   dbl_dgt20:
        cmp bl, 209
        ja dbl_dgt21
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 30h 
        mov ah, 02h
        int 21h
        sub bl, 200
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit
   
   dbl_dgt21:
        cmp bl, 219
        ja dbl_dgt22
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 31h 
        mov ah, 02h
        int 21h
        sub bl, 210
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit
     
   dbl_dgt22:
        cmp bl, 229
        ja dbl_dgt23
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 32h 
        mov ah, 02h
        int 21h
        sub bl, 220
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit
      
   dbl_dgt23:
        cmp bl, 239
        ja dbl_dgt24
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 33h 
        mov ah, 02h
        int 21h
        sub bl, 230
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit
        
   dbl_dgt24:
        cmp bl, 249
        ja dbl_dgt25
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 34h 
        mov ah, 02h
        int 21h
        sub bl, 240
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit
    
   dbl_dgt25:
        cmp bl, 255
        ja warning
        mov dl, 32h 
        mov ah, 02h
        int 21h
        mov dl, 35h 
        mov ah, 02h
        int 21h
        sub bl, 250
        add bl, 30h
        mov dl, bl
        int 21h
        jmp exit 
   
   
        
    warning:
        mov ah, 09h
        mov dx, offset wrn
        int 21h 
        

    
    exit:
    mov ah, 4ch
    int 21h
    main endp
end main
