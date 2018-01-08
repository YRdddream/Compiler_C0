		.data


		.text
		.globl main
fibonacci:	
		addi $sp, $sp, -56
		sw $ra, 52($sp)
		sw $fp, 48($sp)
		move $fp, $sp
		sw $a0, 56($sp)
		lw $v1, 56($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		move $a0, $t0
		sw $t0, 44($sp)
		jal fibonacci
		nop
		lw $t0, 44($sp)
		move $t1, $v0
		li $v1, 17
		li $t9, 16
		sub $t2, $v1, $t9
		li $v1, 16
		sub $t3, $0, $v1
		li $v1, 17
		add $t4, $v1, $t3
		mul $t5, $t3, $t4
		li $v1, 17
		add $t6, $v1, $t5
		mul $t7, $t1, $t2
		la $t8, 
		sw $t0, 12($t8)
		mul $t0, $t7, $t6
		lw $v1, 56($sp)
		li $t9, 2
		la $t8, 
		sw $t1, 16($t8)
		sub $t1, $v1, $t9
		move $a0, $t1
		sw $t0, 44($sp)
		sw $t1, 40($sp)
		sw $t2, 36($sp)
		sw $t3, 32($sp)
		sw $t4, 28($sp)
		sw $t5, 24($sp)
		sw $t6, 20($sp)
		sw $t7, 16($sp)
		la $v1, 
		lw $t8, 4($v1)
		sw $t8, 12($sp)
		la $v1, 
		lw $t8, 8($v1)
		sw $t8, 8($sp)
		jal fibonacci
		nop
		lw $t0, 44($sp)
		lw $t1, 40($sp)
		lw $t2, 36($sp)
		lw $t3, 32($sp)
		lw $t4, 28($sp)
		lw $t5, 24($sp)
		lw $t6, 20($sp)
		lw $t7, 16($sp)
		lw $t8, 12($sp)
		la $v1, 
		sw $t8, 4($v1)
		lw $t8, 8($sp)
		la $v1, 
		sw $t8, 8($v1)
		la $t8, 
		sw $t2, 20($t8)
		move $t2, $v0
		la $t8, 
		sw $t3, 24($t8)
		add $t3, $t1, $t0
		move $v0, $t3
		move $sp, $fp
		lw $ra, 52($sp)
		lw $fp, 48($sp)
		addi $sp, $sp, 56
		jr $ra
		nop
main:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v1, 42
		sw $v1, 8($sp)
		li $v1, 42
		sw $v1, 4($sp)
