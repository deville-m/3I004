.text
.globl main

main:
	#na = 1, nr = 1, nv = 0
	#prologue
	addiu $sp, $sp, -8
	sw $ra, 4($sp)

	#corps de main
	ori $a0, $zero, 5
	jal factorial
	ori $a0, $v0, 0
	ori $v0, $zero, 1
	syscall
	ori $a0, $zero, '\n'
	ori $v0, $zero, 11
	syscall
	ori $v0, $zero, 10
	syscall

	#epilogue
	lw $ra, 4($sp)
	addiu $sp, $sp, 8

################################
#   Calculate factorial of a0  #
#   Note : 0 <= a0 <= 13       #
#   Params : a0 => fact(a0)    #
#   na = 1, nr = 2, nv = 0     #
################################
factorial:
	#prologue
	addiu $sp, $sp, -8
	sw $s0, 0($sp)
	sw $ra, 4($sp)

	#corps de factorial
	sltiu $v0, $a0, 13
	beq $v0, $zero, returnerror # if a0 < 0 or a0 > 13

	ori $v0, $zero, 1
	blez $a0, return # a0 == 0 (Base case)

	ori $s0, $a0, 0
	addiu $a0, $a0, -1
	jal factorial

	multu $v0, $s0
	mflo $v0

	#epilogue
	return:
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addiu $sp, $sp, 8
		jr $ra

	returnerror:
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		ori $v0, $zero, -1
		addiu $sp, $sp, 8
		jr $ra
