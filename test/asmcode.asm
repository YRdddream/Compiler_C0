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
		Str22:  .asciiz "#Result of expression ends\n"
		Str23:  .asciiz "Test switch char\n"
		Str24:  .asciiz "\n"
		Str25:  .asciiz "#Result of switch char should be A-/\n"
		Str26:  .asciiz "Test print char\n"
		Str27:  .asciiz "1.\n"
		Str28:  .asciiz "2.\n"
		Str29:  .asciiz "3.\n"
		Str30:  .asciiz "4.\n"
		Str31:  .asciiz "\n"
		Str32:  .asciiz "#Result of print char ends\n"
		Str33:  .asciiz "Test multi-parameters\n"
		Str34:  .asciiz "#Result of multi-parameters ends\n"
		Str35:  .asciiz "Test single sentence\n"
		Str36:  .asciiz "test0\n"
		Str37:  .asciiz "#Result of single sentence ends\n"
		Str38:  .asciiz "Test convertion of char and int\n"
		Str39:  .asciiz "#Result of convertion of char and int ends\n"

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
		lw $v0, 12($sp)
		bne $v0, 1, Label1
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
		lw $v0, 12($sp)
		bne $v0, 2, Label2
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
		lw $v0, 12($sp)
		bne $v0, 3, Label3
		nop
		lw $v0, 12($sp)
		li $v1, 1
		mul $t0, $v0, $v1
		li $v0, 4
		la $a0, Str2
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j Label0
		nop
Label3:	
		lw $v0, 12($sp)
		bne $v0, 4, Label4
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
		addi $sp, $sp, -56
		sw $ra, 52($sp)
		sw $fp, 48($sp)
		move $fp, $sp
		sw $a0, 56($sp)
		li $v0, 49
		sw $v0, 44($sp)
		li $v0, 0
		addi $v1, $sp, 40
		sw $v0, 0($v1)
		lw $v0, 56($sp)
		li $v1, 0
		sub $t0, $v0, $v1
		bgez $t0, Label5
		nop
		li $v0, 4
		la $a0, Str3
		syscall
		li $v0, 1
		sub $t0, $0, $v0
		move $v0, $t0
		move $sp, $fp
		lw $ra, 52($sp)
		lw $fp, 48($sp)
		addi $sp, $sp, 56
		jr $ra
		nop
