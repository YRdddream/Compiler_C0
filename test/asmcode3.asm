		.data
		Str0:  .asciiz "variable defination passed!\n"
		Str1:  .asciiz "const defination passed!\n"
		Str2:  .asciiz "variable and const defination passed!\n"
		Str3:  .asciiz "a and b are equal.\n"
		Str4:  .asciiz "Please input a number (1-100): \n"
		Str5:  .asciiz "the max number is:\n"
		Str6:  .asciiz " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~\n"
		Str7:  .asciiz "please input the mode before test(1~3)\n"
		Str8:  .asciiz "Easy ..\n"
		Str9:  .asciiz "Middle\n"
		Str10:  .asciiz "Hard\n"
		Str11:  .asciiz "The reverse str of SaaaaabbabbEE is:\n"
		Str12:  .asciiz "The character a in str_test is encountered \n"
		Str13:  .asciiz "Please input four integers (>0, <1000)\n"
		Str14:  .asciiz "The value of aa is \n"
		Str15:  .asciiz "the number of ss[0] is \n"
		Str16:  .asciiz "Please input some numbers(non-zero,positive),the count is \n"
		Str17:  .asciiz "The sum of input numbers is \n"
		Str18:  .asciiz "    \n"
		Str19:  .asciiz "The cov of input number is \n"

		a:  .word 5
		m:  .word 51
		z:  .word 6
		b:  .word 10
		q:  .word 115
		p:  .word 116
		aa:  .word 0
		bb:  .word 0
		cc:  .word 0
		ss:  .space 4
		mm:  .word 0
		nn:  .word 0
		zz:  .word 0
		str_test:  .space 200
		number:  .space 120
		ra:  .word 0
		rb:  .word 0
		rc:  .word 0
		rd:  .word 0

		.text
		.globl main
