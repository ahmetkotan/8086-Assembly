
jmp start
karakterMsg:    db      "Karakter Girmediniz.", 0Dh,0Ah, 24h
secimMsg: db "Yanlis Secim.", 0Dh, 0Ah, 24h
sayiGirin: db "Sayi Giriniz: ", 24h
secim: db "Secim Yap: ", 24h
ebob: db "(1) EBOB", 0Dh, 24h
ekok: db "(2) EKOK", 0Dh, 24h
sonuc: db "Sonuc: ", 24h

start:
    mov dx, sayiGirin
    mov ah, 09h
    int 21h
    
    
    call SAYI_AL
    push dx
    
    call YENI_SATIR
    
    mov dx, sayiGirin
    mov ah, 09h
    int 21h
    
    call SAYI_AL
    push dx
    
    call YENI_SATIR
    
    mov ah, 09h
    mov dx, ebob
    int 21h
    call YENI_SATIR
    
    mov dx, ekok
    mov ah, 09h
    int 21h
    call YENI_SATIR
    
    mov dx, secim
    mov ah, 09h
    int 21h
    
    mov ah, 1
    int 21h

    cmp al, 31h
    jz ebobCagir
    
    cmp al, 32h
    jz ekokCagir
    
    jnz secimHatasi
    
    
  
secimHatasi:
    call YENI_SATIR
    mov dx, secimMsg
    mov ah, 09h
    int 21h
    jmp programBitir


ekokCagir:
    call YENI_SATIR
    mov dx, sonuc
    mov ah, 09h
    int 21h
    pop bx
    pop ax
    call EKOK_HESAPLA
    call SAYI_YAZ
    jmp programBitir


ebobCagir:
    call YENI_SATIR
    mov dx, sonuc
    mov ah, 09h
    int 21h
    pop bx
    pop ax
    call EBOB_HESAPLA
    call SAYI_YAZ
    jmp programBitir

programBitir:
    mov ax, 04ch
    int 21h


EKOK_HESAPLA proc
    push ax
    push bx
    mul bx
    mov cx, ax
    pop bx
    pop ax
    
    ekokDondur:
        cmp bx, 0
        je ekokBitis
            
        xor dx, dx
        div bx
        mov ax, bx
        mov bx, dx
        jmp ekokDondur
            
    ekokBitis:
        mov bx, ax
        
    mov ax, cx
    div bx
     
     
    xor dx, dx
    mov dx, ax

    RET
EKOK_HESAPLA endp
    

EBOB_HESAPLA proc
    ebobDondur:
        cmp bx, 0
        je ebobBitis
            
        xor dx, dx
        div bx
        mov ax, bx
        mov bx, dx
        jmp ebobDondur
            
    ebobBitis:
        mov dx, ax
    
    RET
EBOB_HESAPLA endp

YENI_SATIR proc
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    RET
YENI_SATIR endp

SAYI_AL proc
    xor cx, cx
    deger_al:
    
        mov ah, 1
        int 21h
        
        cmp al, 0Dh
        jz sayi_olustur
        
        add cx, 1
        xor ah, ah
        sub al, 30h
        push ax
        
        cmp cx, 3
        jz sayi_olustur
        
        jmp deger_al
        
    sayi_olustur:
        cmp cx, 0
        jz karakter
    
        cmp cx, 1
        jz bir
        
        cmp cx, 2
        jz iki
        
        cmp cx, 3
        jz uc
      

    bir:
        pop dx
        
        jmp fonkBitir
    
    iki:
        pop dx
        pop ax
        push dx
        mov bx, 10
        mul bx
        
        pop dx
        add dx, ax
        
        jmp fonkBitir
    
    uc:
        pop dx
        pop ax
        push dx
        mov bx, 10
        mul bx
        
        pop dx
        add dx, ax
        
        pop ax
        push dx
        mov bx, 100
        mul bx
        
        pop dx
        add dx, ax
    
    fonkBitir:
        RET
    
    
    karakter:
        mov dx, karakterMsg
        mov ah, 09h
        int 21h
            
        jmp programBitir
SAYI_AL endp   


SAYI_YAZ proc
    mov ax, dx
    xor cx, cx
    mov bx, 10
    
    sayiYazDondur:
        xor dx, dx
        div bx
        push dx
        inc cx
        or ax, ax
        jne sayiYazDondur
    
    mov ah, 2
    
    sayiYaz:
        pop dx
        or dl, 30h
        int 21h
        loop sayiYaz
    
    
    RET
    
    
SAYI_YAZ endp
    
