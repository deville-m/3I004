.data

	tab: .word 23, 7, 12, 513, -1

.text
.globl main

main:
	# na = 1, nr = 1, nv = 0
	#prologue
	addiu $sp, $sp, -8
	sw $ra, 4($sp)

	#corps de main
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

	#epilogue
	lw $ra, 4($sp)
	addiu $sp, $sp, 8
	
	jr $ra

############################
#   Moyenne de int array   #
#   Note last elem = -1    #
#   Param: a0 => int *tab  #
#   na = 1, nr = 1, nv = 0 #
############################
arimean:
	#prologue
	addiu $sp, $sp, -12
	sw $s0, 4($sp)
	sw $ra, 8($sp)
	sw $4, 12($29)

	#corps de arimean
	jal sizetab
	ori $s0, $v0, 0
	lw $4, 12($29)
	jal sumtab
	divu $v0, $s0
	mflo $v0

	#epilogue
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addiu $sp, $sp, 12
	jr $ra

############################
#   Taille de int array    #
#   Note last elem = -1    #
#   Param: a0 => int *tab  #
#   na = 0, nr = 1, nv = 0 #
############################
sizetab:
	#prologue
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	#corps de strlen
	addiu $v0, $zero, 0
	loop:
		lw $t0, 0($a0)
		bltz $t0, end
		addiu $a0, $a0, 4
		addiu $v0, $v0, 1
		j loop
	end:
	
	#epilogue
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

###############################
#   Somme de int array        #
#   Note that last must be -1 #
#   Param: a0 => int *tab     #
#   na = 0, nr = 1, nv = 0    #
###############################
sumtab:
	#prologue
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	#corps de sumtab
	ori $v0, $zero, 0
	loop2:
		lw $t0, ($a0)
		bltz $t0, end2
		addiu $a0, $a0, 4
		addu $v0, $v0, $t0
		j loop2
	end2:

	#epilogue
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
