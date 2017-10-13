	.file	1 "tri.c"
	.text
	.align	2
	.globl	echange
	.ent	echange
echange:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addiu	$sp,$sp,-8
	sw	$4,8($sp)
	sw	$5,12($sp)
	sw	$6,16($sp)
	lw	$2,12($sp)
	sll	$3,$2,2
	lw	$2,8($sp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,0($sp)
	lw	$2,12($sp)
	sll	$3,$2,2
	lw	$2,8($sp)
	addu	$4,$3,$2
	lw	$2,16($sp)
	sll	$3,$2,2
	lw	$2,8($sp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,0($4)
	lw	$2,16($sp)
	sll	$3,$2,2
	lw	$2,8($sp)
	addu	$3,$3,$2
	lw	$2,0($sp)
	sw	$2,0($3)
	addiu	$sp,$sp,8
	j	$31
	.end	echange
	.align	2
	.globl	tri
	.ent	tri
tri:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	addiu	$sp,$sp,-40
	sw	$31,32($sp)
	sw	$4,40($sp)
	sw	$5,44($sp)
	lw	$2,44($sp)
	slt	$2,$2,2
	beq	$2,$0,$L3
	j	$L2
$L3:
	sw	$0,16($sp)
	sw	$0,20($sp)
$L4:
	lw	$2,20($sp)
	lw	$3,44($sp)
	slt	$2,$2,$3
	beq	$2,$0,$L5
	lw	$2,20($sp)
	sll	$3,$2,2
	lw	$2,40($sp)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,16($sp)
	slt	$2,$2,$3
	beq	$2,$0,$L6
	lw	$2,20($sp)
	sll	$3,$2,2
	lw	$2,40($sp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,16($sp)
	lw	$2,20($sp)
	sw	$2,24($sp)
$L6:
	lw	$2,20($sp)
	addiu	$2,$2,1
	sw	$2,20($sp)
	j	$L4
$L5:
	lw	$2,44($sp)
	addiu	$2,$2,-1
	lw	$4,40($sp)
	lw	$5,24($sp)
	move	$6,$2
	jal	echange
	lw	$2,44($sp)
	addiu	$2,$2,-1
	lw	$4,40($sp)
	move	$5,$2
	jal	tri
$L2:
	lw	$31,32($sp)
	addiu	$sp,$sp,40
	j	$31
	.end	tri
	.rdata
	.align	2
$LC0:
	.word	3
	.word	33
	.word	49
	.word	4
	.word	23
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$sp,48,$31		# vars= 24, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	addiu	$sp,$sp,-48
	sw	$31,40($sp)
	lw	$2,$LC0
	lw	$3,$LC0+4
	lw	$4,$LC0+8
	lw	$5,$LC0+12
	lw	$6,$LC0+16
	sw	$2,16($sp)
	sw	$3,20($sp)
	sw	$4,24($sp)
	sw	$5,28($sp)
	sw	$6,32($sp)
	addiu	$4,$sp,16
	li	$5,5			# 0x5
	jal	tri
	lw	$31,40($sp)
	addiu	$sp,$sp,48
	j	$31
	.end	main
