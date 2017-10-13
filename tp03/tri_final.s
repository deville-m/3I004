	.data
tab: .word 3, 33, 49, 4, 300, 12, 46, 21, 48, 2
retour: .asciiz "\n"

	.text
main:
  #prologue nr = 1, nv = 0, na = 2
  addiu $29, $29, -12
  sw $31, 8($29)
  
   la $4, tab #$4 <= adresse de tab
  li $5, 10
  jal affiche
  
  la $4, tab #$4 <= adresse de tab
  li $5, 10
  jal tri
  
  la $4, tab #$4 <= adresse de tab
  li $5, 10
  jal affiche
  
  ori $2, $0, 10
  syscall
  
  #épilogue
  lw $31, 8($29)
  addiu $29, $29, 12
  jr $31
  
affiche:
  #prologue na = 0, nv = 1, nr = 1
  addiu $29, $29, -8
  sw $31, 4($29)
  sw $4, 8($29)
  sw $5, 12($29)
  
  #corps
  ori $7, $0, 0 #$7 <= 0/i=0
  loop_affiche:
    sll $8, $7, 2 #$8 <= i*4
    lw $9, 8($29) #$9 <= tab
    addu $8, $8, $9 #$8 <= $8 + $9 tab + 4i
    lw $8, 0($8) #$8 <= tab[i] = m[tab + 4i]
    addi $7, $7, 1 #i++
    ori $2, $0, 1 #$2 <= putw
    move $4, $8 #$4 <= value
    syscall
    ori $2, $0, 4 #$2 <= puts
    la $4, retour #$4 <= retour
    syscall
    bne $5, $7, loop_affiche #branch to loop_affiche if i <= size
    
  #épilogue
  lw $31, 4($29) #restore $31
  addiu $29, $29, 8
  jr $31
 
echange :
	#prologue na = 0, nv = 0, nr = 1
	addiu $29, $29, -4
	sw $31, 0($29)
	
	
	#corps de la fonction $4 << adresse du tab | $5 << i | $6 << j | 
	
	sll $8, $5, 2 #$8 <= i*4
	addu $8, $4, $8 #$8 <= $4 + $8 adresse de tab[i]
	lw $9, ($8) #$9 <= valeau de tab[i] 
	sll $10, $6, 2 #$10 <= j*4
	addu $10, $4, $10 #$10 <= $4 + $11 adresse de tab[j]
	lw $11, ($10) #$11 <= valeur tab[j]
	sw $11, ($8) #à l'adresse de tab[i] on met la valeur de tab[j]
	sw $9, ($10) #à l'adresse de tab[j] on met la valeur de tab[i]	
	
	#epilogue
	lw $31, ($29)
	addiu $29, $29, 4
	jr $31
	
	
tri:
  #prologue nr = 3, na = 3, nv = 3
  addiu $29, $29, -36
  sw $31, 32($29)
  sw $16, 28($29)
  sw $17, 24($29)
  
  #corps de la fonction récursive tri $16 <= tab | $17 <= size | $8 <= valmax | $9 <= i | $10 <= imax
  move $16, $4 #$16 <= tab
  move $17, $5 #$17 <= size
  #cas terminal
  slti $11, $17, 2 #$11 <= ($17 < 2)
  bne $11,$0, epilog #branch to epilog if si $17 < 2
  #cas non terminal
  ori $8, $0, 0 #$8 <= 0
  ori $9, $0, 0 #$9 <= 0
  tri_loop:
    sll $11, $9, 2 #$11 <= 4*i
    addu $11, $11, $16 #$11 <= &tab[i]
    lw $11, 0($11) #$11 <= tab[i]
    slt $12, $11, $8 #$12 <= tab[i] < valmax
    bne $12, $0, tri_nop #branch to tri_nop if tab[i] < valmax
    move $8, $11 #valmax <= tab[i]
    move $10, $9 #imax <= i
    
tri_nop:
  addiu $9, $9, 1 #i++
  bne $9, $17, tri_loop #sortie boucle si i = size
  
  #appel fonction echange
  move $4, $16 #$4 <= tab
  move $5, $10 #$5 <= imax
  addiu $6, $17, -1 #$6 <= size -1
  jal echange
  
   #appel fontion tri
   move $4, $16 #$4 <= tab
   addiu $5, $17, -1 #$5 <= size - 1
   jal tri 

 epilog: #epilogue
  lw $31, 32($29)
  lw $16, 28($29)
  lw $17, 24($29)
  addiu $29, $29, 36
  jr $31