f5:	
		addi $sp, $sp, -584
		sw $ra, 580($sp)
		sw $fp, 576($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str0
		syscall
		move $sp, $fp
		lw $ra, 580($sp)
		lw $fp, 576($sp)
		addi $sp, $sp, 584
		jr $ra
		nop
		move $sp, $fp
		lw $ra, 580($sp)
		lw $fp, 576($sp)
		addi $sp, $sp, 584
		jr $ra
		nop
constf5:	
		addi $sp, $sp, -48
		sw $ra, 44($sp)
		sw $fp, 40($sp)
		move $fp, $sp
		li $v1, 10
		sw $v1, 36($sp)
		li $v1, 2
		sw $v1, 32($sp)
		li $v1, 3
		sw $v1, 28($sp)
		li $v1, 100
		sw $v1, 24($sp)
		li $v1, 101
		sw $v1, 20($sp)
		li $v1, 102
		sw $v1, 16($sp)
		li $v1, 43
		sw $v1, 12($sp)
		li $v1, 45
		sw $v1, 8($sp)
		li $v1, 56
		sw $v1, 4($sp)
		li $v0, 4
		la $a0, Str1
		syscall
		move $sp, $fp
		lw $ra, 44($sp)
		lw $fp, 40($sp)
		addi $sp, $sp, 48
		jr $ra
		nop
defi:	
		addi $sp, $sp, -620
		sw $ra, 616($sp)
		sw $fp, 612($sp)
		move $fp, $sp
		sw $a0, 620($sp)
		li $v1, 10
		sw $v1, 608($sp)
		li $v1, 2
		sw $v1, 604($sp)
		li $v1, 3
		sw $v1, 600($sp)
		li $v1, 100
		sw $v1, 596($sp)
		li $v1, 101
		sw $v1, 592($sp)
		li $v1, 102
		sw $v1, 588($sp)
		li $v1, 43
		sw $v1, 584($sp)
		li $v1, 45
		sw $v1, 580($sp)
		li $v1, 56
		sw $v1, 576($sp)
		lw $v1, 620($sp)
		addi $t9, $sp, 572
		sw $v1, 0($t9)
		lw $v1, 620($sp)
		addi $t9, $sp, 524
		addi $t9, $t9, 20
		sw $v1, 0($t9)
		lw $v1, 596($sp)
		addi $t9, $sp, 572
		sw $v1, 0($t9)
		lw $v1, 592($sp)
		addi $t9, $sp, 4
		sw $v1, 0($t9)
		lw $v1, 584($sp)
		addi $t9, $sp, 40
		sw $v1, 0($t9)
		li $v0, 4
		la $a0, Str2
		syscall
		move $sp, $fp
		lw $ra, 616($sp)
		lw $fp, 612($sp)
		addi $sp, $sp, 620
		jr $ra
		nop
defi_test:	
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		move $fp, $sp
		jal f5
		nop
		jal constf5
		nop
		li $a0, 66
		jal defi
		nop
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
f1:	
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
f2:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		lw $t8, 12($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
f3:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		li $v1, 1
		li $t9, 9
		add $t0, $v1, $t9
		move $v0, $t0
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
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
		blez $t0, Label0
		nop
		lw $t8, 12($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label0:	
		lw $v1, 16($sp)
		lw $t9, 12($sp)
		sub $t0, $v1, $t9
		blez $t0, Label1
		nop
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label1:	
		li $v0, 4
		la $a0, Str3
		syscall
		lw $v1, 16($sp)
		sub $t0, $0, $v1
		lw $v1, 12($sp)
		sub $t1, $v1, $t0
		li $t9, 2
		div $t2, $t1, $t9
		move $v0, $t2
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
fun_def_test:	
		addi $sp, $sp, -40
		sw $ra, 36($sp)
		sw $fp, 32($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str4
		syscall
		li $v0, 5
		syscall
		sw $v0, 28($sp)
		lw $t8, 28($sp)
		move $a0, $t8
		jal f2
		nop
		move $t0, $v0
		sw $t0, 24($sp)
		jal f3
		nop
		lw $t0, 24($sp)
		move $t1, $v0
		move $a0, $t0
		move $a1, $t1
		sw $t0, 24($sp)
		sw $t1, 20($sp)
		jal max
		nop
		lw $t0, 24($sp)
		lw $t1, 20($sp)
		move $t2, $v0
		li $v0, 4
		la $a0, Str5
		syscall
		li $v0, 1
		move $a0, $t2
		syscall
		li $a0, 5
		li $a1, 5
		jal max
		nop
		move $t0, $v0
		move $a0, $t0
		li $a1, 5
		sw $t0, 24($sp)
		jal max
		nop
		lw $t0, 24($sp)
		move $t1, $v0
		move $a0, $t1
		li $a1, 5
		sw $t0, 24($sp)
		sw $t1, 20($sp)
		jal max
		nop
		lw $t0, 24($sp)
		lw $t1, 20($sp)
		move $t2, $v0
		addi $t9, $sp, 28
		sw $t2, 0($t9)
		jal f1
		nop
		move $sp, $fp
		lw $ra, 36($sp)
		lw $fp, 32($sp)
		addi $sp, $sp, 40
		jr $ra
		nop
calcu:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		sw $a0, 20($sp)
		li $v1, 0
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label2:	
		la $v1, number
		lw $t9, 8($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $v1, 4($sp)
		add $t1, $v1, $t0
		addi $t9, $sp, 4
		sw $t1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 8
		sw $t0, 0($t9)
		lw $v1, 8($sp)
		lw $t9, 20($sp)
		sub $t0, $v1, $t9
		bltz $t0, Label2
		nop
		lw $t8, 4($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
calcucov:	
		addi $sp, $sp, -24
		sw $ra, 20($sp)
		sw $fp, 16($sp)
		move $fp, $sp
		sw $a0, 24($sp)
		sw $a1, 28($sp)
		li $v1, 0
		addi $t9, $sp, 12
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 8
		sw $v1, 0($t9)
Label3:	
		la $v1, number
		lw $t9, 12($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $t9, 28($sp)
		sub $t1, $t0, $t9
		la $v1, number
		lw $t9, 12($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t2, 0($v1)
		lw $t9, 28($sp)
		sub $t3, $t2, $t9
		mul $t4, $t1, $t3
		addi $t9, $sp, 4
		sw $t4, 0($t9)
		lw $v1, 8($sp)
		lw $t9, 4($sp)
		add $t0, $v1, $t9
		addi $t9, $sp, 8
		sw $t0, 0($t9)
		lw $v1, 12($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 12
		sw $t0, 0($t9)
		lw $v1, 12($sp)
		lw $t9, 24($sp)
		sub $t0, $v1, $t9
		bltz $t0, Label3
		nop
		lw $t8, 8($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
partion:	
		addi $sp, $sp, -28
		sw $ra, 24($sp)
		sw $fp, 20($sp)
		move $fp, $sp
		sw $a0, 28($sp)
		sw $a1, 32($sp)
		la $v1, number
		lw $t9, 32($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		addi $t9, $sp, 8
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label4:	
		la $v1, number
		lw $t9, 4($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		lw $t9, 16($sp)
		sub $t1, $t0, $t9
		bgtz $t1, Label5
		nop
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 8
		sw $t0, 0($t9)
		la $v1, number
		lw $t9, 8($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		addi $t9, $sp, 12
		sw $t0, 0($t9)
		la $v1, number
		lw $t9, 4($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		la $t9, number
		lw $t8, 8($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $t0, 0($t9)
		lw $v1, 12($sp)
		la $t9, number
		lw $t8, 4($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
Label5:	
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		lw $v1, 4($sp)
		lw $t9, 32($sp)
		sub $t0, $v1, $t9
		bltz $t0, Label4
		nop
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		la $v1, number
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		addi $t9, $sp, 12
		sw $t1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		la $v1, number
		lw $t9, 32($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		la $t9, number
		mulu $t0, $t0, 4
		add $t9, $t9, $t0
		sw $t1, 0($t9)
		lw $v1, 12($sp)
		la $t9, number
		lw $t8, 32($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		move $v0, $t0
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
quick_sort:	
		addi $sp, $sp, -40
		sw $ra, 36($sp)
		sw $fp, 32($sp)
		move $fp, $sp
		sw $a0, 40($sp)
		sw $a1, 44($sp)
		lw $v1, 40($sp)
		lw $t9, 44($sp)
		sub $t0, $v1, $t9
		bgez $t0, Label6
		nop
		lw $t8, 40($sp)
		move $a0, $t8
		lw $t8, 44($sp)
		move $a1, $t8
		jal partion
		nop
		move $t0, $v0
		addi $t9, $sp, 28
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		lw $t8, 40($sp)
		move $a0, $t8
		move $a1, $t0
		sw $t0, 24($sp)
		jal quick_sort
		nop
		lw $t0, 24($sp)
		lw $v1, 28($sp)
		li $t9, 1
		add $t1, $v1, $t9
		move $a0, $t1
		lw $t8, 44($sp)
		move $a1, $t8
		sw $t0, 24($sp)
		sw $t1, 20($sp)
		jal quick_sort
		nop
		lw $t0, 24($sp)
		lw $t1, 20($sp)
Label6:	
		move $sp, $fp
		lw $ra, 36($sp)
		lw $fp, 32($sp)
		addi $sp, $sp, 40
		jr $ra
		nop
reverse:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		sw $a0, 20($sp)
		li $v1, 0
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label7:	
		la $v1, str_test
		lw $t9, 4($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		addi $t9, $sp, 8
		sw $t0, 0($t9)
		lw $v1, 20($sp)
		lw $t9, 4($sp)
		sub $t0, $v1, $t9
		la $v1, str_test
		mulu $t9, $t0, 4
		add $v1, $v1, $t9
		lw $t1, 0($v1)
		la $t9, str_test
		lw $t8, 4($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $t1, 0($t9)
		lw $v1, 20($sp)
		lw $t9, 4($sp)
		sub $t0, $v1, $t9
		lw $v1, 8($sp)
		la $t9, str_test
		mulu $t0, $t0, 4
		add $t9, $t9, $t0
		sw $v1, 0($t9)
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		lw $v1, 20($sp)
		li $t9, 2
		div $t0, $v1, $t9
		lw $v1, 4($sp)
		sub $t1, $v1, $t0
		bltz $t1, Label7
		nop
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
charcount:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v1, 0
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label8:	
		la $v1, str_test
		lw $t9, 4($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		bne $t0, 83, Label10
		nop
Label11:	
		la $v1, str_test
		lw $t9, 4($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $t9, 97
		sub $t1, $t0, $t9
		bnez $t1, Label12
		nop
		lw $v1, 8($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 8
		sw $t0, 0($t9)
Label12:	
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		lw $v1, 4($sp)
		li $t9, 10
		sub $t0, $v1, $t9
		blez $t0, Label11
		nop
		j Label9
		nop
Label10:	
		bne $t0, 69, Label13
		nop
		lw $t8, 8($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
		j Label9
		nop
Label13:	
Label9:	
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		li $t8, 1
		bnez $t8, Label8
		nop
other_test1:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str6
		syscall
		li $v0, 4
		la $a0, Str7
		syscall
		li $v0, 12
		syscall
		sw $v0, 8($sp)
		lw $v1, 8($sp)
		bne $v1, 49, Label15
		nop
		li $v0, 4
		la $a0, Str8
		syscall
		j Label14
		nop
Label15:	
		lw $v1, 8($sp)
		bne $v1, 50, Label16
		nop
		li $v0, 4
		la $a0, Str9
		syscall
		j Label14
		nop
Label16:	
		lw $v1, 8($sp)
		bne $v1, 51, Label17
		nop
		li $v0, 4
		la $a0, Str10
		syscall
		j Label14
		nop
Label17:	
Label14:	
		li $v1, 83
		la $t9, str_test
		addi $t9, $t9, 0
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 4
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 8
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 12
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 16
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 20
		sw $v1, 0($t9)
		li $v1, 98
		la $t9, str_test
		addi $t9, $t9, 24
		sw $v1, 0($t9)
		li $v1, 98
		la $t9, str_test
		addi $t9, $t9, 28
		sw $v1, 0($t9)
		li $v1, 97
		la $t9, str_test
		addi $t9, $t9, 32
		sw $v1, 0($t9)
		li $v1, 98
		la $t9, str_test
		addi $t9, $t9, 36
		sw $v1, 0($t9)
		li $v1, 98
		la $t9, str_test
		addi $t9, $t9, 40
		sw $v1, 0($t9)
		li $v1, 69
		la $t9, str_test
		addi $t9, $t9, 44
		sw $v1, 0($t9)
		li $v1, 69
		la $t9, str_test
		addi $t9, $t9, 48
		sw $v1, 0($t9)
		li $a0, 12
		jal reverse
		nop
		li $v0, 4
		la $a0, Str11
		syscall
		la $v1, str_test
		lw $t0, 0($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 4($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 8($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 12($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 16($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 20($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 24($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 28($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 32($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 36($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 40($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 44($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		la $v1, str_test
		lw $t0, 48($v1)
		li $v0, 11
		move $a0, $t0
		syscall
		jal charcount
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str12
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
other_test2:	
		addi $sp, $sp, -60
		sw $ra, 56($sp)
		sw $fp, 52($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str13
		syscall
		li $v0, 5
		syscall
		la $v1, ra
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		la $v1, rb
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		la $v1, rc
		sw $v0, 0($v1)
		li $v0, 5
		syscall
		la $v1, rd
		sw $v0, 0($v1)
		la $v1, a
		lw $v1, 0($v1)
		sub $t0, $0, $v1
		la $t9, m
		lw $t9, 0($t9)
		add $t1, $t0, $t9
		la $v1, a
		lw $v1, 0($v1)
		add $t2, $v1, $t1
		la $t9, aa
		sw $t2, 0($t9)
		li $v0, 4
		la $a0, Str14
		syscall
		la $t8, aa
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		la $v1, a
		lw $v1, 0($v1)
		sub $t0, $0, $v1
		la $v1, a
		lw $v1, 0($v1)
		add $t1, $v1, $t0
		la $t9, ss
		addi $t9, $t9, 0
		sw $t1, 0($t9)
		la $v1, ss
		lw $t0, 0($v1)
		li $v0, 4
		la $a0, Str15
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		la $v1, rb
		lw $v1, 0($v1)
		la $t9, rc
		lw $t9, 0($t9)
		mul $t0, $v1, $t9
		la $v1, ra
		lw $v1, 0($v1)
		add $t1, $v1, $t0
		la $t9, rd
		lw $t9, 0($t9)
		add $t2, $t1, $t9
		la $v1, rb
		lw $v1, 0($v1)
		la $t9, rc
		lw $t9, 0($t9)
		mul $t3, $v1, $t9
		la $v1, ra
		lw $v1, 0($v1)
		la $t9, rd
		lw $t9, 0($t9)
		add $t4, $v1, $t9
		add $t5, $t3, $t4
		li $t9, 88
		add $t6, $t5, $t9
		div $t7, $t2, $t6
		la $t8, ra
		lw $t8, 0($t8)
		move $a0, $t8
		la $t8, rb
		lw $t8, 0($t8)
		move $a1, $t8
		sw $t0, 40($sp)
		sw $t1, 36($sp)
		sw $t2, 32($sp)
		sw $t3, 28($sp)
		sw $t4, 24($sp)
		sw $t5, 20($sp)
		sw $t6, 16($sp)
		sw $t7, 12($sp)
		jal max
		nop
		lw $t0, 40($sp)
		lw $t1, 36($sp)
		lw $t2, 32($sp)
		lw $t3, 28($sp)
		lw $t4, 24($sp)
		lw $t5, 20($sp)
		lw $t6, 16($sp)
		lw $t7, 12($sp)
		la $t8, rd
		sw $t0, 4($t8)
		move $t0, $v0
		la $t8, rd
		sw $t1, 8($t8)
		add $t1, $t7, $t0
		la $v1, ss
		la $t8, rd
		sw $t2, 12($t8)
		lw $t2, 0($v1)
		la $v1, str_test
		mulu $t9, $t2, 4
		la $t8, rd
		sw $t3, 16($t8)
		add $v1, $v1, $t9
		lw $t3, 0($v1)
		la $t8, rd
		sw $t4, 20($t8)
		sub $t4, $t1, $t3
		li $t9, 72
		la $t8, rd
		sw $t5, 24($t8)
		add $t5, $t4, $t9
		li $t9, -70
		la $t8, rd
		sw $t6, 28($t8)
		add $t6, $t5, $t9
		la $t9, ra
		sw $t6, 0($t9)
Label18:	
		la $v1, ra
		lw $v1, 0($v1)
		li $t9, -10
		add $t0, $v1, $t9
		la $t9, ra
		sw $t0, 0($t9)
		la $v1, ra
		lw $v1, 0($v1)
		li $t9, 20
		sub $t0, $v1, $t9
		bgtz $t0, Label18
		nop
		la $v1, ra
		lw $v1, 0($v1)
		li $t9, 20
		sub $t0, $v1, $t9
		bgez $t0, Label19
		nop
		li $v1, 10
		li $t9, 0
		add $t0, $v1, $t9
		la $t9, ra
		sw $t0, 0($t9)
Label19:	
		li $v0, 4
		la $a0, Str16
		syscall
		la $t8, ra
		lw $t8, 0($t8)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v1, 0
		addi $t9, $sp, 48
		sw $v1, 0($t9)
Label20:	
		li $v0, 5
		syscall
		sw $v0, 44($sp)
		lw $v1, 44($sp)
		la $t9, number
		lw $t8, 48($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		la $v1, number
		lw $t9, 48($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		beqz $t0, Label21
		nop
		lw $v1, 48($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 48
		sw $t0, 0($t9)
Label21:	
		lw $v1, 48($sp)
		la $t9, ra
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		bltz $t0, Label20
		nop
		move $sp, $fp
		lw $ra, 56($sp)
		lw $fp, 52($sp)
		addi $sp, $sp, 60
		jr $ra
		nop
main:	
		addi $sp, $sp, -40
		sw $ra, 36($sp)
		sw $fp, 32($sp)
		move $fp, $sp
		jal other_test1
		nop
		jal other_test2
		nop
		la $t8, ra
		lw $t8, 0($t8)
		move $a0, $t8
		jal calcu
		nop
		move $t0, $v0
		addi $t9, $sp, 24
		sw $t0, 0($t9)
		lw $v1, 24($sp)
		la $t9, ra
		lw $t9, 0($t9)
		div $t0, $v1, $t9
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		la $t8, ra
		lw $t8, 0($t8)
		move $a0, $t8
		lw $t8, 16($sp)
		move $a1, $t8
		jal calcucov
		nop
		move $t0, $v0
		addi $t9, $sp, 20
		sw $t0, 0($t9)
		lw $v1, 20($sp)
		la $t9, ra
		lw $t9, 0($t9)
		div $t0, $v1, $t9
		addi $t9, $sp, 20
		sw $t0, 0($t9)
		li $v0, 4
		la $a0, Str17
		syscall
		lw $t8, 24($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str18
		syscall
		li $v0, 4
		la $a0, Str19
		syscall
		lw $t8, 20($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		la $v1, ra
		lw $v1, 0($v1)
		li $t9, 1
		sub $t0, $v1, $t9
		li $a0, 0
		move $a1, $t0
		sw $t0, 12($sp)
		jal quick_sort
		nop
		lw $t0, 12($sp)
		li $v1, 0
		addi $t9, $sp, 28
		sw $v1, 0($t9)
Label22:	
		la $v1, number
		lw $t9, 28($sp)
		mulu $t9, $t9, 4
		add $v1, $v1, $t9
		lw $t0, 0($v1)
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v1, 28($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 28
		sw $t0, 0($t9)
		lw $v1, 28($sp)
		la $t9, ra
		lw $t9, 0($t9)
		sub $t0, $v1, $t9
		bltz $t0, Label22
		nop
		jal fun_def_test
		nop
		jal defi_test
		nop
