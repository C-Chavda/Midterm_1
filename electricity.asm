;  Author name: Chandresh Chavda
;  Author email: chav349@csu.fullerton.edu
;  CWID: 885158899
;  Class: 240-11 Section 11
;  Date: March 11, 2025

;declarations

extern printf
extern scanf
extern atof
global electricity
extern current
extern isfloat

string_size equ 48

segment .data
;declare initialized arrays

floatform db "%s", 0
eforce db "Please enter the electric force in circuits (volts): ", 0
res_1 db "Please enter the resistance in circuit number 1 (ohms): ", 0
res_2 db "Please enter the resistance in circuit number 2 (ohms): ", 0
res_3 db "Please enter the resistance in circuit number 3 (ohms): ", 0
thanks db "Thank you.", 10, 0
badinput db "Invalid input. Try again: ", 0

segment .bss
;declare empty arrays

align 64
backup_storage_area resb 832

segment .text
electricity:

;Backup all registers
push_all:
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

mov rax,7
mov rdx,0
xsave [backup_storage_area]

;Input for Electric Force
call input_electric_force
jmp input_loop_r1

;Input for Resistance 1
input_loop_r1:
call input_resistance1
jmp input_loop_r2

;Input for Resistance 2
input_loop_r2:
call input_resistance2
jmp input_loop_r3

;Input for Resistance 3
input_loop_r3:
call input_resistance3
jmp calc

;Calculation and Printing
calc:
mov rax, 0
mov rdi, thanks
call printf

mov rax, 3
movsd xmm0, xmm14
movsd xmm1, xmm13
movsd xmm2, xmm15
movsd xmm3, xmm12
call current

mov rax, 0
push qword 0
movsd [rsp], xmm0

mov rax,7
mov rdx,0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
pop rax

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
pop rbp
ret

;================================ Subroutines ===============================
input_electric_force:
mov rax, 0
mov rdi, eforce
call printf
call get_valid_float
movsd xmm15, xmm0
ret

input_resistance1:
mov rax, 0
mov rdi, res_1
call printf
call get_valid_float
movsd xmm14, xmm0
ret

input_resistance2:
mov rax, 0
mov rdi, res_2
call printf
call get_valid_float
movsd xmm13, xmm0
ret

input_resistance3:
mov rax, 0
mov rdi, res_3
call printf
call get_valid_float
movsd xmm12, xmm0
ret

get_valid_float:
push qword 0
push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf

mov rdi, rsp
call isfloat
cmp rax, 0
je get_valid_float

mov rax, 0
mov rdi, rsp
call atof
pop r9
pop r9
ret
