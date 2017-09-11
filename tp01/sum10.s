.text
.globl main

main:
	ori $5, $0, 0
	ori $4, $0, 9
	loop:
		add $5, $5, $4
		add $4, $4, -1
		bgtz $4, loop
	ori $2, $0, 10
	syscall
