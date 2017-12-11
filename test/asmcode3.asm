		.data
		Str0:  .asciiz "number\n"

		i:  .word 100
		j:  .word 200
		d:  .space 40

		.text
		.globl main
sort:	
		addi $sp, $sp, -52
		sw $ra, 48($sp)
		sw $fp, 44($sp)
		move $fp, $sp
		sw $a0, 52($sp)
		sw $a1, 56($sp)
		sw $a2, 60($sp)
		sw $a3, 64($sp)
		lw $v1, 68($sp)
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		lw $v1, 72($sp)
		addi $t9, $sp, 36
		sw $v1, 0($t9)
		lw $v1, 68($sp)
		lw $t9, 72($sp)
		add $t0, $v1, $t9
		li $t9, 2
		div $t1, $t0, $t9
		la $v1, d
		mulu $t9, $t1, 4
		add $v1, $v1, $t9
		lw $t2, 0($v1)
		addi $t9, $sp, 32
		sw $t2, 0($t9)
Label0:	
Label1:	
		la $v1, d
		lw $t9, 36($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 32($sp)
		sub $t1, $v1, $t0
		bgez $t1, Label2
		nop
		lw $v1, 36($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		addi $t9, $sp, 36
		sw $t0, 0($t9)
Label2:	
		la $v1, d
		lw $t9, 36($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 32($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label1
		nop
Label3:	
		la $v1, d
		lw $t9, 40($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 32($sp)
		sub $t1, $v1, $t0
		blez $t1, Label4
		nop
		lw $v1, 40($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 40
		sw $t0, 0($t9)
Label4:	
		la $v1, d
		lw $t9, 40($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 32($sp)
		sub $t1, $v1, $t0
		bgtz $t1, Label3
		nop
		lw $v1, 40($sp)
		lw $t9, 36($sp)
		sub $t0, $v1, $t9
		bgtz $t0, Label5
		nop
		la $v1, d
		lw $t9, 40($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		addi $t9, $sp, 28
		sw $t0, 0($t9)
		la $v1, d
		lw $t9, 36($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		la $t9, d
		lw $t8, 40($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		la $t9, d
		lw $t8, 36($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		lw $v1, 40($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 40
		sw $t0, 0($t9)
		lw $v1, 36($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		addi $t9, $sp, 36
		sw $t0, 0($t9)
Label5:	
		lw $v1, 40($sp)
		lw $t9, 36($sp)
		sub $t0, $v1, $t9
		blez $t0, Label0
		nop
		lw $v1, 40($sp)
		lw $t9, 72($sp)
		sub $t0, $v1, $t9
		bgez $t0, Label6
		nop
		li $a0, 0
		li $a1, 0
		li $a2, 0
		li $a3, 0
		lw $t8, 40($sp)
		sw $t8, 16($sp)
		lw $t8, 72($sp)
		sw $t8, 20($sp)
		jal sort
		nop
Label6:	
		lw $v1, 68($sp)
		lw $t9, 36($sp)
		sub $t0, $v1, $t9
		bgez $t0, Label7
		nop
		li $a0, 0
		li $a1, 2
		li $a2, 0
		li $a3, 5
		lw $t8, 68($sp)
		sw $t8, 16($sp)
		lw $t8, 36($sp)
		sw $t8, 20($sp)
		jal sort
		nop
Label7:	
		move $sp, $fp
		lw $ra, 48($sp)
		lw $fp, 44($sp)
		addi $sp, $sp, 52
		jr $ra
		nop
main:	
		addi $sp, $sp, -40
		sw $ra, 36($sp)
		sw $fp, 32($sp)
		move $fp, $sp
		li $v1, 0
		addi $t9, $sp, 28
		sw $v1, 0($t9)
		li $v1, 9
		la $t9, d
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		li $v1, 8
		sub $t0, $0, $v1
		la $t9, d
		addi $t9, $t9, 4
		sw $t0, 0($t9)
		li $v1, 2
		la $t9, d
		addi $t9, $t9, 8
		sw $v1, 0($t9)
		li $v1, 7
		la $t9, d
		addi $t9, $t9, 12
		sw $v1, 0($t9)
		li $v1, 109
		la $t9, d
		addi $t9, $t9, 16
		sw $v1, 0($t9)
		li $v1, 29
		sub $t0, $0, $v1
		la $t9, d
		addi $t9, $t9, 20
		sw $t0, 0($t9)
		li $v1, 17
		la $t9, d
		addi $t9, $t9, 24
		sw $v1, 0($t9)
		li $v1, 0
		la $t9, d
		addi $t9, $t9, 28
		sw $v1, 0($t9)
		li $v1, 2
		la $t9, d
		addi $t9, $t9, 32
		sw $v1, 0($t9)
		li $v1, 11
		la $t9, d
		addi $t9, $t9, 36
		sw $v1, 0($t9)
		li $a0, 0
		li $a1, 0
		li $a2, 0
		li $a3, 0
		li $t8, 0
		sw $t8, 16($sp)
		li $t8, 9
		sw $t8, 20($sp)
		jal sort
		nop
Label8:	
		la $v1, d
		lw $t9, 28($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str0
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v1, 28($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 28
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 9
		sub $t1, $t0, $t9
		blez $t1, Label8
		nop
