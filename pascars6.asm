# Author: Steven John Pascaran Section: CSC512C-G01
.globl main

.macro exit
li a7, 10
ecall
.end_macro

.macro PRINT_FLOAT(%x)
li a7, 2
fmv.s fa0, %x
ecall
.end_macro

.macro PRINT_STRING(%x)
li a7, 4
la a0, %x 
ecall
.end_macro

.macro NEWLINE
li a0, 10 # line feed
li a7, 11 # 11 is PRINT_CHAR
ecall
.end_macro

.data 
r1: .float 3.5
r2: .float 4.5
r3: .float 5.0
pi: .float 22.0
temp1: .float 7.0
temp2: .float 4.0
temp3: .float 3.0
msg: .asciz "The volume of the ellipsoid "

.text
main:
 
 la t1, r1
 la t2, r2
 la t3, r3
 la t4, pi
 la t5, temp1
 la t6, temp2
 la a1, temp3

 flw f1, (t1)
 flw f2, (t2)
 flw f3, (t3)
 flw f4, (t4)
 flw f5, (t5)
 flw f6, (t6)
 flw f7, (a1)

 fdiv.s f8, f4, f5
 fdiv.s f9, f6, f7

 fmul.s f10, f1, f2
 fmul.s f10, f10, f3
 fmul.s f10, f10, f8
 fmul.s f10, f10, f9
 
 # Print in dialog box
 li a7, 60 
 la a0, msg
 fmv.s fa1, f10  
 ecall

exit