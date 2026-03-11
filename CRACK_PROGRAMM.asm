.model tiny
.code
org 100h

SCREEN_WIDTH equ 80d
RAMKA_WIDTH  equ 15d

RAMKA_Y_CORD equ 5h

ACCESS_GRANT_COLOR  equ 2eh 
ACCESS_DENY_COLOR   equ 40h
START_COLOR         equ 70h

;CORRECT_HASH equ 0fb33h

Start:
        mov ax, cs
        mov ds, ax  ; buffers are from cs

        mov ax, 0b800h
        mov es, ax

        mov ah, START_COLOR
        call DrawRectangleRamka
        mov di, offset hello_string
        mov cx, offset hello_string_end
        sub cx, di 
        call PrintStringOnScreen

        xor al, al
        mov ah, 0ch 
        int 21h

        mov ah, 01h
        int 21h
        cmp al, 0dh
        je accessed
        lea si, user_password   
    get_user_string:          
        mov cs:[si], al
        inc si
        int 21h
        cmp al, 0dh
        je end_getting_string
        jmp get_user_string
        

    end_getting_string:

        xor ah, ah                  ; ah - 1st 8bit hash 
        mov al, 1                   ; al - 2nd 8bit hash
        lea si, user_password 
        lea di, pearson_hash_table
        mov cx, 8
    
    count_pearson_hash:
        mov bl, ah
        xor bh, bh
        mov dl, al
        xor dh, dh
        ;1st hash
        xor bl, cs:[si]
        add bx, offset pearson_hash_table
        xchg si, bx
        mov ah, cs:[si] 
        xchg si, bx
        ;2nd hash
        xor dl, cs:[si]
        add dx, offset pearson_hash_table
        xchg di, dx
        mov al, cs:[di]
        xchg di, dx
        ;next letter
        inc si
        inc di
        loop count_pearson_hash

        ; ax - user hash
        lea di, correct_hash
    ;comparing passwords
        mov bx, cs:[di]
        cmp ax, bx     ; comparing user and correct password
        jne not_accessed

    accessed:
        mov ah, ACCESS_GRANT_COLOR
        call DrawRectangleRamka
        mov di, offset access_grant_string
        mov cx, offset access_grant_string_end
        sub cx, di 
        call PrintStringOnScreen
        jmp end_programm

    not_accessed:
        mov ah, ACCESS_DENY_COLOR
        call DrawRectangleRamka
        mov di, offset access_deny_string
        mov cx, offset access_deny_string_end
        sub cx, di 
        call PrintStringOnScreen

    end_programm:
        mov ax, 4c00h
		int 21h

        endp



;--------------------------
;printing string with empty-1st-middle-2nd-empty style (stosw-stosw-rep stosw-stosw-stosw)
;Expect: es:[di] - where to printout ramka
;Entry: dh - left symbol ; dl - right symbol ; ch - middle symbol
;Destroy: al cx di
;Return: di - start position in new line
;--------------------------
PrintOneRamkaString proc
        xor al, al
        stosw           ; printing second string with tacing   
        mov al, dh      ; левый символ
        stosw
        mov al, ch      ; средний символ
        mov cx, RAMKA_WIDTH * 2 - 4
        rep stosw
        mov al, dl      ; правый символ
        stosw
        xor al, al
        stosw

        add di, (SCREEN_WIDTH - RAMKA_WIDTH * 2) * 2

        ret
        endp 
;--------------------------



;--------------------------
;draw ramka ah color RAMKA_WIDTH width and 1h high
;Expect:   es = 0b800h
;destroy:  di, si, dx, bx, al, cx
;save:     ah
;Return:   nothing
;--------------------------
DrawRectangleRamka proc
        mov cx, RAMKA_WIDTH * 2 ; string width

    ;counting ramka position
        mov di, SCREEN_WIDTH * (RAMKA_Y_CORD * 2 + 1) - RAMKA_WIDTH * 2; begin of ramka coordinate 
        xor al, al      ; no symbol

	;first two strings
        rep stosw       ; printing first empty string
        add di, SCREEN_WIDTH * 2 - RAMKA_WIDTH * 4

        mov dx, 0c9bbh  ; c9 - верхний левый угловой символ, bb - правый верхний угловой символ
        mov ch, 205d    ; пр€мой символ похожий на '='
        call PrintOneRamkaString    ; printing second string

    ;middle of ramka
        mov dx, 0babah  ; вертикальна€ окантовка в два полу-регистра сразу
        mov ch, 0h      ; центральный символ пустой

        call PrintOneRamkaString

	;last two strings
        mov dx, 0c8bch  ; c8 - левый нижний угловой символ, bc - правый нижний угловой символ
        mov ch, 205d    ; пр€мой символ типо '='
        call PrintOneRamkaString    ; предпоследн€€ строка

        mov cx, RAMKA_WIDTH * 2
        xor al, al
        rep stosw       ; last string

        ret
        endp
;--------------------------



;--------------------------
;di - string begin
;cx - string length
;ah - symbol & back color
;--------------------------
PrintStringOnScreen proc
        mov si, SCREEN_WIDTH * (RAMKA_Y_CORD * 2 + 5) - RAMKA_WIDTH * 2 + 4; begin of string coordinate 

    print_one_character:
        mov al, ds:[di] 
        mov es:[si], ax
        inc di
        add si, 2
        loop print_one_character

        ret  
        endp
;--------------------------


user_password       db "passport"   ; пользовательский пароль по умолчанию хранитс€ как верный
correct_hash        dw 6b33h

pearson_hash_table  db 98,6,85,150,36,23,112,164,135,207,169,5,26,64,165,219
                    db 61,20,68,89,130,63,52,102,24,229,132,245,80,216,195,115
                    db 90,168,156,203,177,120,2,190,188,7,100,185,174,243,162,10
                    db 237,18,253,225,8,208,172,244,255,126,101,79,145,235,228,121
                    db 123,251,67,250,161,0,107,97,241,111,181,82,249,33,69,55
                    db 59,153,29,9,213,167,84,93,30,46,94,75,151,114,73,222
                    db 197,96,210,45,16,227,248,202,51,152,252,125,81,206,215,186
                    db 39,158,178,187,131,136,1,49,50,17,141,91,47,129,60,99
                    db 154,35,86,171,105,34,38,200,147,58,77,118,173,246,76,254
                    db 133,232,196,144,198,124,53,4,108,74,223,234,134,230,157,139
                    db 189,205,199,128,176,19,211,236,127,192,231,70,233,88,146,44
                    db 183,201,22,83,13,214,116,109,159,32,95,226,140,220,57,12
                    db 221,31,209,182,143,92,149,184,148,62,113,65,37,27,106,166
                    db 3,14,204,72,21,41,56,66,28,193,40,217,25,54,179,117
                    db 238,87,240,155,180,170,242,212,191,163,78,218,137,194,175,110
                    db 43,119,224,71,122,142,42,160,104,48,247,103,15,11,138,239

hello_string        db "Please print password: "
hello_string_end:
access_grant_string db "access granted"
access_grant_string_end:
access_deny_string  db "access denied"
access_deny_string_end:

end Start