Label5:	
		lw $v0, 56($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		bgtz $t0, Label6
		nop
		lw $t8, 56($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 52($sp)
		lw $fp, 48($sp)
		addi $sp, $sp, 56
		jr $ra
		nop
Label6:	
		li $v0, 1
		sub $t0, $0, $v0
		sub $t1, $0, $t0
		lw $v0, 56($sp)
		sub $t2, $v0, $t1
		blez $t2, Label7
		nop
		lw $v0, 56($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		move $a0, $t0
		sw $t0, 36($sp)
		jal fibonacci
		nop
		lw $t0, 36($sp)
		move $t1, $v0
		li $v0, 43
		li $v1, 42
		sub $t2, $v0, $v1
		mul $t3, $t1, $t2
		lw $v0, 56($sp)
		li $v1, 1
		mul $t4, $v0, $v1
		li $v0, 20
		li $v1, 19
		sub $t5, $v0, $v1
		div $t6, $t4, $t5
		li $v1, 2
		sub $t7, $t6, $v1
		move $a0, $t7
		sw $t0, 36($sp)
		sw $t1, 32($sp)
		sw $t2, 28($sp)
		sw $t3, 24($sp)
		sw $t4, 20($sp)
		sw $t5, 16($sp)
		sw $t6, 12($sp)
		sw $t7, 8($sp)
		jal fibonacci
		nop
		lw $t0, 36($sp)
		lw $t1, 32($sp)
		lw $t2, 28($sp)
		lw $t3, 24($sp)
		lw $t4, 20($sp)
		lw $t5, 16($sp)
		lw $t6, 12($sp)
		lw $t7, 8($sp)
		la $t8, default
		sw $t0, 4($t8)
		move $t0, $v0
		li $v0, 1
		la $t8, default
		sw $t1, 8($t8)
		mul $t1, $v0, $t0
		li $v0, 20
		li $v1, 19
		la $t8, default
		sw $t2, 12($t8)
		sub $t2, $v0, $v1
		la $t8, default
		sw $t3, 16($t8)
		div $t3, $t1, $t2
		la $v0, default
		lw $v0, 16($v0)
		la $t8, default
		sw $t4, 20($t8)
		add $t4, $v0, $t3
		move $v0, $t4
		move $sp, $fp
		lw $ra, 52($sp)
		lw $fp, 48($sp)
		addi $sp, $sp, 56
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
		lw $v0, 12($sp)
		lw $v1, 16($sp)
		add $t0, $v0, $v1
		lw $v1, 20($sp)
		sub $t1, $t0, $v1
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
		lw $v0, 12($sp)
		li $v1, 65
		sub $t0, $v0, $v1
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
		lw $v0, 12($sp)
		li $v1, 90
		sub $t0, $v0, $v1
		blez $t0, Label9
		nop
		li $v0, 4
		la $a0, Str5
		syscall
		li $v0, -47
		sub $t0, $0, $v0
		move $v0, $t0
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label9:	
		lw $v0, 12($sp)
		li $v1, 32
		add $t0, $v0, $v1
		addi $v1, $sp, 12
		sw $t0, 0($v1)
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
		li $v0, 43
		li $v1, 0
		sub $t0, $v0, $v1
		addi $v1, $sp, 4
		sw $t0, 0($v1)
		lw $v0, 16($sp)
		li $v1, 122
		sub $t0, $v0, $v1
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
		lw $v0, 16($sp)
		li $v1, 97
		sub $t0, $v0, $v1
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
		lw $v0, 16($sp)
		li $v1, 32
		sub $t0, $v0, $v1
		addi $v1, $sp, 16
		sw $t0, 0($v1)
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
main:	
		addi $sp, $sp, -112
		sw $ra, 108($sp)
		sw $fp, 104($sp)
		move $fp, $sp
		li $v0, 42
		sw $v0, 100($sp)
		li $v0, 42
		sw $v0, 96($sp)
		li $v0, 1
		addi $v1, $sp, 72
		sw $v0, 0($v1)
		li $v0, 0
		sub $t0, $0, $v0
		addi $v1, $sp, 68
		sw $t0, 0($v1)
		lw $v0, 72($sp)
		addi $v1, $sp, 68
		sw $v0, 0($v1)
		la $v0, _
		lw $v0, 0($v0)
		la $v1, _
		lw $v1, 0($v1)
		add $t0, $v0, $v1
		li $v0, 3
		addi $v1, $sp, 76
		mulu $t0, $t0, 4
		add $v1, $v1, $t0
		sw $v0, 0($v1)
		li $v0, 2
		sub $t0, $0, $v0
		addi $v1, $sp, 76
		addi $v1, $v1, 4
		sw $t0, 0($v1)
		li $v0, 65
		addi $v1, $sp, 44
		addi $v1, $v1, 0
		sw $v0, 0($v1)
		li $v0, 45
		addi $v1, $sp, 44
		addi $v1, $v1, 4
		sw $v0, 0($v1)
		li $v0, 3
		li $v1, 0
		add $t0, $v0, $v1
		li $v1, 1
		sub $t1, $t0, $v1
		li $v0, 47
		addi $v1, $sp, 44
		mulu $t1, $t1, 4
		add $v1, $v1, $t1
		sw $v0, 0($v1)
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
		lw $v0, 92($sp)
		lw $v1, 88($sp)
		add $t0, $v0, $v1
		lw $v0, 72($sp)
		mul $t1, $v0, $t0
		addi $v1, $sp, 72
		sw $t1, 0($v1)
		lw $v0, 68($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 68
		sw $t0, 0($v1)
		lw $v0, 68($sp)
		li $v1, 4
		sub $t0, $v0, $v1
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
		lw $v0, 92($sp)
		la $v1, _
		lw $v1, 0($v1)
		sub $t0, $v0, $v1
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
		lw $v0, 92($sp)
		la $v1, _
		lw $v1, 0($v1)
		sub $t0, $v0, $v1
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
		li $v0, 43
		li $v1, 11
		sub $t0, $v0, $v1
		lw $v0, 92($sp)
		sub $t1, $v0, $t0
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
		addi $v0, $sp, 76
		lw $t0, 4($v0)
		addi $v0, $sp, 76
		lw $t1, 4($v0)
		li $v1, 2
		add $t2, $t1, $v1
		li $v0, 12
		sub $t3, $0, $v0
		mul $t4, $t2, $t3
		la $v1, _
		lw $v1, 0($v1)
		add $t5, $t4, $v1
		addi $v0, $sp, 76
		mulu $v1, $t5, 4
		add $v0, $v0, $v1
		lw $t6, 0($v0)
		mul $t7, $t0, $t6
		la $t8, default
		sw $t5, 4($t8)
		sub $t5, $0, $t7
		addi $v0, $sp, 76
		la $t8, default
		sw $t6, 8($t8)
		lw $t6, 0($v0)
		la $t8, default
		sw $t7, 12($t8)
		add $t7, $t5, $t6
		la $v1, _
		lw $v1, 0($v1)
		la $t8, default
		sw $t0, 16($t8)
		sub $t0, $t7, $v1
		la $v1, a
		sw $t0, 0($v1)
		li $v0, 4
		la $a0, Str20
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, -5
		sub $t0, $0, $v0
		li $v1, 9
		add $t1, $t0, $v1
		la $v1, a
		sw $t1, 0($v1)
		li $v0, 4
		la $a0, Str21
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str22
		syscall
		li $v0, 4
		la $a0, Str23
		syscall
		li $v0, 0
		addi $v1, $sp, 68
		sw $v0, 0($v1)
Label16:	
		addi $v0, $sp, 44
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		bne $t0, 65, Label18
		nop
		addi $v0, $sp, 44
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label18:	
		bne $t0, 45, Label19
		nop
		addi $v0, $sp, 44
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 4
		la $a0, Str24
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label19:	
		bne $t0, 47, Label20
		nop
		addi $v0, $sp, 44
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label17
		nop
Label20:	
Label17:	
		lw $v0, 68($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 68
		sw $t0, 0($v1)
		lw $v0, 68($sp)
		li $v1, 3
		sub $t0, $v0, $v1
		bltz $t0, Label16
		nop
		li $v0, 4
		la $a0, Str25
		syscall
		li $v0, 4
		la $a0, Str26
		syscall
		li $v0, 43
		li $v1, 11
		sub $t0, $v0, $v1
		li $v0, 4
		la $a0, Str27
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 97
		li $v1, 1
		add $t0, $v0, $v1
		li $v1, 98
		sub $t1, $t0, $v1
		li $v0, 4
		la $a0, Str28
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 4
		la $a0, Str29
		syscall
		li $t8, 97
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str30
		syscall
		la $t8, charz
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str31
		syscall
		li $v0, 4
		la $a0, Str32
		syscall
		li $v0, 4
		la $a0, Str33
		syscall
		lw $v0, 100($sp)
		lw $v1, 96($sp)
		sub $t0, $v0, $v1
		bnez $t0, Label21
		nop
		lw $t8, 100($sp)
		beqz $t8, Label22
		nop
		la $t8, int1
		lw $t8, 0($t8)
		move $a0, $t8
		la $t8, char1
		lw $t8, 0($t8)
		move $a1, $t8
		addi $v0, $sp, 76
		lw $t0, 4($v0)
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
		li $v0, 1
		sub $t0, $0, $v0
		li $v0, 57
		li $v1, 2
		mul $t1, $v0, $v1
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
		la $a0, Str34
		syscall
		li $v0, 4
		la $a0, Str35
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
		la $v0, a
		lw $v0, 0($v0)
		li $v1, 1
		add $t0, $v0, $v1
		la $v1, a
		sw $t0, 0($v1)
Label24:	
		lw $v0, 100($sp)
		lw $v1, 96($sp)
		sub $t0, $v0, $v1
		bnez $t0, Label23
		nop
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
Label25:	
		la $v0, a
		lw $v0, 0($v0)
		li $v1, 0
		sub $t0, $v0, $v1
		bne $t0, 0, Label27
		nop
		li $v0, 4
		la $a0, Str36
		syscall
		j Label26
		nop
Label27:	
Label26:	
		li $v0, -1
		sub $t0, $0, $v0
		addi $v0, $sp, 76
		mulu $v1, $t0, 4
		add $v0, $v0, $v1
		lw $t1, 0($v0)
		sub $t2, $0, $t1
		li $v1, 9
		add $t3, $t2, $v1
		li $v1, -11
		add $t4, $t3, $v1
		bnez $t4, Label25
		nop
		li $v0, 4
		la $a0, Str37
		syscall
		li $v0, 4
		la $a0, Str38
		syscall
		li $v0, 4
		la $a0, Str39
		syscall
