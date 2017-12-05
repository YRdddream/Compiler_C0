		.data
		str0: .asciiz "Error1 "
		str1: .asciiz "Error2 "
		str2: .asciiz "Error3 "
		str3: .asciiz "The number is so small!"
		str4: .asciiz "Test do-while"
		str5: .asciiz "#Result of do-while is "
		str6: .asciiz "Test fibonacci"
		str7: .asciiz "#Result of fibonacci is "
		str8: .asciiz "Test relation operation"
		str9: .asciiz "a1 should be 0:"
		str10: .asciiz "a1 shouldn't be 0:"
		str11: .asciiz "a1 should beq 32:"
		str12: .asciiz "#Result of relation operation ends"
		str13: .asciiz "Test (void function&switch int)"
		str14: .asciiz "#Result of (void function&switch int) ends"
		str15: .asciiz "Test expression"
		str16: .asciiz "a should be 9:"
		str17: .asciiz "a should be 14:"
		str18: .asciiz "#Result of expression ends"
		str19: .asciiz "Test switch char"
		str20: .asciiz ""
		str21: .asciiz "#Result of switch char should be A-/"
		str22: .asciiz "Test print char"
		str23: .asciiz "1."
		str24: .asciiz "2."
		str25: .asciiz "3."
		str26: .asciiz "4."
		str27: .asciiz ""
		str28: .asciiz "#Result of print char ends"
		str29: .asciiz "Test multi-parameters"
		str30: .asciiz "#Result of multi-parameters ends"
		str31: .asciiz "Test single sentence"
		str32: .asciiz "test0"
		str33: .asciiz "#Result of single sentence ends"
		_: .word 0
		void1: .word 0
		int1: .word 1
		int2: .word 2
		char1: .word 49
		charZ: .word 90
		char9: .word 57
		a: .word 0
		b: .word 0
		c: .word 0
		_c: .space 16
		single: .word 0
		d: .word 0
		e: .word 0
		_e: .space 32


		.text
		.globl main
null_:
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


print_error_:
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($fp)
		lw $v1, 12($fp)
		bne $v1, 1, label1
		nop
		la $a0, str0
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 12($fp)
		syscall
		j label0
		nop
label1:
		lw $v1, 12($fp)
		bne $v1, 2, label2
		nop
		la $a0, str1
		li $v0, 4
		syscall
		li $v0, 1
		li $a0, 2
		syscall
		j label0
		nop
label2:
		lw $v1, 12($fp)
		bne $v1, 3, label3
		nop
		la $a0, str2
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 12($fp)
		syscall
		j label0
		nop
label3:
		lw $v1, 12($fp)
		bne $v1, 4, label4
		nop
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


fibonacci_:
		addi $sp, $sp, -48
		sw $ra, 44($sp)
		sw $fp, 40($sp)
		move $fp, $sp
		sw $a0, 48($fp)
		lw $v0, 48($fp)
		sub $t0, $v0, 0
		bgez $t0, label5
		nop
		la $a0, str3
		li $v0, 4
		syscall
		li $v0, 0
		sub $t0, $v0, 1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 44($sp)
		lw $fp, 40($sp)
		addi $sp, $sp, 48
		jr $ra
		nop
label5:
		lw $v0, 48($fp)
		sub $t1, $v0, 1
		bgtz $t1, label6
		nop
		lw $v0, 48($fp)
		move $sp, $fp
		lw $ra, 44($sp)
		lw $fp, 40($sp)
		addi $sp, $sp, 48
		jr $ra
		nop
label6:
		li $v0, 0
		sub $t0, $v0, 1
		li $v0, 0
		sub $t1, $v0, $t0
		lw $v0, 48($fp)
		sub $t2, $v0, $t1
		blez $t2, label7
		nop
		lw $v0, 48($fp)
		sub $t0, $v0, 1
		move $a0, $t0
		sw $t0, 36($fp)
		jal fibonacci_
		nop
		lw $t0, 36($fp)
		move $t1, $v0
		li $v0, 20
		sub $t2, $v0, 19
		lw $v0, 48($fp)
		div $t3, $v0, $t2
		sub $t4, $t3, 2
		move $a0, $t4
		sw $t0, 36($fp)
		sw $t1, 32($fp)
		sw $t2, 28($fp)
		sw $t3, 24($fp)
		sw $t4, 20($fp)
		jal fibonacci_
		nop
		lw $t0, 36($fp)
		lw $t1, 32($fp)
		lw $t2, 28($fp)
		lw $t3, 24($fp)
		lw $t4, 20($fp)
		move $t5, $v0
		li $v0, 1
		mul $t6, $v0, $t5
		add $t7, $t1, $t6
		move $v0, $t7
		move $sp, $fp
		lw $ra, 44($sp)
		lw $fp, 40($sp)
		addi $sp, $sp, 48
		jr $ra
		nop
