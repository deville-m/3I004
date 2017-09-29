.data

	table: .asciiz "0123456789ABCDEF"
	string: .asciiz "0x--------"
	n: .word 0x5432ABCD

.text
.globl main

main:
	la $4, n
	lw $4, ($4) # int n
	la $5, table # char *table
	la $6, string
	addiu $6, $6, 2 #  char *p = string + 2
	ori $8, $8, 32 # int i = 32;
	loop:
		addiu $8, $8, -4 # i -= 4
		srlv $9, $4, $8
		andi $9, $9, 0x0F # q = (n >> i) & 0x0F
		addu $10, $5, $9 # table + q
		lb $10, ($10) # *(table + q)
		sb $10, ($6) # *p = $10
		addiu $6, $6, 1 # p++
		bgtz $8, loop
	ori $2, $0, 10 # exit
	syscall

