%include "io.inc" ;for nasm io.inc is given in the repository

section .data 
    display_start: dq 0xf1fe1e64413421fa ; initialisiere Display
section .text

global main
main:
    mov ebp, esp; for correct debugging
;main: print initial and mirrored display

 PRINT_STRING "Display:"
 NEWLINE

 mov eax, display_start
 call print_pixel ;print initial display

 mov ebx, display_start
 call mirror ; mirror display
 
 NEWLINE
 PRINT_STRING "Gespiegeltes Display:"
 NEWLINE
 
 mov eax, display_start
 call print_pixel ;print new display
 
 ret

 mirror:
    push edx
    push eax
    push ecx
    mov edx, 0
loop_bits:
    mov cl, 0 
    
    mov al, [ebx + edx]
    and al, 0x81
    cmp al, 0
    je next_42bits
    cmp al, 0x81
    je add_81bits
    xor al, 0x81
    or cl, al
    jmp next_42bits
add_81bits:
    or cl, 0x81
    
next_42bits:
    mov al, [ebx + edx]
    and al, 0x42
    cmp al, 0
    je next_24bits
    cmp al, 0x42
    je add_42bits
    xor al, 0x42
    or cl, al
    jmp next_24bits
add_42bits:
    or cl, 0x42

next_24bits:
    mov al, [ebx + edx]
    and al, 0x24
    cmp al, 0
    je next_18bits
    cmp al, 0x24
    je add_24bits
    xor al, 0x24
    or cl, al
    jmp next_18bits
add_24bits:
    or cl, 0x24
    
next_18bits:
    mov al, [ebx + edx]
    and al, 0x18
    cmp al, 0
    je loop_back
    cmp al, 0x18
    je add_18bits
    xor al, 0x18
    or cl, al
    jmp loop_back
add_18bits:
    or cl, 0x18
    
loop_back:    
    mov [ebx + edx], cl
    inc edx
    cmp edx, 8
    je mirror_end
    jmp loop_bits
mirror_end:
    pop ecx
    pop eax
    pop edx  
    ret

print_pixel: ; start addr in eax
    push edx
    push esi
    push ebx
    mov edx,0
    line_loop: ;loop over lines
    push edx
        mov bl, [eax + edx]
        mov esi, 8
        push eax
        inner_line_loop: ; loop in line
            rcl bl, 1
            jc print_1
            PRINT_STRING "0"
            jmp continue
            print_1:
            PRINT_STRING "1"
            continue:
            dec esi
            cmp esi, 0
            jne inner_line_loop
        NEWLINE
        pop eax
        pop edx
        inc edx
        cmp edx, 8
        jne line_loop
    pop ebx
    pop esi
    pop edx
    ret

