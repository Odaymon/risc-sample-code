.globl main
# Author: Steven John Pascaran Section: CSC512C-G01
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
X: .float 1.5, -2.2, -3.4, 0.5, 1.7, 3.5, 1e38
Y: .float 1.2, 4.0, -3.6, -5.7, 0.8, 2.5, 1e38
terminator: .float 1e38
msg: .asciz "Signal Length = "
errmsg: .asciz "Lengths of X and Y must be equal!"

.text
main:
 la t1, X
 la t2, Y
 la t3, terminator
 li x1, 0
 li x2, 0
 li x3, 4
 li x4, 0

 flw f3, (t3)    # f3 = temp = 1e38
 fcvt.s.w f9, x0
 fcvt.s.w f10, x0

# Check length if it's the same
countX:
 flw f1, (t1)    # f1 = X
 feq.s t4, f1, f3 # If f1/t1 == 1e38
 bnez t4, countY  # if t4 != 0 
 
 addi t1, t1, 4 # Increment X
 addi x1, x1, 1 # Increment Length
 j countX

countY:
 flw f2, (t2)    # f2 = Y
 feq.s t4, f2, f3 # If f1/t1 == 1e38
 bnez t4, isEqual  # if t4 != 0 
 
 addi t2, t2, 4 # Increment Y
 addi x2, x2, 1 # Increment Length
 j countY
 
isEqual:
 bne x1, x2, error

# Print length in dialog box
 li a7, 56
 la a0, msg
 mv a1, x1
 ecall

# Revert to Original Address / Arr[0]
 mul t5, x1, x3
 sub t1, t1, t5
 sub t2, t2, t5
 flw f1, (t1)
 flw f2, (t2)
 j compute

# Multiply and Add
compute:
 flw f1, (t1)    # f1 = X
 flw f2, (t2)    # f2 = Y
 beq x1, x4, end # If x4 == x1 (Length of Array) 
 feq.s t4, f2, f3 # If f2/t2 == 1e38 -> Y
 bnez t4, print  # if t4 != 0
 fmul.s f8, f1, f2
 fadd.s f9, f9, f8 
 addi t1, t1, 4 # Increment X
 addi t2, t2, 4 # Increment Y
 j compute
 
# Print Answer in I/O
print:
 NEWLINE
 PRINT_FLOAT(f9)
 NEWLINE
 # Reset f8 and f9
 fsub.s f8, f8, f8
 fsub.s f9, f9, f9
 # Reset X
 sub x5, x2, x4
 mul a1, x5, x3 # Y * (x3 = 4)
 sub t1, t1, a1
 flw f1, (t1)
 # Increment Length for Y address
 addi x4, x4, 1 
 # Reset Y and Set Y Starting Address
 sub t2, t2, t5
 flw f2, (t2)
 mul t6, x4, x3
 add t2, t2, t6
 flw f2, (t2)
 j compute
 
# Print error in dialog box
error:
 li a7, 55
 la a0, errmsg
 ecall
 
end:
 exit
