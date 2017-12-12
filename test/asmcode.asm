		.data
		Str0:  .asciiz "Error1 \n"
		Str1:  .asciiz "Error2 \n"
		Str2:  .asciiz "Error3 \n"
		Str3:  .asciiz "The number is so small!\n"
		Str4:  .asciiz "Please check your letter.\n"
		Str5:  .asciiz "Please check your letter.\n"
		Str6:  .asciiz "Please check your letter.\n"
		Str7:  .asciiz "Please check your letter.\n"
		Str8:  .asciiz "Test do-while\n"
		Str9:  .asciiz "#Result of do-while is \n"
		Str10:  .asciiz "Test fibonacci\n"
		Str11:  .asciiz "#Result of fibonacci is \n"
		Str12:  .asciiz "Test relation operation\n"
		Str13:  .asciiz "a1 should be 0:\n"
		Str14:  .asciiz "a1 shouldn't be 0:\n"
		Str15:  .asciiz "a1 should beq 32:\n"
		Str16:  .asciiz "#Result of relation operation ends\n"
		Str17:  .asciiz "Test (void function&switch int)\n"
		Str18:  .asciiz "#Result of (void function&switch int) ends\n"
		Str19:  .asciiz "Test expression\n"
		Str20:  .asciiz "a should be 9:\n"
		Str21:  .asciiz "a should be 14:\n"
		Str22:  .asciiz "d1[1] should be 17:\n"
		Str23:  .asciiz "#Result of expression ends\n"
		Str24:  .asciiz "Test switch char\n"
		Str25:  .asciiz "\n"
		Str26:  .asciiz "#Result of switch char should be A-/\n"
		Str27:  .asciiz "Test print char\n"
		Str28:  .asciiz "1.\n"
		Str29:  .asciiz "2.\n"
		Str30:  .asciiz "3.\n"
		Str31:  .asciiz "4.\n"
		Str32:  .asciiz "\n"
		Str33:  .asciiz "#Result of print char ends\n"
		Str34:  .asciiz "Test multi-parameters\n"
		Str35:  .asciiz "#Result of multi-parameters ends\n"
		Str36:  .asciiz "Test single sentence\n"
		Str37:  .asciiz "test0\n"
		Str38:  .asciiz "#Result of single sentence ends\n"
		Str39:  .asciiz "Test convertion of char and int\n"
		Str40:  .asciiz "#Result of convertion of char and int ends\n"

		_:  .word 0
		void1:  .word 0
		int1:  .word 1
		int2:  .word 2
		char1:  .word 49
		charz:  .word 90
		char9:  .word 57
		a:  .word 0
		b:  .word 0
		c:  .space 20
		single:  .word 0
		d:  .word 0
		e:  .space 36
		default:  .word 0

		.text
		.globl main
null:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
print_error:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		lw $v1, 12($sp)
		bne $v1, 1, Label1
		nop
		li $v0, 4
		la $a0, Str0
		syscall
		lw $t8, 12($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		j Label0
		nop
Label1:	
		lw $v1, 12($sp)
		bne $v1, 2, Label2
		nop
		li $v0, 4
		la $a0, Str1
		syscall
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		j Label0
		nop
Label2:	
		lw $v1, 12($sp)
		bne $v1, 3, Label3
		nop
		lw $v1, 12($sp)
		li $t9, 1
		mul $t0, $v1, $t9
		li $v0, 4
		la $a0, Str2
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j Label0
		nop
Label3:	
		lw $v1, 12($sp)
		bne $v1, 4, Label4
		nop
		j Label0
		nop
Label4:	
Label0:	
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
fibonacci:	
		addi $sp, $sp, -84
		sw $ra, 80($sp)
		sw $fp, 76($sp)
		move $fp, $sp
		sw $a0, 84($sp)
		li $v1, 49
		sw $v1, 72($sp)
		li $v1, 0
		addi $t9, $sp, 68
		sw $v1, 0($t9)
		lw $v1, 84($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgez $t0, Label5
		nop
		li $v0, 4
		la $a0, Str3
		syscall
		li $v1, 1
		sub $t0, $0, $v1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 80($sp)
		lw $fp, 76($sp)
		addi $sp, $sp, 84
		jr $ra
		nop
Label5:	
		lw $v1, 84($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bgtz $t0, Label6
		nop
		lw $t8, 84($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 80($sp)
		lw $fp, 76($sp)
		addi $sp, $sp, 84
		jr $ra
		nop
Label6:	
		li $v1, 1
		sub $t0, $0, $v1
		sub $t1, $0, $t0
		lw $v1, 84($sp)
		sub $t2, $v1, $t1
		blez $t2, Label7
		nop
		lw $v1, 84($sp)
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
		mul $t3, $t1, $t2
		li $v1, 16
		sub $t4, $0, $v1
		li $v1, 17
		add $t5, $v1, $t4
		mul $t6, $t3, $t5
		li $t9, 0
		add $t7, $t6, $t9
		lw $v1, 84($sp)
		li $t9, 0
		la $t8, default
		sw $t0, 4($t8)
		add $t0, $v1, $t9
		li $t9, 1
		la $t8, default
		sw $t1, 8($t8)
		mul $t1, $t0, $t9
		li $v1, 20
		li $t9, 19
		la $t8, default
		sw $t2, 12($t8)
		sub $t2, $v1, $t9
		la $t8, default
		sw $t3, 16($t8)
		div $t3, $t1, $t2
		li $t9, 4
		la $t8, default
		sw $t4, 20($t8)
		add $t4, $t3, $t9
		li $t9, 2
		la $t8, default
		sw $t5, 24($t8)
		sub $t5, $t4, $t9
		li $t9, 4
		la $t8, default
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
		la $v1, default
		lw $t8, 4($v1)
		sw $t8, 32($sp)
		la $v1, default
		lw $t8, 8($v1)
		sw $t8, 28($sp)
		la $v1, default
		lw $t8, 12($v1)
		sw $t8, 24($sp)
		la $v1, default
		lw $t8, 16($v1)
		sw $t8, 20($sp)
		la $v1, default
		lw $t8, 20($v1)
		sw $t8, 16($sp)
		la $v1, default
		lw $t8, 24($v1)
		sw $t8, 12($sp)
		la $v1, default
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
		la $v1, default
		sw $t8, 4($v1)
		lw $t8, 28($sp)
		la $v1, default
		sw $t8, 8($v1)
		lw $t8, 24($sp)
		la $v1, default
		sw $t8, 12($v1)
		lw $t8, 20($sp)
		la $v1, default
		sw $t8, 16($v1)
		lw $t8, 16($sp)
		la $v1, default
		sw $t8, 20($v1)
		lw $t8, 12($sp)
		la $v1, default
		sw $t8, 24($v1)
		lw $t8, 8($sp)
		la $v1, default
		sw $t8, 28($v1)
		la $t8, default
		sw $t7, 32($t8)
		move $t7, $v0
		li $v1, 1
		la $t8, default
		sw $t0, 36($t8)
		mul $t0, $v1, $t7
		li $v1, 20
		li $t9, 19
		la $t8, default
		sw $t1, 40($t8)
		sub $t1, $v1, $t9
		la $t8, default
		sw $t2, 44($t8)
		div $t2, $t0, $t1
		li $v1, 16
		la $t8, default
		sw $t3, 48($t8)
		sub $t3, $0, $v1
		li $v1, 17
		la $t8, default
		sw $t4, 52($t8)
		add $t4, $v1, $t3
		la $t8, default
		sw $t5, 56($t8)
		mul $t5, $t2, $t4
		la $v1, default
		lw $v1, 32($v1)
		la $t8, default
		sw $t6, 60($t8)
		add $t6, $v1, $t5
		move $v0, $t6
		move $sp, $fp
		lw $ra, 80($sp)
		lw $fp, 76($sp)
		addi $sp, $sp, 84
		jr $ra
		nop
Label7:	
mult_add:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		sw $a2, 20($sp)
		lw $v1, 12($sp)
		lw $t9, 16($sp)
		add $t0, $v1, $t9
		lw $t9, 20($sp)
		sub $t1, $t0, $t9
		move $v0, $t1
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
tolower:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		lw $v1, 12($sp)
		li $t9, 65
		sub $t0, $v1, $t9
		bgez $t0, Label8
		nop
		li $v0, 4
		la $a0, Str4
		syscall
		li $t8, 42
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label8:	
		lw $v1, 12($sp)
		li $t9, 90
		sub $t0, $v1, $t9
		blez $t0, Label9
		nop
		li $v0, 4
		la $a0, Str5
		syscall
		li $v1, -47
		sub $t0, $0, $v1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label9:	
		lw $v1, 12($sp)
		li $t9, 32
		add $t0, $v1, $t9
		addi $t9, $sp, 12
		sw $t0, 0($t9)
		lw $t8, 12($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
toupper:	
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		move $fp, $sp
		sw $a0, 16($sp)
		li $v1, 43
		li $t9, 0
		sub $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		lw $v1, 16($sp)
		li $t9, 122
		sub $t0, $v1, $t9
		blez $t0, Label10
		nop
		li $v0, 4
		la $a0, Str6
		syscall
		li $t8, 45
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label10:	
		lw $v1, 16($sp)
		li $t9, 97
		sub $t0, $v1, $t9
		bgez $t0, Label11
		nop
		li $v0, 4
		la $a0, Str7
		syscall
		lw $t8, 4($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label11:	
		lw $v1, 16($sp)
		li $t9, 32
		sub $t0, $v1, $t9
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
main:	
		addi $sp, $sp, -120
		sw $ra, 116($sp)
		sw $fp, 112($sp)
		move $fp, $sp
		li $v1, 42
		sw $v1, 108($sp)
		li $v1, 42
		sw $v1, 104($sp)
		li $v1, 1
		addi $t9, $sp, 72
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 100
		sw $v1, 0($t9)
		li $v1, 2
		addi $t9, $sp, 96
		sw $v1, 0($t9)
		li $v1, 0
		sub $t0, $0, $v1
		addi $t9, $sp, 68
		sw $t0, 0($t9)
		lw $v1, 72($sp)
		addi $t9, $sp, 68
		sw $v1, 0($t9)
		la $v1, _
		lw $v1, 0($v1)
		la $t9, _
		lw $t9, 0($t9)
		add $t0, $v1, $t9
		li $v1, 3
		addi $t9, $sp, 76
		mulu $t0, $t0, 4
		add $t9, $t9, $t0
		sw $v1, 0($t9)
		li $v1, 2
		sub $t0, $0, $v1
		addi $t9, $sp, 76
		addi $t9, $t9, 4
		sw $t0, 0($t9)
		li $v1, 65
		addi $t9, $sp, 44
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		li $v1, 45
		addi $t9, $sp, 44
		addi $t9, $t9, 4
		sw $v1, 0($t9)
		li $v1, 3
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		sub $t1, $t0, $t9
		li $v1, 47
		addi $t9, $sp, 44
		mulu $t1, $t1, 4
		add $t9, $t9, $t1
		sw $v1, 0($t9)
		li $v0, 4
		la $a0, Str8
		syscall
		li $v0, 5
		syscall
		sw $v0, 92($sp)
		li $v0, 5
		syscall
		sw $v0, 88($sp)
Label12:	
		lw $v1, 92($sp)
		lw $t9, 88($sp)
		add $t0, $v1, $t9
		lw $v1, 72($sp)
		mul $t1, $v1, $t0
		addi $t9, $sp, 72
		sw $t1, 0($t9)
		lw $v1, 68($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 68
		sw $t0, 0($t9)
		lw $v1, 68($sp)
		li $t9, 4
		sub $t0, $v1, $t9
		bltz $t0, Label12
		nop
		li $v0, 4
		la $a0, Str9
		syscall
		lw $t8, 72($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str10
		syscall
		li $v0, 5
		syscall
		sw $v0, 92($sp)
		lw $t8, 92($sp)
		move $a0, $t8
		jal fibonacci
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str11
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str12
		syscall
		li $v0, 5
		syscall
		sw $v0, 92($sp)
		lw $v1, 92($sp)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		bnez $t0, Label13
		nop
		li $v0, 4
		la $a0, Str13
		syscall
		lw $t8, 92($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label13:	
		lw $v1, 92($sp)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		beqz $t0, Label14
		nop
		li $v0, 4
		la $a0, Str14
		syscall
		lw $t8, 92($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label14:	
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		lw $v1, 92($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label15
		nop
		li $v0, 4
		la $a0, Str15
		syscall
		lw $t8, 92($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label15:	
		li $v0, 4
		la $a0, Str16
		syscall
		li $v0, 4
		la $a0, Str17
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		li $v0, 5
		syscall
		sw $v0, 84($sp)
		la $t8, a
		lw $t8, 0($t8)
		move $a0, $t8
		jal print_error
		nop
		jal null
		nop
		lw $t8, 88($sp)
		move $a0, $t8
		jal print_error
		nop
		lw $t8, 84($sp)
		move $a0, $t8
		jal print_error
		nop
		li $a0, 4
		jal print_error
		nop
		li $v0, 4
		la $a0, Str18
		syscall
		li $v0, 4
		la $a0, Str19
		syscall
		addi $v1, $sp, 76
		lw $t0, 4($v1)
		addi $v1, $sp, 76
		lw $t1, 4($v1)
		li $t9, 2
		add $t2, $t1, $t9
		li $v1, 12
		sub $t3, $0, $v1
		mul $t4, $t2, $t3
		la $t9, _
		lw $t9, 0($t9)
		add $t5, $t4, $t9
		addi $v1, $sp, 76
		mulu $t9, $t5, 4
		add $v1, $v1, $t9
		lw $t6, 0($v1)
		mul $t7, $t0, $t6
		la $t8, default
		sw $t7, 4($t8)
		sub $t7, $0, $t7
		addi $v1, $sp, 76
		la $t8, default
		sw $t0, 8($t8)
		lw $t0, 0($v1)
		la $t8, default
		sw $t1, 12($t8)
		add $t1, $t7, $t0
		la $t9, _
		lw $t9, 0($t9)
		la $t8, default
		sw $t2, 16($t8)
		sub $t2, $t1, $t9
		la $t9, a
		sw $t2, 0($t9)
		li $v0, 4
		la $a0, Str20
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
		la $a0, Str21
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		addi $v1, $sp, 76
		lw $t0, 4($v1)
		li $t9, 2
		add $t1, $t0, $t9
		li $v1, 12
		sub $t2, $0, $v1
		mul $t3, $t1, $t2
		la $t9, _
		lw $t9, 0($t9)
		add $t4, $t3, $t9
		li $v1, 17
		li $t9, -16
		add $t5, $v1, $t9
		add $t6, $t4, $t5
		li $t9, 1
		sub $t7, $t6, $t9
		li $v1, 17
		addi $t9, $sp, 76
		mulu $t7, $t7, 4
		add $t9, $t9, $t7
		sw $v1, 0($t9)
		addi $v1, $sp, 76
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str22
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str23
		syscall
		li $v0, 4
		la $a0, Str24
		syscall
		li $v1, 0
		addi $t9, $sp, 68
		sw $v1, 0($t9)
Label16:	
		addi $v1, $sp, 44
		lw $t9, 68($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		bne $t0, 65, Label18
		nop
		addi $v1, $sp, 44
		lw $t9, 68($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label18:	
		bne $t0, 45, Label19
		nop
		addi $v1, $sp, 44
		lw $t9, 68($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str25
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label19:	
		bne $t0, 47, Label20
		nop
		addi $v1, $sp, 44
		lw $t9, 68($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label20:	
Label17:	
		lw $v1, 68($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 68
		sw $t0, 0($t9)
		lw $v1, 68($sp)
		li $t9, 3
		sub $t0, $v1, $t9
		bltz $t0, Label16
		nop
		li $v0, 4
		la $a0, Str26
		syscall
		li $v0, 4
		la $a0, Str27
		syscall
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		li $v0, 4
		la $a0, Str28
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v1, 97
		li $t9, 1
		add $t0, $v1, $t9
		li $t9, 98
		sub $t1, $t0, $t9
		li $v0, 4
		la $a0, Str29
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 4
		la $a0, Str30
		syscall
		li $t8, 97
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str31
		syscall
		la $t8, charz
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str32
		syscall
		li $v0, 4
		la $a0, Str33
		syscall
		li $v0, 4
		la $a0, Str34
		syscall
		lw $v1, 108($sp)
		lw $t9, 104($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label21
		nop
		lw $t8, 108($sp)
		beqz $t8, Label22
		nop
		la $t8, int1
		lw $t8, 0($t8)
		move $a0, $t8
		la $t8, char1
		lw $t8, 0($t8)
		move $a1, $t8
		addi $v1, $sp, 76
		lw $t0, 4($v1)
		move $a2, $t0
		sw $t0, 40($sp)
		jal mult_add
		nop
		lw $t0, 40($sp)
		move $t1, $v0
		li $v0, 1
		move $a0, $t1
		syscall
Label22:	
Label21:	
		li $a0, 64
		li $a1, 97
		li $v1, 1
		sub $t0, $0, $v1
		li $v1, 57
		li $t9, 2
		mul $t1, $v1, $t9
		add $t2, $t0, $t1
		move $a2, $t2
		sw $t0, 40($sp)
		sw $t1, 36($sp)
		sw $t2, 32($sp)
		jal mult_add
		nop
		lw $t0, 40($sp)
		lw $t1, 36($sp)
		lw $t2, 32($sp)
		move $t3, $v0
		li $v0, 1
		move $a0, $t3
		syscall
		li $v0, 5
		syscall
		sw $v0, 92($sp)
		li $v0, 5
		syscall
		la $v1, single
		sw $v0, 0($v1)
		li $v0, 12
		syscall
		la $v1, default
		sw $v0, 0($v1)
		lw $t8, 92($sp)
		move $a0, $t8
		la $t8, default
		lw $t8, 0($t8)
		move $a1, $t8
		la $t8, single
		lw $t8, 0($t8)
		move $a2, $t8
		jal mult_add
		nop
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str35
		syscall
		li $v0, 4
		la $a0, Str36
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
Label23:	
		la $t8, a
		lw $t8, 0($t8)
		beqz $t8, Label24
		nop
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 1
		add $t0, $v1, $t9
		la $t9, a
		sw $t0, 0($t9)
Label24:	
		lw $v1, 108($sp)
		lw $t9, 104($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label23
		nop
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
Label25:	
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 0
		sub $t0, $v1, $t9
		bne $t0, 0, Label27
		nop
		li $v0, 4
		la $a0, Str37
		syscall
		j Label26
		nop
Label27:	
Label26:	
		li $v1, -1
		sub $t0, $0, $v1
		addi $v1, $sp, 76
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		sub $t2, $0, $t1
		li $t9, 9
		add $t3, $t2, $t9
		li $t9, -11
		add $t4, $t3, $t9
		bnez $t4, Label25
		nop
		li $v0, 4
		la $a0, Str38
		syscall
		li $v0, 4
		la $a0, Str39
		syscall
		li $a0, 97
		jal toupper
		nop
		move $t0, $v0
		li $v0, 11
		move $a0, $t0
		syscall
		li $a0, 97
		jal toupper
		nop
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		li $a0, 65
		jal tolower
		nop
		move $t0, $v0
		li $v0, 11
		move $a0, $t0
		syscall
		li $a0, 65
		jal tolower
		nop
		move $t0, $v0
		sub $t1, $0, $t0
		li $v0, 1
		move $a0, $t1
		syscall
		li $a0, 97
		jal toupper
		nop
		move $t0, $v0
		li $a0, 65
		sw $t0, 40($sp)
		jal tolower
		nop
		lw $t0, 40($sp)
		move $t1, $v0
		sub $t2, $t0, $t1
		li $v0, 1
		move $a0, $t2
		syscall
		li $v0, 4
		la $a0, Str40
		syscall
		lw $v1, 96($sp)
		lw $t9, 100($sp)
		add $t0, $v1, $t9
		li $v0, 1
		move $a0, $t0
		syscall