label7:


mult_add_:
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		sw $a0, 20($fp)
		sw $a1, 24($fp)
		sw $a2, 28($fp)
		lw $v0, 20($fp)
		lw $v1, 24($fp)
		add $t0, $v0, $v1
		lw $v1, 28($fp)
		sub $t1, $t0, $v1
		move $v0, $t1
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop


main:
		addi $sp, $sp, -124
		sw $ra, 120($sp)
		sw $fp, 116($sp)
		move $fp, $sp
		li $v0, 42
		sw $v0, 72($fp)
		li $v0, 42
		sw $v0, 68($fp)
		sub $v1, $fp, 0
		li $v0, 0
		li $v0, 1
		sw $v0, 44($v1)
		sub $v1, $fp, 0
		li $v0, 0
		li $v0, 0
		sw $v0, 40($v1)
		la $v0, _
		lw $v0, 0($v0)
		la $v1, _
		lw $v1, 0($v1)
		add $t0, $v0, $v1
		mulu $v0, $t0, 4
		sub $v1, $fp, $v0
		li $v0, 3
		sw $v0, 52($v1)
		li $v0, 0
		sub $t1, $v0, 2
		sub $v1, $fp, 4
		li $v0, 4
		sw $t1, 52($v1)
		sub $v1, $fp, 0
		li $v0, 0
		li $v0, 65
		sw $v0, 24($v1)
		sub $v1, $fp, 4
		li $v0, 4
		li $v0, 45
		sw $v0, 24($v1)
		li $v0, 3
		add $t2, $v0, 0
		sub $t3, $t2, 1
		mulu $v0, $t3, 4
		sub $v1, $fp, $v0
		li $v0, 47
		sw $v0, 24($v1)
		li $a0, 11
		sw $t0, 112($fp)
		sw $t1, 108($fp)
		sw $t2, 104($fp)
		sw $t3, 100($fp)
		jal fibonacci_
		nop
		lw $t0, 112($fp)
		lw $t1, 108($fp)
		lw $t2, 104($fp)
		lw $t3, 100($fp)
		move $t4, $v0
		sub $v1, $fp, 0
		li $v0, 0
		la $v1, a
		add $v1, $v1, $v0
		sw $t4, 0($v1)
		la $a0, str4
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 64($fp)
		li $v0, 5
		syscall
		sw $v0, 60($fp)
label8:
		lw $v0, 40($fp)
		sub $t0, $v0, 4
		bgez $t0, label9
		nop
		lw $v0, 64($fp)
		lw $v1, 60($fp)
		add $t0, $v0, $v1
		lw $v0, 44($fp)
		mul $t1, $v0, $t0
		sub $v1, $fp, 0
		li $v0, 0
		sw $t1, 44($v1)
		lw $v0, 40($fp)
		add $t2, $v0, 1
		sub $v1, $fp, 0
		li $v0, 0
		sw $t2, 40($v1)
		j label8
		nop
label9:
		la $a0, str5
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 44($fp)
		syscall
		la $a0, str6
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 64($fp)
		lw $a0, 64($fp)
		jal fibonacci_
		nop
		move $t0, $v0
		la $a0, str7
		li $v0, 4
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		la $a0, str8
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 64($fp)
		la $v1, _
		lw $v1, 0($v1)
		lw $v0, 64($fp)
		sub $t0, $v0, $v1
		bnez $t0, label10
		nop
		la $a0, str9
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 64($fp)
		syscall
label10:
		la $v1, _
		lw $v1, 0($v1)
		lw $v0, 64($fp)
		sub $t0, $v0, $v1
		beqz $t0, label11
		nop
		la $a0, str10
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 64($fp)
		syscall
