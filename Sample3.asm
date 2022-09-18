.globl main # .globl directive / everything with a . is a directive

.data
var1: .byte 0xff
var2: .half 0xffff
var3: .word 0xffffffff
str1: .asciz "The answer is "
fvar1: .float 4.0
num1: .word 5
num2: .word 6
ans: .word 0

.text
main:
  la x10, num1 # lea x10, num1 l x10 --> num1
  la x11, num2 
  la x12, ans
  lw x20, (x10) # since num is word we use lw (Load word)
  lw x21, (x11)
  add x22, x20, x21
  sw x22, (x12) # Store in ans
  
  # Print Answer
  li a7, 1
  mv a0, x22
  ecall
  
  # Print using message dialog box
  la a0, str1
  mv a1, x22
  li a7, 56
  ecall
  

  li a7, 10 # Load immediate pseudo-instruction
  ecall # I/O Maco (Environment call)