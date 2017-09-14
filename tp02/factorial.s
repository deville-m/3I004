.text
.globl main

#################################
#	Calculate factorial of a0	#
#	Note : 0<= a0 <= 13			#
#	Params : a0 => fact(a0)		#
#	To save : a0, v0			#
#################################
factorial:
	addiu $sp, $sp, -8
	sw $s0, 0($sp)
	sw $ra, 4($sp)

	sltiu $v0, $a0, 13
	beq $v0, $zero, returnerror

	ori $v0, $zero, 1
	blez $a0, return

	ori $s0, $a0, 0
	addiu $a0, $a0, -1
	jal factorial

	multu $v0, $s0
	mflo $v0

	return:
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addiu $sp, $sp, 8
		jr $ra

	returnerror:
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addiu $sp, $sp, 8
		jr $ra

main:
	ori $a0, $zero, 5
	jal factorial
	ori $a0, $v0, 0
	ori $v0, $zero, 1
	syscall
	ori $a0, $zero, 10
	ori $v0, $zero, 11
	syscall
	ori $v0, $zero, 10
	syscall
