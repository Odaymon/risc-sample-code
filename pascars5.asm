# Author: Steven John Pascaran Section: CSC512C-G01
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
msg1: .asciz "Enter Length: "
msg2: .asciz "Enter Width: "
msg3: .asciz "Perimeter: "
msg4: .asciz "Area: "
errmsg: .asciz "Error: Negative input not allowed, please try again."

.text
main:
 
again:
 PRINT_STRING (msg1)
 li a7, 5
 ecall
 mv x9, a0
 blez x9, error
 
 
 PRINT_STRING (msg2)
 li a7, 5
 ecall
 mv x13, a0
 blez x13, error
 
 # Compute Perimeter
 add x11, x9, x13
 add x11, x11, x11
 PRINT_STRING (msg3)
 PRINT_DEC (x11)
 NEWLINE
 
  # Compute Area
 mul x12, x9, x13
 PRINT_STRING (msg4)
 PRINT_DEC (x12)

 j end

error:
 PRINT_STRING (errmsg)
 NEWLINE
 j again
 
end:
exit