		.data
		Str0:  .asciiz "OVERFLOW! \n"
		Str1:  .asciiz "complete number: \n"
		Str2:  .asciiz "  \n"
		Str3:  .asciiz "  \n"
		Str4:  .asciiz "---------------------------------------------------------------\n\n"
		Str5:  .asciiz " \n"
		Str6:  .asciiz "  \n"
		Str7:  .asciiz "The total is \n"

		max_num:  .word 1024
		AHHH:  .word 0

		.text
		.globl main
complete_num:	
		addi $sp, $sp, -4148
		sw $ra, 4144($sp)
		sw $fp, 4140($sp)
		move $fp, $sp
		li $v1, 2
		addi $t9, $sp, 36
		sw $v1, 0($t9)
Label0:	
		li $v1, 1
		sub $t0, $0, $v1
		li $v1, 1
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		lw $v1, 36($sp)
		addi $t9, $sp, 28
		sw $v1, 0($t9)
		addi $t9, $sp, 32
		sw $t0, 0($t9)
Label1:	
		lw $v1, 36($sp)
		lw $t9, 40($sp)
		div $t0, $v1, $t9
		lw $t9, 40($sp)
		mul $t1, $t0, $t9
		lw $t9, 36($sp)
		sub $t2, $t1, $t9
		addi $t9, $sp, 24
		sw $t1, 0($t9)
		bnez $t2, Label2
		nop
		lw $v1, 32($sp)
		li $t9, 0
		add $t0, $v1, $t9
		lw $v1, 28($sp)
		li $t9, 0
		add $t1, $v1, $t9
		lw $t9, 40($sp)
		sub $t2, $t1, $t9
		li $t9, 1
		add $t3, $t0, $t9
		li $t9, 1024
		sub $t4, $t3, $t9
		addi $t9, $sp, 28
		sw $t2, 0($t9)
		addi $t9, $sp, 32
		sw $t3, 0($t9)
		bltz $t4, Label3
		nop
		li $v0, 4
		la $a0, Str0
		syscall
Label3:	
		lw $v1, 32($sp)
		li $t9, 1024
		sub $t0, $v1, $t9
		bgez $t0, Label4
		nop
		lw $v1, 40($sp)
		addi $t9, $sp, 44
		lw $t8, 32($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
Label4:	
Label2:	
		lw $v1, 40($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		lw $t9, 36($sp)
		sub $t2, $t1, $t9
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		bltz $t2, Label1
		nop
		lw $v1, 28($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bnez $t0, Label5
		nop
		li $v0, 4
		la $a0, Str1
		syscall
		lw $t8, 36($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v1, 0
		addi $t9, $sp, 40
		sw $v1, 0($t9)
Label6:	
		addi $v1, $sp, 44
		lw $t9, 40($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str2
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v1, 40($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		lw $t9, 32($sp)
		sub $t2, $t1, $t9
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		blez $t2, Label6
		nop
		li $v0, 4
		la $a0, Str3
		syscall
Label5:	
		lw $v1, 36($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		la $t9, max_num
		lw $t9, 0($t9)
		sub $t2, $t1, $t9
		addi $t9, $sp, 36
		sw $t1, 0($t9)
		bltz $t2, Label0
		nop
		li $v0, 4
		la $a0, Str4
		syscall
		li $v1, 2
		addi $t9, $sp, 20
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 12
		sw $v1, 0($t9)
Label7:	
		lw $v1, 20($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		li $v1, 2
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		addi $t9, $sp, 16
		sw $t0, 0($t9)
Label8:	
		lw $v1, 20($sp)
		lw $t9, 40($sp)
		div $t0, $v1, $t9
		lw $t9, 40($sp)
		mul $t1, $t0, $t9
		lw $t9, 20($sp)
		sub $t2, $t1, $t9
		addi $t9, $sp, 4
		sw $t1, 0($t9)
		bnez $t2, Label9
		nop
		li $v1, 0
		addi $t9, $sp, 8
		sw $v1, 0($t9)
Label9:	
		lw $v1, 40($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		lw $t9, 16($sp)
		sub $t2, $t1, $t9
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		blez $t2, Label8
		nop
		lw $v1, 8($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bnez $t0, Label10
		nop
		li $v0, 4
		la $a0, Str5
		syscall
		lw $t8, 20($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		lw $v1, 12($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		li $t9, 10
		div $t2, $t1, $t9
		li $t9, 10
		mul $t3, $t2, $t9
		sub $t4, $t3, $t1
		addi $t9, $sp, 4
		sw $t3, 0($t9)
		addi $t9, $sp, 12
		sw $t1, 0($t9)
		bnez $t4, Label11
		nop
		li $v0, 4
		la $a0, Str6
		syscall
Label11:	
Label10:	
		lw $v1, 20($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		la $t9, max_num
		lw $t9, 0($t9)
		sub $t2, $t1, $t9
		addi $t9, $sp, 20
		sw $t1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		blez $t2, Label7
		nop
		li $v0, 4
		la $a0, Str7
		syscall
		lw $t8, 12($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		move $sp, $fp
		lw $ra, 4144($sp)
		lw $fp, 4140($sp)
		addi $sp, $sp, 4148
		jr $ra
		nop
main:	
		addi $sp, $sp, -44
		sw $ra, 40($sp)
		sw $fp, 36($sp)
		move $fp, $sp
		jal complete_num
		nop
