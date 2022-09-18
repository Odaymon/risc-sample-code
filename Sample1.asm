.globl main

.macro exit
li a7, 10
ecall
.end_macro

.macro PRINT_DEC(%x)
li a7, 1
mv a0, %x
ecall
.end_macro

.macro NEWLINE
li a0, 10 # line feed
li a7, 11 # 11 is PRINT_CHAR
ecall
.end_macro

.data 
var1: .byte +10, -20, -30, -40, 50, 60, 70, -1
posi: .byte 0
nega: .byte 0

.text
main:
 li x13, 0
 li x14, 0
 li x9, -1
 la x10, var1
 la x11, posi
 la x12, nega
 
again:
 lb x20, (x10)
 beq x20, x9, tapos
 bgez x20, addpos
 blez x20, addneg
 
 
 addpos:
 addi x13, x13, 1 # addi instruction involving immediate value : increment posi
 addi x10, x10, 1 # addi instruction involving immediate value : increment
 j again
 
 addneg:
 addi x14, x14, 1 # addi instruction involving immediate value : increment nega
 addi x10, x10, 1 # addi instruction involving immediate value : increment
 j again
 
tapos:
 sb x13, (x11)
 PRINT_DEC(x13)
 NEWLINE
 sb x14, (x12)
 PRINT_DEC(x14)

exit