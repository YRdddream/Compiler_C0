		.data
		Str0:  .asciiz "Test expression\n"
		Str1:  .asciiz "a should be 9:\n"
		Str2:  .asciiz "a should be 14:\n"
		Str3:  .asciiz "d1[0] should be 17:\n"
		Str4:  .asciiz "#Result of expression ends\n"

		BHHH:  .word 0
		void1:  .word 10
		a:  .word 0
		b:  .word 0
		c:  .space 20
		d:  .space 32
		a1:  .word 0
		_:  .word 0
		default:  .word 0
		single:  .word 0
		AHHH:  .word 0

		.text
		.globl main
mult_add:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		sw $a2, 20($sp)
		sw $a3, 24($sp)
		lw $s0, 24($sp)
		lw $s1, 28($sp)
		lw $s2, 32($sp)
		add $t0, $s0, $s1
		sub $t1, $t0, $s2
		move $v0, $t1
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
main:	
		addi $sp, $sp, -80
		sw $ra, 76($sp)
		sw $fp, 72($sp)
		move $fp, $sp
		lw $s0, 68($sp)
		li $v1, 0
		li $t9, 0
		add $t0, $v1, $t9
		li $v1, 3
		addi $t9, $sp, 60
		mulu $t8, $t0, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		li $v1, 2
		sub $t1, $0, $v1
		addi $t9, $sp, 60
		addi $t9, $t9, 4
		sw $t1, 0($t9)
		li $v1, 0
		la $t9, _
		sw $v1, 0($t9)
		li $v1, 0
		move $s0, $v1
		li $v0, 4
		la $a0, Str0
		syscall
		li $v1, 1
		add $t0, $v1, $s0
		li $v1, 12
		sub $t1, $0, $v1
		addi $v1, $sp, 60
		lw $t2, 4($v1)
		li $t9, 2
		add $t3, $t2, $t9
		mul $t4, $t3, $t1
		la $t9, _
		lw $t9, 0($t9)
		add $t5, $t4, $t9
		addi $v1, $sp, 60
		mulu $t9, $t5, 4
		add $v1, $v1, $t9
		lw $t6, 0($v1)
		addi $v1, $sp, 60
		lw $t7, 0($v1)
		addi $v1, $sp, 60
		mulu $t9, $t0, 4
		la $t8, AHHH
		sw $t0, 4($t8)
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		la $t8, AHHH
		sw $t1, 8($t8)
		mul $t1, $t0, $t6
		la $t8, AHHH
		sw $t2, 12($t8)
		sub $t2, $0, $t1
		la $t8, AHHH
		sw $t3, 16($t8)
		add $t3, $t2, $t7
		la $t9, _
		lw $t9, 0($t9)
		la $t8, AHHH
		sw $t4, 20($t8)
		sub $t4, $t3, $t9
		la $t9, a
		sw $t4, 0($t9)
		li $v0, 4
		la $a0, Str1
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v1, -5
		sub $t0, $0, $v1
		li $t9, 9
		add $t1, $t0, $t9
		la $t9, a
		sw $t1, 0($t9)
		li $v0, 4
		la $a0, Str2
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v1, 12
		sub $t0, $0, $v1
		li $v1, 17
		li $t9, -16
		add $t1, $v1, $t9
		addi $v1, $sp, 60
		lw $t2, 4($v1)
		li $t9, 2
		add $t3, $t2, $t9
		mul $t4, $t3, $t0
		la $t9, _
		lw $t9, 0($t9)
		add $t5, $t4, $t9
		add $t6, $t5, $t1
		li $t9, 1
		sub $t7, $t6, $t9
		li $v1, 17
		addi $t9, $sp, 60
		mulu $t8, $t7, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		addi $v1, $sp, 60
		la $t8, AHHH
		sw $t5, 4($t8)
		lw $t5, 0($v1)
		li $v0, 4
		la $a0, Str3
		syscall
		li $v0, 1
		move $a0, $t5
		syscall
		li $v0, 4
		la $a0, Str4
		syscall
		li $v0, 5
		syscall
		la $v1, a1
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		la $v1, single
		sw $v0, 0($v1)
		li $v0, 12
		syscall
		la $v1, default
		sw $v0, 0($v1)
		li $a0, 0
		li $a1, 0
		li $a2, 0
		la $t8, a1
		lw $t8, 0($t8)
		move $a3, $t8
		la $t8, default
		lw $t8, 0($t8)
		sw $t8, 16($sp)
		la $t8, single
		lw $t8, 0($t8)
		sw $t8, 20($sp)
		sw $s0, 56($sp)
		jal mult_add
		nop
		lw $s0, 56($sp)
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
