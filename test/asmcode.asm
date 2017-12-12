		.data
		Str0:  .asciiz "Error1 \n"
		Str1:  .asciiz "Error2 \n"
		Str2:  .asciiz "Error1 \n"
		Str3:  .asciiz "Error2 \n"
		Str4:  .asciiz "Error3 \n"
		Str5:  .asciiz "The number is so small!\n"
		Str6:  .asciiz "Please check your letter.\n"
		Str7:  .asciiz "Please check your letter.\n"
		Str8:  .asciiz "Please check your letter.\n"
		Str9:  .asciiz "Please check your letter.\n"
		Str10:  .asciiz "Test do-while\n"
		Str11:  .asciiz "#Result of do-while is \n"
		Str12:  .asciiz "Test fibonacci\n"
		Str13:  .asciiz "#Result of fibonacci is \n"
		Str14:  .asciiz "Test relation operation\n"
		Str15:  .asciiz "a1 should be 0:\n"
		Str16:  .asciiz "a1 shouldn't be 0:\n"
		Str17:  .asciiz "a1 should beq 32:\n"
		Str18:  .asciiz "#Result of relation operation ends\n"
		Str19:  .asciiz "Test (void function&switch int)\n"
		Str20:  .asciiz "#Result of (void function&switch int) ends\n"
		Str21:  .asciiz "Test expression\n"
		Str22:  .asciiz "a should be 9:\n"
		Str23:  .asciiz "a should be 14:\n"
		Str24:  .asciiz "d1[1] should be 17:\n"
		Str25:  .asciiz "#Result of expression ends\n"
		Str26:  .asciiz "Test switch char\n"
		Str27:  .asciiz "\n"
		Str28:  .asciiz "#Result of switch char should be A-/\n"
		Str29:  .asciiz "Test print char\n"
		Str30:  .asciiz "1.\n"
		Str31:  .asciiz "2.\n"
		Str32:  .asciiz "3.\n"
		Str33:  .asciiz "4.\n"
		Str34:  .asciiz "\n"
		Str35:  .asciiz "#Result of print char ends\n"
		Str36:  .asciiz "Test multi-parameters\n"
		Str37:  .asciiz "#Result of multi-parameters ends\n"
		Str38:  .asciiz "Test single sentence\n"
		Str39:  .asciiz "test0\n"
		Str40:  .asciiz "#Result of single sentence ends\n"
		Str41:  .asciiz "Test convertion of char and int\n"
		Str42:  .asciiz "#Result of convertion of char and int ends\n"

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
		bne $v1, 1, Label5
		nop
		li $v0, 4
		la $a0, Str2
		syscall
		lw $t8, 12($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		j Label4
		nop
Label5:	
		lw $v1, 12($sp)
		bne $v1, 2, Label6
		nop
		li $v0, 4
		la $a0, Str3
		syscall
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		j Label4
		nop
Label6:	
		lw $v1, 12($sp)
		bne $v1, 3, Label7
		nop
		lw $v1, 12($sp)
		li $t9, 1
		mul $t0, $v1, $t9
		li $v0, 4
		la $a0, Str4
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j Label4
		nop
Label7:	
		lw $v1, 12($sp)
		bne $v1, 4, Label8
		nop
		j Label4
		nop
Label8:	
Label4:	
		j Label0
		nop
Label3:	
		lw $v1, 12($sp)
		bne $v1, 4, Label9
		nop
		j Label0
		nop
Label9:	
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
		bgez $t0, Label10
		nop
		li $v0, 4
		la $a0, Str5
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
Label10:	
		lw $v1, 84($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bgtz $t0, Label11
		nop
		lw $t8, 84($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 80($sp)
		lw $fp, 76($sp)
		addi $sp, $sp, 84
		jr $ra
		nop
Label11:	
		li $v1, 1
		sub $t0, $0, $v1
		sub $t1, $0, $t0
		lw $v1, 84($sp)
		sub $t2, $v1, $t1
		blez $t2, Label12
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
Label12:	
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
		bgez $t0, Label13
		nop
		li $v0, 4
		la $a0, Str6
		syscall
		li $t8, 42
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label13:	
		lw $v1, 12($sp)
		li $t9, 90
		sub $t0, $v1, $t9
		blez $t0, Label14
		nop
		li $v0, 4
		la $a0, Str7
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
Label14:	
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
		blez $t0, Label15
		nop
		li $v0, 4
		la $a0, Str8
		syscall
		li $t8, 45
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label15:	
		lw $v1, 16($sp)
		li $t9, 97
		sub $t0, $v1, $t9
		bgez $t0, Label16
		nop
		li $v0, 4
		la $a0, Str9
		syscall
		lw $t8, 4($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label16:	
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
		addi $sp, $sp, -116
		sw $ra, 112($sp)
		sw $fp, 108($sp)
		move $fp, $sp
		li $v1, 42
		sw $v1, 104($sp)
		li $v1, 42
		sw $v1, 100($sp)
		li $v1, 1
		addi $t9, $sp, 68
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 96
		sw $v1, 0($t9)
		li $v1, 2
		addi $t9, $sp, 92
		sw $v1, 0($t9)
		li $v1, 0
		sub $t0, $0, $v1
		addi $t9, $sp, 64
		sw $t0, 0($t9)
		lw $v1, 68($sp)
		addi $t9, $sp, 64
		sw $v1, 0($t9)
		la $v1, _
		lw $v1, 0($v1)
		la $t9, _
		lw $t9, 0($t9)
		add $t0, $v1, $t9
		li $v1, 3
		addi $t9, $sp, 72
		mulu $t0, $t0, 4
		add $t9, $t9, $t0
		sw $v1, 0($t9)
		li $v1, 2
		sub $t0, $0, $v1
		addi $t9, $sp, 72
		addi $t9, $t9, 4
		sw $t0, 0($t9)
		li $v1, 65
		addi $t9, $sp, 40
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		li $v1, 45
		addi $t9, $sp, 40
		addi $t9, $t9, 4
		sw $v1, 0($t9)
		li $v1, 3
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		sub $t1, $t0, $t9
		li $v1, 47
		addi $t9, $sp, 40
		mulu $t1, $t1, 4
		add $t9, $t9, $t1
		sw $v1, 0($t9)
		li $v0, 4
		la $a0, Str10
		syscall
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		li $v0, 5
		syscall
		sw $v0, 84($sp)
Label17:	
		lw $v1, 88($sp)
		lw $t9, 84($sp)
		add $t0, $v1, $t9
		lw $v1, 68($sp)
		mul $t1, $v1, $t0
		addi $t9, $sp, 68
		sw $t1, 0($t9)
		lw $v1, 64($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 64
		sw $t0, 0($t9)
		lw $v1, 64($sp)
		li $t9, 4
		sub $t0, $v1, $t9
		bltz $t0, Label17
		nop
		li $v0, 4
		la $a0, Str11
		syscall
		lw $t8, 68($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str12
		syscall
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		lw $t8, 88($sp)
		move $a0, $t8
		jal fibonacci
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str13
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str14
		syscall
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		lw $v1, 88($sp)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		bnez $t0, Label18
		nop
		li $v0, 4
		la $a0, Str15
		syscall
		lw $t8, 88($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label18:	
		lw $v1, 88($sp)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		beqz $t0, Label19
		nop
		li $v0, 4
		la $a0, Str16
		syscall
		lw $t8, 88($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label19:	
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		lw $v1, 88($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label20
		nop
		li $v0, 4
		la $a0, Str17
		syscall
		lw $t8, 88($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label20:	
		li $v0, 4
		la $a0, Str18
		syscall
		li $v0, 4
		la $a0, Str19
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		sw $v0, 84($sp)
		li $v0, 5
		syscall
		sw $v0, 80($sp)
		la $t8, a
		lw $t8, 0($t8)
		move $a0, $t8
		jal print_error
		nop
		jal null
		nop
		lw $t8, 84($sp)
		move $a0, $t8
		jal print_error
		nop
		lw $t8, 80($sp)
		move $a0, $t8
		jal print_error
		nop
		li $a0, 4
		jal print_error
		nop
		li $v0, 4
		la $a0, Str20
		syscall
		li $v0, 4
		la $a0, Str21
		syscall
		addi $v1, $sp, 72
		lw $t0, 4($v1)
		addi $v1, $sp, 72
		lw $t1, 4($v1)
		li $t9, 2
		add $t2, $t1, $t9
		li $v1, 12
		sub $t3, $0, $v1
		mul $t4, $t2, $t3
		la $t9, _
		lw $t9, 0($t9)
		add $t5, $t4, $t9
		addi $v1, $sp, 72
		mulu $t9, $t5, 4
		add $v1, $v1, $t9
		lw $t6, 0($v1)
		mul $t7, $t0, $t6
		la $t8, default
		sw $t7, 4($t8)
		sub $t7, $0, $t7
		addi $v1, $sp, 72
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
		la $a0, Str22
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
		la $a0, Str23
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		addi $v1, $sp, 72
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
		addi $t9, $sp, 72
		mulu $t7, $t7, 4
		add $t9, $t9, $t7
		sw $v1, 0($t9)
		addi $v1, $sp, 72
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str24
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str25
		syscall
		li $v0, 4
		la $a0, Str26
		syscall
		li $v1, 0
		addi $t9, $sp, 64
		sw $v1, 0($t9)
Label21:	
		addi $v1, $sp, 40
		lw $t9, 64($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		bne $t0, 65, Label23
		nop
		addi $v1, $sp, 40
		lw $t9, 64($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label22
		nop
Label23:	
		bne $t0, 45, Label24
		nop
		addi $v1, $sp, 40
		lw $t9, 64($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str27
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j Label22
		nop
Label24:	
		bne $t0, 47, Label25
		nop
		addi $v1, $sp, 40
		lw $t9, 64($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label22
		nop
Label25:	
Label22:	
		lw $v1, 64($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 64
		sw $t0, 0($t9)
		lw $v1, 64($sp)
		li $t9, 3
		sub $t0, $v1, $t9
		bltz $t0, Label21
		nop
		li $v0, 4
		la $a0, Str28
		syscall
		li $v0, 4
		la $a0, Str29
		syscall
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		li $v0, 4
		la $a0, Str30
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
		la $a0, Str31
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 4
		la $a0, Str32
		syscall
		li $t8, 97
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str33
		syscall
		la $t8, charz
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str34
		syscall
		li $v0, 4
		la $a0, Str35
		syscall
		li $v0, 4
		la $a0, Str36
		syscall
		lw $v1, 104($sp)
		lw $t9, 100($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label26
		nop
		lw $t8, 104($sp)
		beqz $t8, Label27
		nop
		addi $v1, $sp, 72
		lw $t0, 4($v1)
		la $t8, int1
		lw $t8, 0($t8)
		move $a0, $t8
		la $t8, char1
		lw $t8, 0($t8)
		move $a1, $t8
		move $a2, $t0
		sw $t0, 36($sp)
		jal mult_add
		nop
		lw $t0, 36($sp)
		move $t1, $v0
		li $v0, 1
		move $a0, $t1
		syscall
Label27:	
Label26:	
		li $v1, 1
		sub $t0, $0, $v1
		li $v1, 57
		li $t9, 2
		mul $t1, $v1, $t9
		add $t2, $t0, $t1
		li $a0, 64
		li $a1, 97
		move $a2, $t2
		sw $t0, 36($sp)
		sw $t1, 32($sp)
		sw $t2, 28($sp)
		jal mult_add
		nop
		lw $t0, 36($sp)
		lw $t1, 32($sp)
		lw $t2, 28($sp)
		move $t3, $v0
		li $v0, 1
		move $a0, $t3
		syscall
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		li $v0, 5
		syscall
		la $v1, single
		sw $v0, 0($v1)
		li $v0, 12
		syscall
		la $v1, default
		sw $v0, 0($v1)
		lw $t8, 88($sp)
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
		la $a0, Str37
		syscall
		li $v0, 4
		la $a0, Str38
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
Label28:	
		la $t8, a
		lw $t8, 0($t8)
		beqz $t8, Label29
		nop
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 1
		add $t0, $v1, $t9
		la $t9, a
		sw $t0, 0($t9)
Label29:	
		lw $v1, 104($sp)
		lw $t9, 100($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label28
		nop
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
Label30:	
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 0
		sub $t0, $v1, $t9
		bne $t0, 0, Label32
		nop
		li $v0, 4
		la $a0, Str39
		syscall
		j Label31
		nop
Label32:	
Label31:	
		li $v1, -1
		sub $t0, $0, $v1
		addi $v1, $sp, 72
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		sub $t2, $0, $t1
		li $t9, 9
		add $t3, $t2, $t9
		li $t9, -11
		add $t4, $t3, $t9
		bnez $t4, Label30
		nop
		li $v0, 4
		la $a0, Str40
		syscall
		li $v0, 4
		la $a0, Str41
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
		sw $t0, 36($sp)
		jal tolower
		nop
		lw $t0, 36($sp)
		move $t1, $v0
		sub $t2, $t0, $t1
		li $v0, 1
		move $a0, $t2
		syscall
		li $v0, 4
		la $a0, Str42
		syscall
		lw $v1, 92($sp)
		lw $t9, 96($sp)
		add $t0, $v1, $t9
		li $v0, 1
		move $a0, $t0
		syscall
