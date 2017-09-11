.data

	tab: .word 23, 7, 12, 513, -1

.text
.globl main

#####################################
#	Get the size of a int array		#
#	Note that last must be -1		#
#	Param: a0 => int *tab			#
#	To save before call: a0, v0, ra	#
#####################################
sizetab:
	addiu $sp, $sp, -4
	sw $s0, ($sp)
	lui $v0, 0
	loop:
		lw $s0, ($a0)
		bltz $s0, end
		addiu $a0, $a0, 4
		addiu $v0, $v0, 1
		j loop
	end:
	lw $s0, ($sp)
	addiu $sp, $sp, 4
	jr $ra

#####################################
#	Get the sum of a int array		#
#	Note that last must be -1		#
#	Param: a0 => int *tab			#
#	To save before call: a0, v0, ra	#
#####################################
sumtab:
	addiu $sp, $sp, -4
	sw $s0, ($sp)
	lui $v0, 0
	loop2:
		lw $s0, ($a0)
		bltz $s0, end2
		addiu $a0, $a0, 4
		addu $v0, $v0, $s0
		j loop2
	end2:
	lw $s0, ($sp)
	addiu $sp, $sp, 4
	jr $ra

#####################################
#	Get the mean of a int array		#
#	Note that last must be -1		#
#	Param: a0 => int *tab			#
#	To save before call: a0, v0, ra	#
#####################################
arimean:
	addiu $sp, $sp, -12
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $s0, 8($sp)
	jal sizetab
	ori $s0, $v0, 0
	lw $a0, 0($sp)
	jal sumtab
	lw $ra, 4($sp)
	divu $v0, $s0
	mflo $v0
	lw $s0, 8($sp)
	addiu $sp, $sp, 12
	jr $ra


main:
	ori $a0, $zero, ' '
	ori $v0, $zero, 11
	syscall
	la $a0, tab
	jal arimean
	ori $a0, $v0, 0
	ori $v0, $zero, 1
	syscall
	ori $a0, $zero, ' '
	ori $v0, $zero, 11
	syscall
	ori $v0, $zero, 10
	syscall
