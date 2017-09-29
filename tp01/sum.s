.data
	var1: .word 15
	var2: .word 17
	var3: .space 4

.text

.globl main

main:

	la $8, var1
	la $9, var2
	la $10, var3
	lw $8, 0($8)
	lw $9, 0($9)
	addu $8, $8, $9
	sw $8, 0($10)
	ori $2, $0, 10
	syscall
