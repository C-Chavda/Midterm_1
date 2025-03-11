;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;  Author name: Chandresh CHavda
;  Author email: chav349@csu.fullerton.edu
;  CWID: 885158899
;  Class: 240-11 Section 11
;  Date: March 11, 2025
;  240-3 Midterm Program
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

; Declarations
extern printf
global current

segment .data
; Declare initialized strings
cur_1 db "The current on circuit #1 is %.5lf amps.", 10, 0
cur_2 db "The current on circuit #2 is %.5lf amps.", 10, 0
cur_3 db "The current on circuit #3 is %.5lf amps.", 10, 0
total_current db "The total current is %.5lf amps.", 10, 0

segment .bss
; Declare backup storage area
align 64
backup_storage_area resb 832

segment .text

current:
; Backup GPRs and other registers
backup_registers:
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Backup SSE registers
    mov rax, 7
    mov rdx, 0
    xsave [backup_storage_area]

; Store resistances and electric force in registers for calculations
prepare_calculations:
    movsd xmm0, xmm14  ; Resistance 1 (R1)
    movsd xmm1, xmm13  ; Resistance 2 (R2)
    movsd xmm2, xmm12  ; Resistance 3 (R3)
    movsd xmm3, xmm15  ; Electric Force (E)

; Calculate the current for circuit 1 (I1 = E / R1)
calculate_circuit_1:
    movsd xmm10, xmm15  ; E
    divsd xmm10, xmm14  ; R1

; Calculate the current for circuit 2 (I2 = E / R2)
calculate_circuit_2:
    movsd xmm11, xmm15  ; E
    divsd xmm11, xmm13  ; R2

; Calculate the current for circuit 3 (I3 = E / R3)
calculate_circuit_3:
    movsd xmm12, xmm15  ; E
    divsd xmm12, xmm2   ; R3

; Calculate total current (I = I1 + I2 + I3)
calculate_total_current:
    movsd xmm13, xmm10  ; I1
    addsd xmm13, xmm11  ; I1 + I2
    addsd xmm13, xmm12  ; I1 + I2 + I3

; Print results for circuit 1, circuit 2, circuit 3, and total current
print_results:
    ; Print current for circuit 1
    mov rax, 1
    mov rdi, cur_1
    movsd xmm0, xmm10
    call printf

    ; Print current for circuit 2
    mov rax, 1
    mov rdi, cur_2
    movsd xmm0, xmm11
    call printf

    ; Print current for circuit 3
    mov rax, 1
    mov rdi, cur_3
    movsd xmm0, xmm12
    call printf

    ; Print total current
    mov rax, 1
    mov rdi, total_current
    movsd xmm0, xmm13
    call printf

; Move total current to stack for safekeeping
store_total_current:
    mov rax, 0
    push qword 0
    movsd [rsp], xmm13

; Restore SSE and general registers
restore_registers:
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

    ; Send total current back to main
    movsd xmm0, [rsp]
    pop rax

    ; Restore GPRs
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp  ; Restore base pointer
    ret

; End of the function current ============================================================