label11:
		li $v0, 48
		sub $t0, $v0, 16
		lw $v0, 64($fp)
		sub $t1, $v0, $t0
		bltz $t1, label12
		nop
		la $a0, str11
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 64($fp)
		syscall
label12:
		la $a0, str12
		li $v0, 4
		syscall
		la $a0, str13
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		sw $v0, 60($fp)
		li $v0, 5
		syscall
		sw $v0, 56($fp)
		la $v0, a
		lw $a0, 0($v0)
		jal print_error_
		nop
		jal null_
		nop
		lw $a0, 60($fp)
		jal print_error_
		nop
		lw $a0, 56($fp)
		jal print_error_
		nop
		li $a0, 4
		jal print_error_
		nop
		la $a0, str14
		li $v0, 4
		syscall
		la $a0, str15
		li $v0, 4
		syscall
		sub $v1, $fp, 4
		li $v0, 4
		lw $t0, 52($v1)
		li $v0, 0
		sub $t1, $v0, 12
		li $v0, 0
		mul $t2, $v0, $t1
		la $v1, _
		lw $v1, 0($v1)
		add $t3, $t2, $v1
		move $v0, $t3
		mul $v0, $v0, 4
		sub $v1, $fp, $v0
		lw $t4, 52($v1)
		mul $t5, $t0, $t4
		li $v0, 0
		sub $t6, $v0, $t5
		sub $v1, $fp, 0
		li $v0, 0
		lw $t7, 52($v1)
		add $v0, $t6, $t7
		sw $v0, 80($fp)
		lw $v0, 80($fp)
		la $v1, _
		lw $v1, 0($v1)
		sub $v0, $v0, $v1
		sw $v0, 76($fp)
		sub $v1, $fp, 0
		li $v0, 0
		la $v1, a
		add $v1, $v1, $v0
		lw $v0, 76($fp)
		sw $v0, 0($v1)
		la $a0, str16
		li $v0, 4
		syscall
		li $v0, 1
		la $v1, a
		lw $a0, 0($v1)
		syscall
		li $v0, 5
		add $t0, $v0, 9
		sub $v1, $fp, 0
		li $v0, 0
		la $v1, a
		add $v1, $v1, $v0
		sw $t0, 0($v1)
		la $a0, str17
		li $v0, 4
		syscall
		li $v0, 1
		la $v1, a
		lw $a0, 0($v1)
		syscall
		la $a0, str18
		li $v0, 4
		syscall
		la $a0, str19
		li $v0, 4
		syscall
		sub $v1, $fp, 0
		li $v0, 0
		li $v0, 0
		sw $v0, 40($v1)
label13:
		lw $v0, 40($fp)
		sub $t0, $v0, 3
		bgez $t0, label14
		nop
		lw $v0, 40($fp)
		mul $v0, $v0, 4
		sub $v1, $fp, $v0
		la $v1, a
		add $v1, $v1, $v0
		lw $t0, 0($v1)
		bne $t0, 65, label16
		nop
		lw $v0, 40($fp)
		mul $v0, $v0, 4
		sub $v1, $fp, $v0
		la $v1, a
		add $v1, $v1, $v0
		lw $t1, 0($v1)
		li $v0, 1
		move $a0, $t1
		syscall
		j label15
		nop
label16:
		bne $t0, 45, label17
		nop
		lw $v0, 40($fp)
		mul $v0, $v0, 4
		sub $v1, $fp, $v0
		la $v1, a
		add $v1, $v1, $v0
		lw $t1, 0($v1)
		la $a0, str20
		li $v0, 4
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		j label15
		nop
label17:
		bne $t0, 47, label18
		nop
		lw $v0, 40($fp)
		mul $v0, $v0, 4
		sub $v1, $fp, $v0
		la $v1, a
		add $v1, $v1, $v0
		lw $t1, 0($v1)
		li $v0, 1
		move $a0, $t1
		syscall
		j label15
		nop
label18:
label15:
		lw $v0, 40($fp)
		add $t0, $v0, 1
		sub $v1, $fp, 0
		li $v0, 0
		sw $t0, 40($v1)
		j label13
		nop
