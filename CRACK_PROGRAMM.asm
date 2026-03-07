.model tiny
.code
org 100h

SCREEN_WIDTH equ 160d

CORRECT_HASH equ 0fb33h

Start:
        mov ax, cs
        mov ds, ax  ; buffers are from cs

        mov dx, offset hello_string
        mov ah, 09h
        int 21h

        xor al, al
        mov ah, 0ch 
        int 21h

        mov ah, 01h
        lea si, user_password   
    get_user_string:
        ;in al, 60h              
        ;cmp al, 01h            
        int 21h
        cmp al, 0dh
        je end_getting_string
        mov cs:[si], al
        inc si
        loop get_user_string
        

    end_getting_string:

        mov ah, 09h

        lea si, user_password
        lea di, correct_passwort
    compare_passwords:
        mov bx, cs:[si]
        cmp bx, cs:[di]     ; comparing user and correct password
        jne not_accessed

        mov dx, offset access_grant_string
        int 21h
        jmp end_programm

    not_accessed:
        mov dx, offset access_deny_string
        int 21h

    end_programm:
        mov ax, 4c00h
		int 21h

        endp



;------------------------
;entry: cx - str length
;return: ax - str hash
;destroy: ax, bx
;------------------------
PearsonHash proc
        xor ah, ah                  ; ah - 1st 8bit hash 
        mov al, 1                   ; al - 2nd 8bit hash
        lea si, correct_passwort 
        lea di, pearson_hash_table
        mov cx, 8
    
    count_pearson_hash:
        mov bl, ah
        xor bh, bh
        mov dl, al
        xor dh, dh
        ;1st hash
        xor bl, cs:[si]
        add bx, offset correct_passwort
        xchg si, bx
        mov ah, cs:[si] 
        xchg si, bx
        ;2nd hash
        xor dl, cs:[si]
        add dx, offset pearson_hash_table
        xchg di, dx
        mov al, cs:[di]
        xchg di, dx

        inc si
        inc di
        loop count_pearson_hash

        mov bx, ax

        ret
;------------------------


user_password       db "********"
correct_pasword     db "passport"

hello_string        db "Please print password: $"
access_grant_string db "access granted$"
access_deny_string  db "access denied$"

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

end Start
