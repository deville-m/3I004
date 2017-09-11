.data

	table: .asciiz "0123456789ABCDEF"
	string: .asciiz "0x--------"
	n: .word 0x5432ABCD

.text
.globl main

main:
	la $4, n
	lw $4, ($4)
	la $5, table
	la $6, string
	addi $6, $6, 2
	ori $8, $8, 32
	loop:
		addi $8, $8, -4
		srav $9, $4, $8
		andi $9, $9, 0x0F
		add $10, $5, $9
		lb $10, ($10)
		sb $10, ($6)
		addi $6, $6, 1
		bgtz $8, loop
	ori $2, $0, 10
	syscall
