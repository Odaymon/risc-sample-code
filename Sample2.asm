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

.data 
var1: .byte 10
var2: .byte 10, 20, 30, 40, 50, -1
ans: .byte 0

.text
main:
 #la x10, var1
#lw x20, (x10)
 #PRINT_DEC(x20)
 
 la x11, var2
 li x8, 0
 li x9, -1
 la x12, ans
 
again:
 lb x21 (x11)
 beq x21, x9, tapos
 add x8, x8, x21 # x8 + 20 store in x8
 addi x11, x11, 1 # addi instruction involving immediate value : increment
 j again # J pseudo instruction for jump
 
 
tapos:
sb x8, (x12)
PRINT_DEC(x8)

 exit