label14:
		la $a0, str21
		li $v0, 4
		syscall
		la $a0, str22
		li $v0, 4
		syscall
		li $v0, 0
		sub $t0, $v0, 48
		la $a0, str23
		li $v0, 4
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 97
		add $t0, $v0, 1
		sub $t1, $t0, 98
		la $a0, str24
		li $v0, 4
		syscall
		li $v0, 1
		move $a0, $t1
		syscall
		la $a0, str25
		li $v0, 4
		syscall
		li $v0, 11
		li $a0, 97
		syscall
		la $a0, str26
		li $v0, 4
		syscall
		li $v0, 11
		la $v1, charZ
		lw $a0, 0($v1)
		syscall
		la $a0, str27
		li $v0, 4
		syscall
		la $a0, str28
		li $v0, 4
		syscall
		la $a0, str29
		li $v0, 4
		syscall
		lw $v0, 72($fp)
		lw $v1, 68($fp)
		sub $t0, $v0, $v1
		bnez $t0, label19
		nop
		lw $v1, 72($fp)
		beqz $v1, label20
		nop
		la $v0, int1
		lw $a0, 0($v0)
		la $v0, char1
		lw $a1, 0($v0)
		sub $v1, $fp, 4
		li $v0, 4
		lw $t0, 52($v1)
		move $a2, $t0
		sw $t0, 112($fp)
		jal mult_add_
		nop
		lw $t0, 112($fp)
		move $t1, $v0
		li $v0, 1
		move $a0, $t1
		syscall
label20:
label19:
		li $v0, 42
		add $t0, $v0, 0
		move $a0, $t0
		sub $v1, $fp, 8
		li $v0, 8
		lw $t1, 24($v1)
		move $a1, $t1
		li $v0, 0
		sub $t2, $v0, 1
		li $v0, 57
		mul $t3, $v0, 2
		add $t4, $t2, $t3
		move $a2, $t4
		sw $t0, 112($fp)
		sw $t1, 108($fp)
		sw $t2, 104($fp)
		sw $t3, 100($fp)
		sw $t4, 96($fp)
		jal mult_add_
		nop
		lw $t0, 112($fp)
		lw $t1, 108($fp)
		lw $t2, 104($fp)
		lw $t3, 100($fp)
		lw $t4, 96($fp)
		move $t5, $v0
		li $v0, 1
		move $a0, $t5
		syscall
		li $v0, 5
		syscall
		sw $v0, 64($fp)
		li $v0, 5
		syscall
		la $v1, single
		sw $v0, 0($v1)
		li $v0, 12
		syscall
		sw $v0, 36($fp)
		lw $a0, 64($fp)
		lw $a1, 36($fp)
		la $v0, single
		lw $a2, 0($v0)
		jal mult_add_
		nop
		move $t0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		la $a0, str30
		li $v0, 4
		syscall
		la $a0, str31
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		la $v1, a
		sw $v0, 0($v1)
		la $v1, a
		lw $v1, 0($v1)
		beqz $v1, label21
		nop
		la $v0, a
		lw $v0, 0($v0)
		add $t0, $v0, 1
		sub $v1, $fp, 0
		li $v0, 0
		la $v1, a
		add $v1, $v1, $v0
		sw $t0, 0($v1)
label21:
		li $v0, 1
		la $v1, a
		lw $a0, 0($v1)
		syscall
		la $v0, a
		lw $v0, 0($v0)
		sub $t0, $v0, 0
		bne $t0, 0, label23
		nop
		la $a0, str32
		li $v0, 4
		syscall
		j label22
		nop
label23:
label22:
label24:
		sub $v1, $fp, 4
		li $v0, 4
		lw $t0, 52($v1)
		li $v0, 0
		sub $t1, $v0, $t0
		add $t2, $t1, 9
		li $v0, 0
		sub $t3, $v0, 11
		add $t4, $t2, $t3
		beqz $t4, label25
		nop
		j label24
		nop
label25:
		la $a0, str33
		li $v0, 4
		syscall
		sub $v1, $fp, 4
		li $v0, 4
		lw $t0, 24($v1)
		sub $v1, $fp, 0
		li $v0, 0
		sw $t0, 64($v1)
		li $v0, 10
		syscall


