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
		lw $s0, 40($sp)
		lw $s1, 36($sp)
		lw $s2, 20($sp)
		lw $s3, 32($sp)
		lw $s4, 28($sp)
		lw $s5, 8($sp)
		lw $s6, 12($sp)
		lw $s7, 16($sp)
		li $v1, 2
		move $s1, $v1
		addi $t9, $sp, 36
		sw $v1, 0($t9)
Label0:	
		li $v1, 1
		sub $t0, $0, $v1
		li $v1, 1
		move $s0, $v1
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		move $s4, $s1
		addi $t9, $sp, 28
		sw $s1, 0($t9)
		move $s3, $t0
		addi $t9, $sp, 32
		sw $t0, 0($t9)
Label1:	
		div $t0, $s1, $s0
		mul $t1, $t0, $s0
		sub $t2, $t1, $s1
		addi $t9, $sp, 24
		sw $t1, 0($t9)
		bnez $t2, Label2
		nop
		li $t9, 0
		add $t0, $s3, $t9
		li $t9, 0
		add $t1, $s4, $t9
		sub $t2, $t1, $s0
		li $t9, 1
		add $t3, $t0, $t9
		li $t9, 1024
		sub $t4, $t3, $t9
		move $s4, $t2
		addi $t9, $sp, 28
		sw $t2, 0($t9)
		move $s3, $t3
		addi $t9, $sp, 32
		sw $t3, 0($t9)
		bltz $t4, Label3
		nop
		li $v0, 4
		la $a0, Str0
		syscall
Label3:	
		li $t9, 1024
		sub $t0, $s3, $t9
		bgez $t0, Label4
		nop
		addi $t9, $sp, 44
		move $t8, $s3
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $s0, 0($t9)
Label4:	
Label2:	
		li $t9, 0
		add $t0, $s0, $t9
		li $t9, 1
		add $t1, $t0, $t9
		sub $t2, $t1, $s1
		move $s0, $t1
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		bltz $t2, Label1
		nop
		li $t9, 0
		sub $t0, $s4, $t9
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
		move $s0, $v1
		addi $t9, $sp, 40
		sw $v1, 0($t9)
Label6:	
		addi $v1, $sp, 44
		mulu $t9, $s0, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str2
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $t9, 0
		add $t0, $s0, $t9
		li $t9, 1
		add $t1, $t0, $t9
		sub $t2, $t1, $s3
		move $s0, $t1
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		blez $t2, Label6
		nop
		li $v0, 4
		la $a0, Str3
		syscall
Label5:	
		li $t9, 0
		add $t0, $s1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		la $t9, max_num
		lw $t9, 0($t9)
		sub $t2, $t1, $t9
		move $s1, $t1
		addi $t9, $sp, 36
		sw $t1, 0($t9)
		bltz $t2, Label0
		nop
		li $v0, 4
		la $a0, Str4
		syscall
		li $v1, 2
		move $s2, $v1
		addi $t9, $sp, 20
		sw $v1, 0($t9)
		li $v1, 1
		move $s5, $v1
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 0
		move $s6, $v1
		addi $t9, $sp, 12
		sw $v1, 0($t9)
Label7:	
		li $t9, 1
		sub $t0, $s2, $t9
		li $v1, 2
		move $s0, $v1
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		move $s7, $t0
		addi $t9, $sp, 16
		sw $t0, 0($t9)
Label8:	
		div $t0, $s2, $s0
		mul $t1, $t0, $s0
		sub $t2, $t1, $s2
		addi $t9, $sp, 4
		sw $t1, 0($t9)
		bnez $t2, Label9
		nop
		li $v1, 0
		move $s5, $v1
		addi $t9, $sp, 8
		sw $v1, 0($t9)
Label9:	
		li $t9, 0
		add $t0, $s0, $t9
		li $t9, 1
		add $t1, $t0, $t9
		sub $t2, $t1, $s7
		move $s0, $t1
		addi $t9, $sp, 40
		sw $t1, 0($t9)
		blez $t2, Label8
		nop
		li $t9, 1
		sub $t0, $s5, $t9
		bnez $t0, Label10
		nop
		li $v0, 4
		la $a0, Str5
		syscall
		lw $t8, 20($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $t9, 0
		add $t0, $s6, $t9
		li $t9, 1
		add $t1, $t0, $t9
		li $t9, 10
		div $t2, $t1, $t9
		li $t9, 10
		mul $t3, $t2, $t9
		sub $t4, $t3, $t1
		addi $t9, $sp, 4
		sw $t3, 0($t9)
		move $s6, $t1
		addi $t9, $sp, 12
		sw $t1, 0($t9)
		bnez $t4, Label11
		nop
		li $v0, 4
		la $a0, Str6
		syscall
Label11:	
Label10:	
		li $t9, 0
		add $t0, $s2, $t9
		li $t9, 1
		add $t1, $t0, $t9
		la $t9, max_num
		lw $t9, 0($t9)
		sub $t2, $t1, $t9
		move $s2, $t1
		addi $t9, $sp, 20
		sw $t1, 0($t9)
		li $v1, 1
		move $s5, $v1
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
