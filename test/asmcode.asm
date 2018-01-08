		.data
		Str0:  .asciiz "The number is so small!\n"
		Str1:  .asciiz "null result is \n"
		Str2:  .asciiz "number < \n"
		Str3:  .asciiz "will be printe\n"
		Str4:  .asciiz "Error1 \n"
		Str5:  .asciiz "Error2 \n"
		Str6:  .asciiz "Error1 \n"
		Str7:  .asciiz "Error2 \n"
		Str8:  .asciiz "Error3 \n"
		Str9:  .asciiz "Letter is too small.\n"
		Str10:  .asciiz "Letter is too big.\n"
		Str11:  .asciiz "Letter is too big.\n"
		Str12:  .asciiz "Letter is too small.\n"
		Str13:  .asciiz "#The 3result is \n"
		Str14:  .asciiz "#Result of fibonacci is \n"
		Str15:  .asciiz "Test relation operation\n"
		Str16:  .asciiz "a1 should be 0:\n"
		Str17:  .asciiz "a1 shouldn't be 0:\n"
		Str18:  .asciiz "a1 should beq 32:\n"
		Str19:  .asciiz "#Result of relation operation ends\n"
		Str20:  .asciiz "Test (void function&switch int)\n"
		Str21:  .asciiz "#Result of (void function&switch int) ends\n"
		Str22:  .asciiz "Test expression\n"
		Str23:  .asciiz "a should be 9:\n"
		Str24:  .asciiz "a should be 14:\n"
		Str25:  .asciiz "d1[0] should be 17:\n"
		Str26:  .asciiz "#Result of expression ends\n"
		Str27:  .asciiz "Test switch char\n"
		Str28:  .asciiz "\n"
		Str29:  .asciiz "\n"
		Str30:  .asciiz "#Result of switch char should be A-/\n"
		Str31:  .asciiz "Test print char\n"
		Str32:  .asciiz "1.\n"
		Str33:  .asciiz "2.\n"
		Str34:  .asciiz "3.\n"
		Str35:  .asciiz "4.\n"
		Str36:  .asciiz "\n"
		Str37:  .asciiz "#Result of print char ends\n"
		Str38:  .asciiz "Test multi-parameters\n"
		Str39:  .asciiz "#Result of multi-parameters ends\n"
		Str40:  .asciiz "Test single sentence\n"
		Str41:  .asciiz "test0\n"
		Str42:  .asciiz "#Result of single sentence ends\n"
		Str43:  .asciiz "Test convertion of char and int\n"
		Str44:  .asciiz "#Result of convertion of char and int ends\n"
		Str45:  .asciiz "test quick_sort:\n"

		_:  .word 0
		void1:  .word 0
		char1:  .word 49
		charz:  .word 90
		char9:  .word 57
		int1:  .word 1
		int2:  .word 2
		default:  .word 0
		a:  .word 0
		b:  .word 0
		c:  .space 20
		d:  .space 32
		single:  .word 0
		e:  .space 32
		f:  .word 0

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
quick_sort:	
		addi $sp, $sp, -100
		sw $ra, 96($sp)
		sw $fp, 92($sp)
		move $fp, $sp
		sw $a0, 100($sp)
		sw $a1, 104($sp)
		lw $v1, 100($sp)
		lw $t9, 104($sp)
		add $t0, $v1, $t9
		li $t9, 2
		div $t1, $t0, $t9
		la $v1, e
		mulu $t9, $t1, 4
		add $v1, $v1, $t9
		lw $t2, 0($v1)
		addi $t9, $sp, 76
		sw $t2, 0($t9)
		lw $v1, 100($sp)
		addi $t9, $sp, 84
		sw $v1, 0($t9)
		lw $v1, 104($sp)
		addi $t9, $sp, 80
		sw $v1, 0($t9)
