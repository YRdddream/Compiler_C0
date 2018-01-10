		.data
		Str0:  .asciiz "The number is so small!\n"
		Str1:  .asciiz "#Result of fibonacci is \n"

		AHHH:  .word 0

		.text
		.globl main
max:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		lw $v1, 12($sp)
		lw $t9, 16($sp)
		sub $t0, $v1, $t9
		bgez $t0, Label0
		nop
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label0:	
		lw $t8, 12($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
fibonacci:	
		addi $sp, $sp, -76
		sw $ra, 72($sp)
		sw $fp, 68($sp)
		move $fp, $sp
		sw $a0, 76($sp)
		lw $v1, 76($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgez $t0, Label1
		nop
		li $v0, 4
		la $a0, Str0
		syscall
		li $v1, 1
		sub $t0, $0, $v1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 72($sp)
		lw $fp, 68($sp)
		addi $sp, $sp, 76
		jr $ra
		nop
Label1:	
		lw $v1, 76($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bgtz $t0, Label2
		nop
		lw $t8, 76($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 72($sp)
		lw $fp, 68($sp)
		addi $sp, $sp, 76
		jr $ra
		nop
Label2:	
		li $v1, 1
		sub $t0, $0, $v1
		sub $t1, $0, $t0
		lw $v1, 76($sp)
		sub $t2, $v1, $t1
		blez $t2, Label3
		nop
		lw $v1, 76($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		move $a0, $t0
		sw $t0, 64($sp)
		jal fibonacci
		nop
		lw $t0, 64($sp)
		move $t1, $v0
		li $v1, 43
		li $t9, 42
		sub $t2, $v1, $t9
		li $v1, 16
		sub $t3, $0, $v1
		li $v1, 17
		add $t4, $v1, $t3
		mul $t5, $t1, $t2
		mul $t6, $t5, $t4
		li $t9, 0
		add $t7, $t6, $t9
		li $v1, 20
		li $t9, 19
		la $t8, AHHH
		sw $t0, 4($t8)
		sub $t0, $v1, $t9
		lw $v1, 76($sp)
		li $t9, 0
		la $t8, AHHH
		sw $t1, 8($t8)
		add $t1, $v1, $t9
		li $t9, 1
		la $t8, AHHH
		sw $t2, 12($t8)
		mul $t2, $t1, $t9
		la $t8, AHHH
		sw $t3, 16($t8)
		div $t3, $t2, $t0
		li $t9, 4
		la $t8, AHHH
		sw $t4, 20($t8)
		add $t4, $t3, $t9
		li $t9, 2
		la $t8, AHHH
		sw $t5, 24($t8)
		sub $t5, $t4, $t9
		li $t9, 4
		la $t8, AHHH
		sw $t6, 28($t8)
		sub $t6, $t5, $t9
		move $a0, $t6
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		sw $t3, 52($sp)
		sw $t4, 48($sp)
		sw $t5, 44($sp)
		sw $t6, 40($sp)
		sw $t7, 36($sp)
		la $v1, AHHH
		lw $t8, 4($v1)
		sw $t8, 32($sp)
		la $v1, AHHH
		lw $t8, 8($v1)
		sw $t8, 28($sp)
		la $v1, AHHH
		lw $t8, 12($v1)
		sw $t8, 24($sp)
		la $v1, AHHH
		lw $t8, 16($v1)
		sw $t8, 20($sp)
		la $v1, AHHH
		lw $t8, 20($v1)
		sw $t8, 16($sp)
		la $v1, AHHH
		lw $t8, 24($v1)
		sw $t8, 12($sp)
		la $v1, AHHH
		lw $t8, 28($v1)
		sw $t8, 8($sp)
		jal fibonacci
		nop
		lw $t0, 64($sp)
		lw $t1, 60($sp)
		lw $t2, 56($sp)
		lw $t3, 52($sp)
		lw $t4, 48($sp)
		lw $t5, 44($sp)
		lw $t6, 40($sp)
		lw $t7, 36($sp)
		lw $t8, 32($sp)
		la $v1, AHHH
		sw $t8, 4($v1)
		lw $t8, 28($sp)
		la $v1, AHHH
		sw $t8, 8($v1)
		lw $t8, 24($sp)
		la $v1, AHHH
		sw $t8, 12($v1)
		lw $t8, 20($sp)
		la $v1, AHHH
		sw $t8, 16($v1)
		lw $t8, 16($sp)
		la $v1, AHHH
		sw $t8, 20($v1)
		lw $t8, 12($sp)
		la $v1, AHHH
		sw $t8, 24($v1)
		lw $t8, 8($sp)
		la $v1, AHHH
		sw $t8, 28($v1)
		la $t8, AHHH
		sw $t7, 32($t8)
		move $t7, $v0
		li $v1, 20
		li $t9, 19
		la $t8, AHHH
		sw $t0, 36($t8)
		sub $t0, $v1, $t9
		li $v1, 16
		la $t8, AHHH
		sw $t1, 40($t8)
		sub $t1, $0, $v1
		li $v1, 17
		la $t8, AHHH
		sw $t2, 44($t8)
		add $t2, $v1, $t1
		li $v1, 1
		la $t8, AHHH
		sw $t3, 48($t8)
		mul $t3, $v1, $t7
		la $t8, AHHH
		sw $t4, 52($t8)
		div $t4, $t3, $t0
		la $t8, AHHH
		sw $t5, 56($t8)
		mul $t5, $t4, $t2
		la $v1, AHHH
		lw $v1, 32($v1)
		la $t8, AHHH
		sw $t6, 60($t8)
		add $t6, $v1, $t5
		move $v0, $t6
		move $sp, $fp
		lw $ra, 72($sp)
		lw $fp, 68($sp)
		addi $sp, $sp, 76
		jr $ra
		nop
Label3:	
main:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v0, 5
		syscall
		sw $v0, 8($sp)
		lw $t8, 8($sp)
		move $a0, $t8
		jal fibonacci
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str1
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
