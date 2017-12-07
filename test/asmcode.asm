		.data
		str0:  .asciiz "Error1 \n"
		str1:  .asciiz "Error2 \n"
		str2:  .asciiz "Error3 \n"
		str3:  .asciiz "The number is so small!\n"
		str4:  .asciiz "Please check your letter.\n"
		str5:  .asciiz "Please check your letter.\n"
		str6:  .asciiz "Please check your letter.\n"
		str7:  .asciiz "Please check your letter.\n"
		str8:  .asciiz "Test do-while\n"
		str9:  .asciiz "#Result of do-while is \n"
		str10:  .asciiz "Test fibonacci\n"
		str11:  .asciiz "#Result of fibonacci is \n"
		str12:  .asciiz "Test relation operation\n"
		str13:  .asciiz "a1 should be 0:\n"
		str14:  .asciiz "a1 shouldn't be 0:\n"
		str15:  .asciiz "a1 should beq 32:\n"
		str16:  .asciiz "#Result of relation operation ends\n"
		str17:  .asciiz "Test (void function&switch int)\n"
		str18:  .asciiz "#Result of (void function&switch int) ends\n"
		str19:  .asciiz "Test expression\n"
		str20:  .asciiz "a should be 9:\n"
		str21:  .asciiz "a should be 14:\n"
		str22:  .asciiz "#Result of expression ends\n"
		str23:  .asciiz "Test switch char\n"
		str24:  .asciiz "\n"
		str25:  .asciiz "#Result of switch char should be A-/\n"
		str26:  .asciiz "Test print char\n"
		str27:  .asciiz "1.\n"
		str28:  .asciiz "2.\n"
		str29:  .asciiz "3.\n"
		str30:  .asciiz "4.\n"
		str31:  .asciiz "\n"
		str32:  .asciiz "#Result of print char ends\n"
		str33:  .asciiz "Test multi-parameters\n"
		str34:  .asciiz "#Result of multi-parameters ends\n"
		str35:  .asciiz "Test single sentence\n"
		str36:  .asciiz "test0\n"
		str37:  .asciiz "#Result of single sentence ends\n"
		str38:  .asciiz "Test convertion of char and int\n"
		str39:  .asciiz "#Result of convertion of char and int ends\n"

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
print_error:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		lw $v0, 12($sp)
		bne $v0, 1, label1
		li $v0, 4
		la $a0, str0
		syscall
		lw $t8, 12($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		j label0
		nop
label1:	
		lw $v0, 12($sp)
		bne $v0, 2, label2
		li $v0, 4
		la $a0, str1
		syscall
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		j label0
		nop
label2:	
		lw $v0, 12($sp)
		bne $v0, 3, label3
		lw $v0, 12($sp)
		li $v1, 1
		mul $t0, $v0, $v1
		li $v0, 4
		la $a0, str2
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		j label0
		nop
label3:	
		lw $v0, 12($sp)
		bne $v0, 4, label4
		j label0
		nop
label4:	
label0:	
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
fibonacci:	
		addi $sp, $sp, -24
		sw $ra, 20($sp)
		sw $fp, 16($sp)
		move $fp, $sp
		sw $a0, 24($sp)
		li $v0, 49
		sw $v0, 12($sp)
		li $v0, 0
		addi $v1, $sp, 8
		sw $v0, 0($v1)
		lw $v0, 24($sp)
		li $v1, 0
		sub $t0, $v0, $v1
		bgez $t0, label5
		nop
		li $v0, 4
		la $a0, str3
		syscall
		li $v0, 1
		sub $t0, $0, $v0
		move $v0, $t0
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
label5:	
		lw $v0, 24($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		bgtz $t0, label6
		nop
		lw $t8, 24($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
label6:	
		li $v0, 1
		sub $t0, $0, $v0
		sub $t1, $0, $t0
		lw $v0, 24($sp)
		sub $t2, $v0, $t1
		blez $t2, label7
		nop
		lw $v0, 24($sp)
		sub $t0, $0, $v0
		move $a0, $t0
		li $v0, 43
		sub $t0, $0, $v0
		mul $t1, $t0, $t0
		lw $v0, 24($sp)
		li $v1, 1
		mul $t2, $v0, $v1
		li $v0, 20
		sub $t3, $0, $v0
		div $t4, $t2, $t3
		sub $t5, $0, $t4
		move $a0, $t5
		li $v0, 1
		mul $t0, $v0, $t0
		li $v0, 20
		sub $t1, $0, $v0
		div $t2, $t0, $t1
		add $t3, $t1, $t2
		move $v0, $t3
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
label7:	
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
		sub $t1, $0, $t0
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
		lw $v0, 0($sp)
		li $v1, 65
		sub $t0, $v0, $v1
		bgez $t0, label8
		nop
		li $v0, 4
		la $a0, str4
		syscall
		li $t8, 42
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
label8:	
		lw $v0, 0($sp)
		li $v1, 90
		sub $t0, $v0, $v1
		blez $t0, label9
		nop
		li $v0, 4
		la $a0, str5
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
label9:	
		lw $v0, 0($sp)
		li $v1, 32
		add $t0, $v0, $v1
		addi $v1, $sp, 0
		sw $t0, 0($v1)
		lw $t8, 0($sp)
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
		sub $t0, $0, $v0
		addi $v1, $sp, 4
		sw $t0, 0($v1)
		lw $v0, 16($sp)
		li $v1, 122
		sub $t0, $v0, $v1
		blez $t0, label10
		nop
		li $v0, 4
		la $a0, str6
		syscall
		li $t8, 45
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
label10:	
		lw $v0, 16($sp)
		li $v1, 97
		sub $t0, $v0, $v1
		bgez $t0, label11
		nop
		li $v0, 4
		la $a0, str7
		syscall
		lw $t8, 4($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
label11:	
		lw $v0, 16($sp)
		sub $t0, $0, $v0
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
		addi $sp, $sp, -100
		sw $ra, 96($sp)
		sw $fp, 92($sp)
		move $fp, $sp
		li $v0, 42
		sw $v0, 88($sp)
		li $v0, 42
		sw $v0, 84($sp)
		li $v0, 1
		addi $v1, $sp, 60
		sw $v0, 0($v1)
		li $v0, 0
		sub $t0, $0, $v0
		addi $v1, $sp, 56
		sw $t0, 0($v1)
		lw $v0, 60($sp)
		addi $v1, $sp, 56
		sw $v0, 0($v1)
		la $v0, _
		lw $v0, 0($v0)
		la $v1, _
		lw $v1, 0($v1)
		add $t0, $v0, $v1
		li $v0, 3
		addi $v1, $sp, 64
		add $v1, $v1, $t0
		sw $v0, 0($v1)
		li $v0, 2
		sub $t0, $0, $v0
		addi $v1, $sp, 64
		addi $v1, $v1, 1
		sw $t0, 0($v1)
		li $v0, 65
		addi $v1, $sp, 32
		addi $v1, $v1, 0
		sw $v0, 0($v1)
		li $v0, 45
		addi $v1, $sp, 32
		addi $v1, $v1, 1
		sw $v0, 0($v1)
		li $v0, 3
		li $v1, 0
		add $t0, $v0, $v1
		sub $t1, $0, $t0
		li $v0, 47
		addi $v1, $sp, 32
		add $v1, $v1, $t1
		sw $v0, 0($v1)
		li $v0, 4
		la $a0, str8
		syscall
		li $v0, 5
		syscall
		sw $v0, 80($sp)
		li $v0, 5
		syscall
		sw $v0, 76($sp)
label12:	
		lw $v0, 80($sp)
		lw $v1, 76($sp)
		add $t0, $v0, $v1
		lw $v0, 60($sp)
		mul $t1, $v0, $t0
		addi $v1, $sp, 60
		sw $t1, 0($v1)
		lw $v0, 56($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 56
		sw $t0, 0($v1)
		lw $v0, 56($sp)
		li $v1, 4
		sub $t0, $v0, $v1
		bltz $t0, label12
		nop
		li $v0, 4
		la $a0, str9
		syscall
		lw $t8, 60($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, str10
		syscall
		li $v0, 5
		syscall
		sw $v0, 80($sp)
		lw $t8, 80($sp)
		move $a0, $t8
		li $v0, 4
		la $a0, str11
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, str12
		syscall
		li $v0, 5
		syscall
		sw $v0, 80($sp)
		lw $v0, 80($sp)
		la $v1, _
		lw $v1, 0($v1)
		sub $t0, $v0, $v1
		bnez $t0, label13
		nop
		li $v0, 4
		la $a0, str13
		syscall
		lw $t8, 80($sp)
		li $v0, 1
		move $a0, $t8
		syscall
label13:	
		lw $v0, 80($sp)
		la $v1, _
		lw $v1, 0($v1)
		sub $t0, $v0, $v1
		beqz $t0, label14
		nop
		li $v0, 4
		la $a0, str14
		syscall
		lw $t8, 80($sp)
		li $v0, 1
		move $a0, $t8
		syscall
label14:	
		li $v0, 43
		sub $t0, $0, $v0
		lw $v0, 80($sp)
		sub $t1, $v0, $t0
		bltz $t1, label15
		nop
		li $v0, 4
		la $a0, str15
		syscall
		lw $t8, 80($sp)
		li $v0, 1
		move $a0, $t8
		syscall
label15:	
		li $v0, 4
		la $a0, str16
		syscall
		li $v0, 4
		la $a0, str17
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		sw $v0, 76($sp)
		li $v0, 5
		syscall
		sw $v0, 72($sp)
		la $t8, a
		lw $t8, 0($t8)
		move $a0, $t8
		lw $t8, 76($sp)
		move $a0, $t8
		lw $t8, 72($sp)
		move $a0, $t8
		li $a0, 4
		li $v0, 4
		la $a0, str18
		syscall
		li $v0, 4
		la $a0, str19
		syscall
		addi $v0, $sp, 64
		lw $t0, 4($v0)
		addi $v0, $sp, 64
		lw $t1, 4($v0)
		li $v1, 2
		add $t2, $t1, $v1
		li $v0, 12
		sub $t3, $0, $v0
		mul $t4, $t2, $t3
		la $v1, _
		lw $v1, 0($v1)
		add $t5, $t4, $v1
		addi $v0, $sp, 64
		mulu $v1, $t5, 4
		add $v0, $v0, $v1
		lw $t6, 0($v0)
		mul $t7, $t0, $t6
		la $t8, default
		sw $t0, 4($t8)
		sub $t0, $0, $t7
		addi $v0, $sp, 64
		la $t8, default
		sw $t0, 8($t8)
		lw $t0, 0($v0)
		la $t8, default
		sw $t0, 12($t8)
		add $t0, $t0, $t0
		la $t8, default
		sw $t0, 16($t8)
		sub $t0, $0, $t0
		la $v1, a
		sw $t0, 0($v1)
		li $v0, 4
		la $a0, str20
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
		la $a0, str21
		syscall
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, str22
		syscall
		li $v0, 4
		la $a0, str23
		syscall
		li $v0, 0
		addi $v1, $sp, 56
		sw $v0, 0($v1)
label16:	
		addi $v0, $sp, 32
		lw $t0, 0($v0)
		bne $t0, 65, label18
		addi $v0, $sp, 32
		lw $t0, 0($v0)
		li $v0, 11
		move $a0, $t0
		syscall
		j label17
		nop
label18:	
		bne $t0, 45, label19
		addi $v0, $sp, 32
		lw $t0, 0($v0)
		li $v0, 4
		la $a0, str24
		syscall
		li $v0, 11
		move $a0, $t0
		syscall
		j label17
		nop
label19:	
		bne $t0, 47, label20
		addi $v0, $sp, 32
		lw $t0, 0($v0)
		li $v0, 11
		move $a0, $t0
		syscall
		j label17
		nop
label20:	
label17:	
		lw $v0, 56($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 56
		sw $t0, 0($v1)
		lw $v0, 56($sp)
		li $v1, 3
		sub $t0, $v0, $v1
		bltz $t0, label16
		nop
		li $v0, 4
		la $a0, str25
		syscall
		li $v0, 4
		la $a0, str26
		syscall
		li $v0, 43
		sub $t0, $0, $v0
		li $v0, 4
		la $a0, str27
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 97
		li $v1, 1
		add $t0, $v0, $v1
		sub $t1, $0, $t0
		li $v0, 4
		la $a0, str28
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 4
		la $a0, str29
		syscall
		li $t8, 97
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, str30
		syscall
		la $t8, charz
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, str31
		syscall
		li $v0, 4
		la $a0, str32
		syscall
		li $v0, 4
		la $a0, str33
		syscall
		lw $v0, 88($sp)
		lw $v1, 84($sp)
		sub $t0, $v0, $v1
		bnez $t0, label21
		nop
		beqz $t0, label22
		nop
		la $t8, int1
		lw $t8, 0($t8)
		move $a0, $t8
		la $t8, char1
		lw $t8, 0($t8)
		move $a1, $t8
		addi $v0, $sp, 64
		lw $t0, 4($v0)
		move $a2, $t0
		li $v0, 1
		move $a0, $t0
		syscall
label22:	
label21:	
		li $a0, 64
		li $a1, 97
		li $v0, 1
		sub $t0, $0, $v0
		li $v0, 57
		li $v1, 2
		mul $t1, $v0, $v1
		add $t2, $t0, $t1
		move $a2, $t2
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 5
		syscall
		sw $v0, 80($sp)
		li $v0, 5
		syscall
		la $v1, single
		sw $v0, 0($v1)
		li $v0, 12
		syscall
		la $v1, default
		sw $v0, 0($v1)
		lw $t8, 80($sp)
		move $a0, $t8
		la $t8, default
		lw $t8, 0($t8)
		move $a1, $t8
		la $t8, single
		lw $t8, 0($t8)
		move $a2, $t8
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, str34
		syscall
		li $v0, 4
		la $a0, str35
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
label23:	
		beqz $t16, label24
		nop
		la $v0, a
		lw $v0, 0($v0)
		li $v1, 1
		add $t0, $v0, $v1
		la $v1, a
		sw $t0, 0($v1)
label24:	
		lw $v0, 88($sp)
		lw $v1, 84($sp)
		sub $t0, $v0, $v1
		bnez $t0, label23
		nop
		la $t8, a
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
label25:	
		la $v0, a
		lw $v0, 0($v0)
		sub $t0, $0, $v0
		bne $t0, 0, label27
		li $v0, 4
		la $a0, str36
		syscall
		j label26
		nop
label27:	
label26:	
		li $v0, -1
		sub $t0, $0, $v0
		addi $v0, $sp, 64
		mulu $v1, $t0, 4
		add $v0, $v0, $v1
		lw $t1, 0($v0)
		sub $t2, $0, $t1
		li $v1, 9
		add $t3, $t2, $v1
		li $v1, -11
		add $t4, $t3, $v1
		bnez $t4, label25
		nop
		li $v0, 4
		la $a0, str37
		syscall
		li $v0, 4
		la $a0, str38
		syscall
		li $v0, 4
		la $a0, str39
		syscall
