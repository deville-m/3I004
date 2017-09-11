.data

	var1: .word 15
	var2: .word 17
	var3: .word 0

.text
.globl main
main:

	la $4, var1
	la $5, var2
	la $6, var3
	lw $8, 0($4)
	lw $9, 0($5)
	add $8 $8 $9
	sw $8, 0($6)
	ori $2, $0, 10
	syscall
