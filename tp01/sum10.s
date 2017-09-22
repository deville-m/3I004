.text
.globl main

main:
	ori $5, $0, 0
	ori $2, $0, 10
	loop:
		addu $5, $5, $2
		addiu $2, $2, -1
		bgtz $2, loop
	ori $2, $0, 10
	syscall