Label1:	
Label2:	
		la $v1, e
		lw $t9, 80($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 76($sp)
		sub $t1, $v1, $t0
		bgez $t1, Label3
		nop
		lw $v1, 80($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		sub $t1, $t0, $t9
		addi $t9, $sp, 80
		sw $t1, 0($t9)
Label3:	
		la $v1, e
		lw $t9, 80($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 76($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label2
		nop
Label4:	
		la $v1, e
		lw $t9, 84($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 76($sp)
		sub $t1, $v1, $t0
		blez $t1, Label5
		nop
		lw $v1, 84($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		addi $t9, $sp, 84
		sw $t1, 0($t9)
Label5:	
		la $v1, e
		lw $t9, 84($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 76($sp)
		sub $t1, $v1, $t0
		bgtz $t1, Label4
		nop
		lw $v1, 84($sp)
		lw $t9, 80($sp)
		sub $t0, $v1, $t9
		bgtz $t0, Label6
		nop
		lw $v1, 84($sp)
		li $t9, 0
		add $t0, $v1, $t9
		lw $v1, 80($sp)
		li $t9, 0
		add $t1, $v1, $t9
		la $v1, e
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t2, 0($v1)
		la $v1, e
		mulu $t9, $t1, 4
		add $v1, $v1, $t9
		lw $t3, 0($v1)
		la $t9, e
		mulu $t8, $t0, 4
		add $t9, $t9, $t8
		sw $t3, 0($t9)
		la $t9, e
		mulu $t8, $t1, 4
		add $t9, $t9, $t8
		sw $t2, 0($t9)
		li $t9, 1
		add $t4, $t0, $t9
		li $t9, 1
		sub $t5, $t1, $t9
		addi $t9, $sp, 80
		sw $t5, 0($t9)
		addi $t9, $sp, 88
		sw $t2, 0($t9)
		addi $t9, $sp, 84
		sw $t4, 0($t9)
Label6:	
		lw $v1, 84($sp)
		lw $t9, 80($sp)
		sub $t0, $v1, $t9
		blez $t0, Label1
		nop
		lw $v1, 84($sp)
		lw $t9, 104($sp)
		sub $t0, $v1, $t9
		bgez $t0, Label7
		nop
		li $v1, 100
		sub $t0, $0, $v1
		li $v1, 1
		sub $t1, $0, $v1
		move $a0, $t1
		lw $t8, 84($sp)
		move $a1, $t8
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		move $t2, $v0
		move $a0, $t2
		li $a1, 0
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		move $t3, $v0
		move $a0, $t0
		move $a1, $t3
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		move $t4, $v0
		li $v1, 100
		sub $t5, $0, $v1
		li $v1, 1
		sub $t6, $0, $v1
		move $a0, $t6
		lw $t8, 104($sp)
		move $a1, $t8
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		move $t7, $v0
		move $a0, $t7
		li $a1, 0
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		sw $t7, 44($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		lw $t7, 44($sp)
		la $t8, f
		sw $t0, 4($t8)
		move $t0, $v0
		move $a0, $t5
		move $a1, $t0
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		sw $t7, 44($sp)
		la $v1, f
		lw $t8, 4($v1)
		sw $t8, 40($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		lw $t7, 44($sp)
		lw $t8, 40($sp)
		la $v1, f
		sw $t8, 4($v1)
		la $t8, f
		sw $t1, 8($t8)
		move $t1, $v0
		move $a0, $t4
		move $a1, $t1
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		sw $t7, 44($sp)
		la $v1, f
		lw $t8, 4($v1)
		sw $t8, 40($sp)
		la $v1, f
		lw $t8, 8($v1)
		sw $t8, 36($sp)
		jal quick_sort
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		lw $t7, 44($sp)
		lw $t8, 40($sp)
		la $v1, f
		sw $t8, 4($v1)
		lw $t8, 36($sp)
		la $v1, f
		sw $t8, 8($v1)
Label7:	
		lw $v1, 100($sp)
		lw $t9, 80($sp)
		la $t8, f
		sw $t2, 12($t8)
		sub $t2, $v1, $t9
		bgez $t2, Label8
		nop
		li $v1, 100
		sub $t0, $0, $v1
		li $v1, 1
		sub $t1, $0, $v1
		move $a0, $t1
		lw $t8, 100($sp)
		move $a1, $t8
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		move $t2, $v0
		move $a0, $t2
		li $a1, 0
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		move $t3, $v0
		move $a0, $t0
		move $a1, $t3
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		move $t4, $v0
		li $v1, 0
		sub $t5, $0, $v1
		lw $t8, 100($sp)
		move $a0, $t8
		lw $t8, 80($sp)
		move $a1, $t8
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		move $t6, $v0
		move $a0, $t5
		move $a1, $t6
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		jal max
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		move $t7, $v0
		move $a0, $t4
		move $a1, $t7
		sw $t0, 72($sp)
		sw $t1, 68($sp)
		sw $t2, 64($sp)
		sw $t3, 60($sp)
		sw $t4, 56($sp)
		sw $t5, 52($sp)
		sw $t6, 48($sp)
		sw $t7, 44($sp)
		jal quick_sort
		nop
		lw $t0, 72($sp)
		lw $t1, 68($sp)
		lw $t2, 64($sp)
		lw $t3, 60($sp)
		lw $t4, 56($sp)
		lw $t5, 52($sp)
		lw $t6, 48($sp)
		lw $t7, 44($sp)
Label8:	
		li $v1, 5
		la $t8, f
		sw $t3, 4($t8)
		sub $t3, $0, $v1
		move $v0, $t3
		move $sp, $fp
		lw $ra, 96($sp)
		lw $fp, 92($sp)
		addi $sp, $sp, 100
		jr $ra
		nop
		move $sp, $fp
		lw $ra, 96($sp)
		lw $fp, 92($sp)
		addi $sp, $sp, 100
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
		bgez $t0, Label9
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
Label9:	
		lw $v1, 76($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bgtz $t0, Label10
		nop
		lw $t8, 76($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 72($sp)
		lw $fp, 68($sp)
		addi $sp, $sp, 76
		jr $ra
		nop
Label10:	
		li $v1, 1
		sub $t0, $0, $v1
		sub $t1, $0, $t0
		lw $v1, 76($sp)
		sub $t2, $v1, $t1
		blez $t2, Label11
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
		la $t8, f
		sw $t4, 4($t8)
		sub $t4, $v1, $t9
		lw $v1, 76($sp)
		li $t9, 0
		la $t8, f
		sw $t5, 8($t8)
		add $t5, $v1, $t9
		li $t9, 1
		la $t8, f
		sw $t6, 12($t8)
		mul $t6, $t5, $t9
		la $t8, f
		sw $t7, 16($t8)
		div $t7, $t6, $t4
		li $t9, 4
		la $t8, f
		sw $t0, 20($t8)
		add $t0, $t7, $t9
		li $t9, 2
		la $t8, f
		sw $t1, 24($t8)
		sub $t1, $t0, $t9
		li $t9, 4
		la $t8, f
		sw $t2, 28($t8)
		sub $t2, $t1, $t9
		move $a0, $t2
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		sw $t3, 52($sp)
		sw $t4, 48($sp)
		sw $t5, 44($sp)
		sw $t6, 40($sp)
		sw $t7, 36($sp)
		la $v1, f
		lw $t8, 4($v1)
		sw $t8, 32($sp)
		la $v1, f
		lw $t8, 8($v1)
		sw $t8, 28($sp)
		la $v1, f
		lw $t8, 12($v1)
		sw $t8, 24($sp)
		la $v1, f
		lw $t8, 16($v1)
		sw $t8, 20($sp)
		la $v1, f
		lw $t8, 20($v1)
		sw $t8, 16($sp)
		la $v1, f
		lw $t8, 24($v1)
		sw $t8, 12($sp)
		la $v1, f
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
		la $v1, f
		sw $t8, 4($v1)
		lw $t8, 28($sp)
		la $v1, f
		sw $t8, 8($v1)
		lw $t8, 24($sp)
		la $v1, f
		sw $t8, 12($v1)
		lw $t8, 20($sp)
		la $v1, f
		sw $t8, 16($v1)
		lw $t8, 16($sp)
		la $v1, f
		sw $t8, 20($v1)
		lw $t8, 12($sp)
		la $v1, f
		sw $t8, 24($v1)
		lw $t8, 8($sp)
		la $v1, f
		sw $t8, 28($v1)
		la $t8, f
		sw $t3, 32($t8)
		move $t3, $v0
		li $v1, 20
		li $t9, 19
		la $t8, f
		sw $t4, 36($t8)
		sub $t4, $v1, $t9
		li $v1, 16
		la $t8, f
		sw $t5, 40($t8)
		sub $t5, $0, $v1
		li $v1, 17
		la $t8, f
		sw $t6, 44($t8)
		add $t6, $v1, $t5
		li $v1, 1
		la $t8, f
		sw $t7, 48($t8)
		mul $t7, $v1, $t3
		la $t8, f
		sw $t0, 52($t8)
		div $t0, $t7, $t4
		la $t8, f
		sw $t1, 56($t8)
		mul $t1, $t0, $t6
		la $v1, f
		lw $v1, 16($v1)
		la $t8, f
		sw $t2, 60($t8)
		add $t2, $v1, $t1
		move $v0, $t2
		move $sp, $fp
		lw $ra, 72($sp)
		lw $fp, 68($sp)
		addi $sp, $sp, 76
		jr $ra
		nop
Label11:	
null:	
		addi $sp, $sp, -32
		sw $ra, 28($sp)
		sw $fp, 24($sp)
		move $fp, $sp
		li $v1, 17
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, -17
		add $t1, $t0, $t9
		li $a0, 10
		li $a1, 0
		sw $t0, 20($sp)
		sw $t1, 16($sp)
		jal max
		nop
		lw $t0, 20($sp)
		lw $t1, 16($sp)
		move $t2, $v0
		move $a0, $t2
		sw $t0, 20($sp)
		sw $t1, 16($sp)
		sw $t2, 12($sp)
		jal fibonacci
		nop
		lw $t0, 20($sp)
		lw $t1, 16($sp)
		lw $t2, 12($sp)
		move $t3, $v0
		add $t4, $t1, $t3
		la $t9, b
		sw $t4, 0($t9)
		li $v0, 4
		la $a0, Str1
		syscall
		la $t8, b
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v1, 0
		la $t9, b
		sw $v1, 0($t9)
		move $sp, $fp
		lw $ra, 28($sp)
		lw $fp, 24($sp)
		addi $sp, $sp, 32
		jr $ra
		nop
print_error:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		sw $a0, 20($sp)
		li $v1, 52
		sw $v1, 8($sp)
		li $v1, 4
		addi $t9, $sp, 4
		sw $v1, 0($t9)
		li $v0, 4
		la $a0, Str2
		syscall
		lw $t8, 8($sp)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str3
		syscall
		li $t8, 100
		li $v0, 11
		move $a0, $t8
		syscall
		lw $v1, 20($sp)
		bne $v1, 1, Label13
		nop
		li $v0, 4
		la $a0, Str4
		syscall
		lw $t8, 20($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
		j Label12
		nop
Label13:	
		lw $v1, 20($sp)
		bne $v1, 2, Label14
		nop
		li $v0, 4
		la $a0, Str5
		syscall
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
		j Label12
		nop
Label14:	
		lw $v1, 20($sp)
		bne $v1, 3, Label15
		nop
		lw $v1, 20($sp)
		bne $v1, 1, Label17
		nop
		li $v0, 4
		la $a0, Str6
		syscall
		lw $t8, 20($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		j Label16
		nop
Label17:	
		lw $v1, 20($sp)
		bne $v1, 2, Label18
		nop
		li $v0, 4
		la $a0, Str7
		syscall
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		j Label16
		nop
Label18:	
		lw $v1, 20($sp)
		bne $v1, 3, Label19
		nop
		lw $v1, 20($sp)
		li $t9, 1
		mul $t0, $v1, $t9
		li $v0, 4
		la $a0, Str8
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j Label16
		nop
Label19:	
		lw $v1, 20($sp)
		bne $v1, 4, Label20
		nop
		j Label16
		nop
Label20:	
Label16:	
		j Label12
		nop
Label15:	
Label12:	
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
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
		bgez $t0, Label21
		nop
		li $v0, 4
		la $a0, Str9
		syscall
		li $t8, 42
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label21:	
		lw $v1, 12($sp)
		li $t9, 90
		sub $t0, $v1, $t9
		blez $t0, Label22
		nop
		li $v0, 4
		la $a0, Str10
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
Label22:	
		lw $v1, 12($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 32
		add $t1, $t0, $t9
		li $t9, 0
		add $t2, $t1, $t9
		addi $t9, $sp, 12
		sw $t1, 0($t9)
		move $v0, $t2
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
mult_add:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		sw $a2, 20($sp)
		sw $a3, 24($sp)
		lw $v1, 24($sp)
		lw $t9, 28($sp)
		add $t0, $v1, $t9
		lw $t9, 32($sp)
		sub $t1, $t0, $t9
		move $v0, $t1
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
		lw $v1, 16($sp)
		li $t9, 122
		sub $t1, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		blez $t1, Label23
		nop
		li $v0, 4
		la $a0, Str11
		syscall
		li $t8, 45
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label23:	
		lw $v1, 16($sp)
		li $t9, 97
		sub $t0, $v1, $t9
		bgez $t0, Label24
		nop
		li $v0, 4
		la $a0, Str12
		syscall
		lw $t8, 4($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label24:	
		lw $v1, 16($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 32
		sub $t1, $t0, $t9
		addi $t9, $sp, 16
		sw $t1, 0($t9)
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
main:	
		addi $sp, $sp, -144
		sw $ra, 140($sp)
		sw $fp, 136($sp)
		move $fp, $sp
		li $v1, 42
		sw $v1, 132($sp)
		li $v1, 42
		sw $v1, 128($sp)
		li $v1, 0
		sub $t0, $0, $v1
		la $v1, _
		lw $v1, 0($v1)
		la $t9, _
		lw $t9, 0($t9)
		add $t1, $v1, $t9
		li $v1, 3
		addi $t9, $sp, 100
		mulu $t8, $t1, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		li $v1, 2
		sub $t2, $0, $v1
		addi $t9, $sp, 100
		addi $t9, $t9, 4
		sw $t2, 0($t9)
		li $v1, 65
		addi $t9, $sp, 68
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		li $v1, 45
		addi $t9, $sp, 68
		addi $t9, $t9, 4
		sw $v1, 0($t9)
		li $v1, 3
		li $t9, 0
		add $t3, $v1, $t9
		li $t9, 1
		sub $t4, $t3, $t9
		li $v1, 47
		addi $t9, $sp, 68
		mulu $t8, $t4, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 96
		sw $v1, 0($t9)
		li $v1, 2
		addi $t9, $sp, 120
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 124
		sw $v1, 0($t9)
		li $v1, 1
		addi $t9, $sp, 92
		sw $v1, 0($t9)
		li $v0, 5
		syscall
		sw $v0, 116($sp)
		li $v0, 5
		syscall
		sw $v0, 112($sp)
Label25:	
		lw $v1, 92($sp)
		li $t9, 0
		add $t0, $v1, $t9
		lw $v1, 96($sp)
		li $t9, 0
		add $t1, $v1, $t9
		lw $v1, 116($sp)
		lw $t9, 112($sp)
		add $t2, $v1, $t9
		mul $t3, $t0, $t2
		li $t9, 1
		add $t4, $t1, $t9
		li $t9, 4
		sub $t5, $t4, $t9
		addi $t9, $sp, 96
		sw $t4, 0($t9)
		addi $t9, $sp, 92
		sw $t3, 0($t9)
		bltz $t5, Label25
		nop
		li $v0, 4
		la $a0, Str13
		syscall
		lw $t8, 92($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 5
		syscall
		la $v1, b
		sw $v0, 0($v1)
		la $t8, b
		lw $t8, 0($t8)
		move $a0, $t8
		jal fibonacci
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str14
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str15
		syscall
		li $v0, 5
		syscall
		sw $v0, 116($sp)
		lw $v1, 116($sp)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		bnez $t0, Label26
		nop
		li $v0, 4
		la $a0, Str16
		syscall
		lw $t8, 116($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label26:	
		la $v1, void1
		lw $v1, 0($v1)
		la $t9, _
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		lw $v1, 116($sp)
		sub $t1, $v1, $t0
		beqz $t1, Label27
		nop
		li $v0, 4
		la $a0, Str17
		syscall
		lw $t8, 116($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label27:	
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		lw $v1, 116($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label28
		nop
		li $v0, 4
		la $a0, Str18
		syscall
		lw $t8, 116($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label28:	
		li $v0, 4
		la $a0, Str19
		syscall
		li $v0, 4
		la $a0, Str20
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		sw $v0, 112($sp)
		li $v0, 5
		syscall
		sw $v0, 108($sp)
		la $t8, a
		lw $t8, 0($t8)
		move $a0, $t8
		jal print_error
		nop
		jal null
		nop
		lw $t8, 112($sp)
		move $a0, $t8
		jal print_error
		nop
		lw $t8, 108($sp)
		move $a0, $t8
		jal print_error
		nop
		li $a0, 4
		jal print_error
		nop
		li $v0, 4
		la $a0, Str21
		syscall
		li $v0, 4
		la $a0, Str22
		syscall
		li $v1, 1
		la $t9, void1
		lw $t9, 0($t9)
		add $t0, $v1, $t9
		li $v1, 12
		sub $t1, $0, $v1
		addi $v1, $sp, 100
		lw $t2, 4($v1)
		li $t9, 2
		add $t3, $t2, $t9
		mul $t4, $t3, $t1
		la $t9, _
		lw $t9, 0($t9)
		add $t5, $t4, $t9
		addi $v1, $sp, 100
		mulu $t9, $t5, 4
		add $v1, $v1, $t9
		lw $t6, 0($v1)
		addi $v1, $sp, 100
		lw $t7, 0($v1)
		addi $v1, $sp, 100
		mulu $t9, $t0, 4
		la $t8, f
		sw $t3, 4($t8)
		add $v1, $v1, $t9
		lw $t3, 0($v1)
		la $t8, f
		sw $t4, 8($t8)
		mul $t4, $t3, $t6
		la $t8, f
		sw $t5, 12($t8)
		sub $t5, $0, $t4
		la $t8, f
		sw $t6, 16($t8)
		add $t6, $t5, $t7
		la $t9, _
		lw $t9, 0($t9)
		la $t8, f
		sw $t7, 20($t8)
		sub $t7, $t6, $t9
		la $t9, a
		sw $t7, 0($t9)
		li $v0, 4
		la $a0, Str23
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
		la $a0, Str24
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
		addi $v1, $sp, 100
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
		addi $t9, $sp, 100
		mulu $t8, $t7, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		addi $v1, $sp, 100
		la $t8, f
		sw $t0, 4($t8)
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str25
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str26
		syscall
		li $v0, 4
		la $a0, Str27
		syscall
		li $v1, 0
		addi $t9, $sp, 96
		sw $v1, 0($t9)
Label29:	
		addi $v1, $sp, 68
		lw $t9, 96($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		bne $t0, 65, Label31
		nop
		addi $v1, $sp, 68
		lw $t9, 96($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		j Label30
		nop
Label31:	
		bne $t0, 45, Label32
		nop
		addi $v1, $sp, 68
		lw $t9, 96($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str28
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j Label30
		nop
Label32:	
		bne $t0, 47, Label33
		nop
		addi $v1, $sp, 68
		lw $t9, 96($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str29
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j Label30
		nop
Label33:	
Label30:	
		lw $v1, 96($sp)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		li $t9, 3
		sub $t2, $t1, $t9
		addi $t9, $sp, 96
		sw $t1, 0($t9)
		bltz $t2, Label29
		nop
		li $v0, 4
		la $a0, Str30
		syscall
		li $v0, 4
		la $a0, Str31
		syscall
		li $v1, 43
		li $t9, 11
		sub $t0, $v1, $t9
		li $v0, 4
		la $a0, Str32
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
		la $a0, Str33
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 4
		la $a0, Str34
		syscall
		li $t8, 97
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str35
		syscall
		la $t8, charz
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str36
		syscall
		li $v0, 4
		la $a0, Str37
		syscall
		li $v0, 4
		la $a0, Str38
		syscall
		lw $v1, 132($sp)
		lw $t9, 128($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label34
		nop
		lw $t8, 132($sp)
		beqz $t8, Label35
		nop
		li $t8, 1
		beqz $t8, Label36
		nop
		addi $v1, $sp, 100
		lw $t0, 4($v1)
		la $t8, char9
		lw $t8, 0($t8)
		move $a0, $t8
		li $a1, 1
		li $a2, 97
		la $t8, int1
		lw $t8, 0($t8)
		move $a3, $t8
		la $t8, char1
		lw $t8, 0($t8)
		sw $t8, 16($sp)
		sw $t0, 20($sp)
		sw $t0, 64($sp)
		jal mult_add
		nop
		lw $t0, 64($sp)
		move $t1, $v0
		li $v0, 1
		move $a0, $t1
		syscall
Label36:	
Label35:	
Label34:	
		li $a0, 63
		li $a1, 64
		jal max
		nop
		move $t0, $v0
		li $v1, 57
		li $t9, 2
		mul $t1, $v1, $t9
		li $v1, 1
		sub $t2, $0, $v1
		add $t3, $t2, $t1
		move $a0, $t3
		li $a1, 0
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		sw $t3, 52($sp)
		jal max
		nop
		lw $t0, 64($sp)
		lw $t1, 60($sp)
		lw $t2, 56($sp)
		lw $t3, 52($sp)
		move $t4, $v0
		li $a0, 0
		li $a1, 0
		li $a2, 0
		move $a3, $t0
		li $t8, 97
		sw $t8, 16($sp)
		sw $t4, 20($sp)
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		sw $t3, 52($sp)
		sw $t4, 48($sp)
		jal mult_add
		nop
		lw $t0, 64($sp)
		lw $t1, 60($sp)
		lw $t2, 56($sp)
		lw $t3, 52($sp)
		lw $t4, 48($sp)
		move $t5, $v0
		li $v0, 1
		move $a0, $t5
		syscall
		li $v0, 5
		syscall
		sw $v0, 116($sp)
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
		lw $t8, 116($sp)
		move $a3, $t8
		la $t8, default
		lw $t8, 0($t8)
		sw $t8, 16($sp)
		la $t8, single
		lw $t8, 0($t8)
		sw $t8, 20($sp)
		jal mult_add
		nop
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str39
		syscall
		li $v0, 4
		la $a0, Str40
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
Label37:	
		la $t8, a
		lw $t8, 0($t8)
		beqz $t8, Label38
		nop
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 0
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		la $t9, a
		sw $t1, 0($t9)
Label38:	
		lw $v1, 132($sp)
		lw $t9, 128($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label37
		nop
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
Label39:	
		la $v1, a
		lw $v1, 0($v1)
		li $t9, 0
		sub $t0, $v1, $t9
		bne $t0, 0, Label41
		nop
		li $v0, 4
		la $a0, Str41
		syscall
		j Label40
		nop
Label41:	
Label40:	
		li $v1, -1
		sub $t0, $0, $v1
		addi $v1, $sp, 100
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		sub $t2, $0, $t1
		li $t9, 9
		add $t3, $t2, $t9
		li $t9, -11
		add $t4, $t3, $t9
		bnez $t4, Label39
		nop
		li $v0, 4
		la $a0, Str42
		syscall
		li $v0, 4
		la $a0, Str43
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
		li $v0, 1
		move $a0, $t0
		syscall
		li $a0, 90
		jal tolower
		nop
		move $t0, $v0
		li $a0, 122
		sw $t0, 64($sp)
		jal toupper
		nop
		lw $t0, 64($sp)
		move $t1, $v0
		sub $t2, $t0, $t1
		li $v0, 1
		move $a0, $t2
		syscall
		li $a0, 48
		jal tolower
		nop
		move $t0, $v0
		li $v0, 11
		move $a0, $t0
		syscall
		li $a0, 48
		jal tolower
		nop
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str44
		syscall
		li $v1, 105
		la $t9, e
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		la $t8, charz
		lw $t8, 0($t8)
		move $a0, $t8
		jal tolower
		nop
		move $t0, $v0
		la $t9, e
		addi $t9, $t9, 4
		sw $t0, 0($t9)
		li $v1, 96
		li $t9, 1
		add $t1, $v1, $t9
		la $t9, e
		addi $t9, $t9, 8
		sw $t1, 0($t9)
		li $v1, 105
		li $t9, 5
		sub $t2, $v1, $t9
		la $t9, e
		addi $t9, $t9, 12
		sw $t2, 0($t9)
		li $v1, 108
		la $t9, e
		addi $t9, $t9, 16
		sw $v1, 0($t9)
		la $t8, charz
		lw $t8, 0($t8)
		move $a0, $t8
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		jal tolower
		nop
		lw $t0, 64($sp)
		lw $t1, 60($sp)
		lw $t2, 56($sp)
		move $t3, $v0
		li $t9, 3
		sub $t4, $t3, $t9
		la $t9, e
		addi $t9, $t9, 20
		sw $t4, 0($t9)
		li $v1, 108
		la $t9, e
		addi $t9, $t9, 24
		sw $v1, 0($t9)
		li $v1, 111
		la $t9, e
		addi $t9, $t9, 28
		sw $v1, 0($t9)
		li $a0, 0
		li $a1, 7
		sw $t0, 64($sp)
		sw $t1, 60($sp)
		sw $t2, 56($sp)
		sw $t3, 52($sp)
		sw $t4, 48($sp)
		jal quick_sort
		nop
		lw $t0, 64($sp)
		lw $t1, 60($sp)
		lw $t2, 56($sp)
		lw $t3, 52($sp)
		lw $t4, 48($sp)
		li $v0, 4
		la $a0, Str45
		syscall
		li $v1, 0
		addi $t9, $sp, 96
		sw $v1, 0($t9)
Label42:	
		la $v1, e
		lw $t9, 96($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v1, 96($sp)
		li $t9, 0
		add $t0, $v1, $t9
		la $t9, int1
		lw $t9, 0($t9)
		add $t1, $t0, $t9
		li $t9, 7
		sub $t2, $t1, $t9
		addi $t9, $sp, 96
		sw $t1, 0($t9)
		blez $t2, Label42
		nop
