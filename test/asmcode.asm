		.data
		Str0:  .asciiz "define test passed\n"
		Str1:  .asciiz "operator test passed\n"
		Str2:  .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\n"
		Str3:  .asciiz "!#$%&'()*+,-./:;<=>?@[]^_`{|}~\n"
		Str4:  .asciiz "dowhile test passed\n"
		Str5:  .asciiz "ifcondition clause error!\n"
		Str6:  .asciiz "ifcondition clause error\n"
		Str7:  .asciiz "switchcodintion clause  error!\n"
		Str8:  .asciiz "switchcodintion clause  error!\n"
		Str9:  .asciiz "error 0\n"
		Str10:  .asciiz "error 1\n"
		Str11:  .asciiz "error 2\n"
		Str12:  .asciiz "condition test passed\n"
		Str13:  .asciiz "miscellaneous test passed\n"
		Str14:  .asciiz "Fibonaci: Please input a unsigned positive integer ?\n"
		Str15:  .asciiz "Input error, try again:\n"
		Str16:  .asciiz "The fibonaci's answer is \n"
		Str17:  .asciiz "GCD: Please input two unsigned positive integer ?\n"
		Str18:  .asciiz "Input error, try Again: \n"
		Str19:  .asciiz "The gcd's answer is \n"
		Str20:  .asciiz "1\n"
		Str21:  .asciiz "*\n"
		Str22:  .asciiz "*\n"
		Str23:  .asciiz "prime_factorization: Please input a unsigned positive integer(<2^31-1) ?\n"
		Str24:  .asciiz "Input error, try again:\n"
		Str25:  .asciiz "The factor of n is \n"
		Str26:  .asciiz "Please input Test Type:E(Easy), (M)Middle, H(Hard): \n"
		Str27:  .asciiz "Try Again: \n"

		cst1:  .word 1
		cst2:  .word 2
		cst3:  .word 3
		csta:  .word 97
		cstb:  .word 98
		cstc:  .word 99
		g_a:  .word 0
		g_b:  .word 0
		g_arr:  .space 8192
		g_stra:  .space 4096
		g_strb:  .space 8192

		.text
		.globl main
const_define:	
		addi $sp, $sp, -44
		sw $ra, 40($sp)
		sw $fp, 36($sp)
		move $fp, $sp
		li $v1, 1
		sw $v1, 32($sp)
		li $v1, 0
		sw $v1, 28($sp)
		li $v1, -1
		sw $v1, 24($sp)
		li $v1, 120
		sw $v1, 20($sp)
		li $v1, 122
		sw $v1, 16($sp)
		li $v1, 65
		sw $v1, 12($sp)
		li $v1, 49
		sw $v1, 8($sp)
		li $v1, 47
		sw $v1, 4($sp)
		lw $t8, 32($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		lw $t8, 4($sp)
		li $v0, 11
		move $a0, $t8
		syscall
		move $sp, $fp
		lw $ra, 40($sp)
		lw $fp, 36($sp)
		addi $sp, $sp, 44
		jr $ra
		nop
const_define_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal const_define
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
var_define:	
		addi $sp, $sp, -92
		sw $ra, 88($sp)
		sw $fp, 84($sp)
		move $fp, $sp
		move $sp, $fp
		lw $ra, 88($sp)
		lw $fp, 84($sp)
		addi $sp, $sp, 92
		jr $ra
		nop
var_define_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal var_define
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
define:	
		addi $sp, $sp, -36
		sw $ra, 32($sp)
		sw $fp, 28($sp)
		move $fp, $sp
		li $v1, 1
		sw $v1, 24($sp)
		li $v1, 122
		sw $v1, 20($sp)
		li $v1, 65
		sw $v1, 16($sp)
		move $sp, $fp
		lw $ra, 32($sp)
		lw $fp, 28($sp)
		addi $sp, $sp, 36
		jr $ra
		nop
define_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal var_define_test
		nop
		jal const_define_test
		nop
		jal define
		nop
		li $v0, 4
		la $a0, Str0
		syscall
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
operator:	
		addi $sp, $sp, -36
		sw $ra, 32($sp)
		sw $fp, 28($sp)
		move $fp, $sp
		li $v1, 1
		addi $t9, $sp, 24
		sw $v1, 0($t9)
		li $v1, 1
		li $t9, 2
		add $t0, $v1, $t9
		addi $t9, $sp, 20
		sw $t0, 0($t9)
		li $v1, 3
		li $t9, 1
		mul $t0, $v1, $t9
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		li $v1, 4
		sub $t0, $0, $v1
		addi $t9, $sp, 12
		sw $t0, 0($t9)
		li $v1, 5
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 6
		addi $t9, $sp, 4
		sw $v1, 0($t9)
		lw $v1, 20($sp)
		li $t9, 3
		mul $t0, $v1, $t9
		lw $t9, 16($sp)
		add $t1, $t0, $t9
		lw $v1, 12($sp)
		li $t9, 4
		div $t2, $v1, $t9
		sub $t3, $t1, $t2
		lw $v1, 24($sp)
		lw $t9, 24($sp)
		div $t4, $v1, $t9
		add $t5, $t3, $t4
		addi $t9, $sp, 24
		sw $t5, 0($t9)
		li $v1, 0
		lw $t9, 24($sp)
		add $t0, $v1, $t9
		lw $v1, 24($sp)
		li $t9, 3
		mul $t1, $v1, $t9
		add $t2, $t0, $t1
		lw $t9, 16($sp)
		add $t3, $t2, $t9
		lw $v1, 12($sp)
		li $t9, 4
		div $t4, $v1, $t9
		sub $t5, $t3, $t4
		lw $v1, 8($sp)
		lw $t9, 4($sp)
		mul $t6, $v1, $t9
		add $t7, $t5, $t6
		addi $t9, $sp, 20
		sw $t7, 0($t9)
		lw $v1, 24($sp)
		sub $t0, $0, $v1
		lw $v1, 20($sp)
		li $t9, 0
		mul $t1, $v1, $t9
		add $t2, $t0, $t1
		li $v1, 1
		li $t9, 0
		sub $t3, $v1, $t9
		sub $t4, $t2, $t3
		addi $t9, $sp, 8
		sw $t4, 0($t9)
		move $sp, $fp
		lw $ra, 32($sp)
		lw $fp, 28($sp)
		addi $sp, $sp, 36
		jr $ra
		nop
operator_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal operator
		nop
		li $v0, 4
		la $a0, Str1
		syscall
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
string:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str2
		syscall
		li $v0, 4
		la $a0, Str3
		syscall
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
string_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal string
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
dowhile:	
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		move $fp, $sp
		li $v1, 100
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label0:	
		lw $v1, 4($sp)
		li $t9, 50
		sub $t0, $v1, $t9
		bltz $t0, Label1
		nop
		lw $v1, 4($sp)
		li $t9, 2
		div $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label1:	
		lw $v1, 4($sp)
		li $t9, 50
		sub $t0, $v1, $t9
		bgez $t0, Label2
		nop
		lw $v1, 4($sp)
		li $t9, 10
		add $t0, $v1, $t9
		li $t9, 10
		div $t1, $t0, $t9
		addi $t9, $sp, 4
		sw $t1, 0($t9)
Label2:	
		lw $v1, 4($sp)
		li $t9, 10
		sub $t0, $v1, $t9
		bgez $t0, Label0
		nop
Label3:	
		lw $v1, 4($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		li $v0, 4
		la $a0, Str4
		syscall
		li $t8, 0
		bnez $t8, Label3
		nop
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
dowhile_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal dowhile
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
ifcondition:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v1, 1
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 4
		sw $v1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bnez $t0, Label4
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label4:	
		li $v1, 2
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		blez $t0, Label5
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label5:	
		li $v1, 0
		addi $t9, $sp, 8
		sw $v1, 0($t9)
		lw $v1, 8($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bgez $t0, Label6
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label6:	
		lw $v1, 8($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		beqz $t0, Label7
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label7:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bltz $t0, Label8
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label8:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgtz $t0, Label9
		nop
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
Label9:	
		li $v1, 1
		li $t9, 1
		add $t0, $v1, $t9
		li $t9, 1
		add $t1, $t0, $t9
		li $v1, 1
		li $t9, 3
		mul $t2, $v1, $t9
		add $t3, $t1, $t2
		lw $v1, 4($sp)
		sub $t4, $v1, $t3
		beqz $t4, Label10
		nop
		li $v0, 4
		la $a0, Str5
		syscall
Label10:	
		lw $v1, 4($sp)
		lw $t9, 4($sp)
		sub $t0, $v1, $t9
		beqz $t0, Label11
		nop
		li $v0, 4
		la $a0, Str6
		syscall
Label11:	
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
switchcodintionans:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		lw $v1, 12($sp)
		bne $v1, 1, Label13
		nop
		li $t8, 2
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
		j Label12
		nop
Label13:	
		lw $v1, 12($sp)
		bne $v1, 2, Label14
		nop
		li $t8, 3
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
		j Label12
		nop
Label14:	
		lw $v1, 12($sp)
		bne $v1, 3, Label15
		nop
		li $t8, 4
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
		j Label12
		nop
Label15:	
Label12:	
		li $t8, 5
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
switchcodintion:	
		addi $sp, $sp, -28
		sw $ra, 24($sp)
		sw $fp, 20($sp)
		move $fp, $sp
		li $v1, 1
		addi $t9, $sp, 16
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 12
		sw $v1, 0($t9)
Label16:	
		lw $v1, 16($sp)
		li $t9, 1
		add $t0, $v1, $t9
		lw $t8, 16($sp)
		move $a0, $t8
		sw $t0, 8($sp)
		jal switchcodintionans
		nop
		lw $t0, 8($sp)
		move $t1, $v0
		sub $t2, $t0, $t1
		bnez $t2, Label17
		nop
		lw $v1, 12($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 12
		sw $t0, 0($t9)
Label17:	
		lw $v1, 16($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		lw $v1, 16($sp)
		li $t9, 5
		sub $t0, $v1, $t9
		bltz $t0, Label16
		nop
		lw $v1, 12($sp)
		li $t9, 4
		sub $t0, $v1, $t9
		beqz $t0, Label18
		nop
		li $v0, 4
		la $a0, Str7
		syscall
Label18:	
		lw $t8, 12($sp)
		beqz $t8, Label19
		nop
		lw $t8, 16($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
Label19:	
		li $v0, 4
		la $a0, Str8
		syscall
condition:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v1, 5
		sw $v1, 8($sp)
		li $v1, 0
		addi $t9, $sp, 4
		sw $v1, 0($t9)
Label20:	
		lw $v1, 4($sp)
		bne $v1, 0, Label22
		nop
		lw $v1, 4($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		beqz $t0, Label23
		nop
		li $v0, 4
		la $a0, Str9
		syscall
Label23:	
		j Label21
		nop
Label22:	
		lw $v1, 4($sp)
		bne $v1, 1, Label24
		nop
		lw $v1, 4($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		beqz $t0, Label25
		nop
		li $v0, 4
		la $a0, Str10
		syscall
Label25:	
		j Label21
		nop
Label24:	
		lw $v1, 4($sp)
		bne $v1, 2, Label26
		nop
		lw $v1, 4($sp)
		li $t9, 2
		sub $t0, $v1, $t9
		beqz $t0, Label27
		nop
		li $v0, 4
		la $a0, Str11
		syscall
Label27:	
		j Label21
		nop
Label26:	
Label21:	
		lw $v1, 4($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 4
		sw $t0, 0($t9)
		lw $v1, 4($sp)
		lw $t9, 8($sp)
		sub $t0, $v1, $t9
		bltz $t0, Label20
		nop
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
condition_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal ifcondition
		nop
		jal switchcodintion
		nop
		jal condition
		nop
		li $v0, 4
		la $a0, Str12
		syscall
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
miscellaneous:	
		addi $sp, $sp, -1148
		sw $ra, 1144($sp)
		sw $fp, 1140($sp)
		move $fp, $sp
		li $v1, 1
		addi $t9, $sp, 1136
		sw $v1, 0($t9)
		li $v1, 2
		addi $t9, $sp, 1132
		sw $v1, 0($t9)
Label28:	
		lw $v1, 1036($sp)
		addi $t9, $sp, 1040
		lw $t8, 1036($sp)
		mulu $t8, $t8, 4
		add $t9, $t9, $t8
		sw $v1, 0($t9)
		lw $v1, 1036($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 1036
		sw $t0, 0($t9)
		lw $v1, 1036($sp)
		li $t9, 23
		sub $t0, $v1, $t9
		bltz $t0, Label28
		nop
		li $v1, 97
		addi $t9, $sp, 1028
		sw $v1, 0($t9)
		li $v1, 127
		addi $t9, $sp, 1036
		sw $v1, 0($t9)
		lw $v1, 1036($sp)
		addi $t9, $sp, 1032
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 1136
		sw $v1, 0($t9)
Label29:	
		lw $v1, 1136($sp)
		li $t9, 1
		mul $t0, $v1, $t9
		lw $t9, 1136($sp)
		sub $t1, $t0, $t9
		li $t9, 1
		sub $t2, $t1, $t9
		li $v1, 2
		li $t9, 1
		div $t3, $v1, $t9
		add $t4, $t2, $t3
		li $t9, 1
		sub $t5, $t4, $t9
		li $t9, 2
		div $t6, $t5, $t9
		li $v1, 97
		addi $t9, $sp, 4
		mulu $t6, $t6, 4
		add $t9, $t9, $t6
		sw $v1, 0($t9)
		lw $v1, 1136($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 1136
		sw $t0, 0($t9)
		lw $v1, 1136($sp)
		lw $t9, 1032($sp)
		sub $t0, $v1, $t9
		bltz $t0, Label29
		nop
		addi $v1, $sp, 4
		lw $t0, 0($v1)
		li $t9, 97
		sub $t1, $t0, $t9
		bnez $t1, Label30
		nop
		li $v0, 4
		la $a0, Str13
		syscall
Label30:	
		move $sp, $fp
		lw $ra, 1144($sp)
		lw $fp, 1140($sp)
		addi $sp, $sp, 1148
		jr $ra
		nop
miscellaneous_test:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		jal miscellaneous
		nop
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
fibonaci:	
		addi $sp, $sp, -28
		sw $ra, 24($sp)
		sw $fp, 20($sp)
		move $fp, $sp
		sw $a0, 28($sp)
		lw $v1, 28($sp)
		bne $v1, 0, Label32
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
		j Label31
		nop
Label32:	
		lw $v1, 28($sp)
		bne $v1, 1, Label33
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
		j Label31
		nop
Label33:	
		lw $v1, 28($sp)
		bne $v1, 2, Label34
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
		j Label31
		nop
Label34:	
Label31:	
		lw $v1, 28($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		move $a0, $t0
		sw $t0, 16($sp)
		jal fibonaci
		nop
		lw $t0, 16($sp)
		move $t1, $v0
		lw $v1, 28($sp)
		li $t9, 2
		sub $t2, $v1, $t9
		move $a0, $t2
		sw $t0, 16($sp)
		sw $t1, 12($sp)
		sw $t2, 8($sp)
		jal fibonaci
		nop
		lw $t0, 16($sp)
		lw $t1, 12($sp)
		lw $t2, 8($sp)
		move $t3, $v0
		add $t4, $t1, $t3
		move $v0, $t4
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
fibonaci_test:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str14
		syscall
		li $v0, 5
		syscall
		sw $v0, 8($sp)
Label35:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgez $t0, Label36
		nop
		li $v0, 4
		la $a0, Str15
		syscall
		li $v0, 5
		syscall
		sw $v0, 8($sp)
Label36:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bltz $t0, Label37
		nop
		lw $t8, 8($sp)
		move $a0, $t8
		jal fibonaci
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str16
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
Label37:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bltz $t0, Label35
		nop
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
mod:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		lw $v1, 12($sp)
		lw $t9, 16($sp)
		div $t0, $v1, $t9
		lw $t9, 16($sp)
		mul $t1, $t0, $t9
		lw $v1, 12($sp)
		sub $t2, $v1, $t1
		move $v0, $t2
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
gcd:	
		addi $sp, $sp, -28
		sw $ra, 24($sp)
		sw $fp, 20($sp)
		move $fp, $sp
		sw $a0, 28($sp)
		sw $a1, 32($sp)
		li $v1, 0
		addi $t9, $sp, 16
		sw $v1, 0($t9)
		lw $v1, 28($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bnez $t0, Label38
		nop
		lw $t8, 32($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
Label38:	
		lw $v1, 32($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bnez $t0, Label39
		nop
		lw $t8, 28($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
Label39:	
		lw $t8, 28($sp)
		move $a0, $t8
		lw $t8, 32($sp)
		move $a1, $t8
		jal mod
		nop
		move $t0, $v0
		lw $t8, 32($sp)
		move $a0, $t8
		move $a1, $t0
		sw $t0, 12($sp)
		jal gcd
		nop
		lw $t0, 12($sp)
		move $t1, $v0
		move $v0, $t1
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
iswronggcd:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		lw $v1, 12($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgtz $t0, Label40
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label40:	
		lw $v1, 16($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgtz $t0, Label41
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label41:	
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
gcd_test:	
		addi $sp, $sp, -36
		sw $ra, 32($sp)
		sw $fp, 28($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str17
		syscall
		li $v0, 5
		syscall
		sw $v0, 24($sp)
		li $v0, 5
		syscall
		sw $v0, 20($sp)
		lw $t8, 24($sp)
		move $a0, $t8
		lw $t8, 20($sp)
		move $a1, $t8
		jal iswronggcd
		nop
		move $t0, $v0
		beqz $t0, Label42
		nop
Label43:	
		li $v0, 4
		la $a0, Str18
		syscall
		li $v0, 5
		syscall
		sw $v0, 24($sp)
		li $v0, 5
		syscall
		sw $v0, 20($sp)
		lw $t8, 24($sp)
		move $a0, $t8
		lw $t8, 20($sp)
		move $a1, $t8
		jal iswronggcd
		nop
		move $t0, $v0
		bnez $t0, Label43
		nop
Label42:	
		lw $t8, 24($sp)
		move $a0, $t8
		lw $t8, 20($sp)
		move $a1, $t8
		jal gcd
		nop
		move $t0, $v0
		li $v0, 4
		la $a0, Str19
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		move $sp, $fp
		lw $ra, 32($sp)
		lw $fp, 28($sp)
		addi $sp, $sp, 36
		jr $ra
		nop
is_prime:	
		addi $sp, $sp, -24
		sw $ra, 20($sp)
		sw $fp, 16($sp)
		move $fp, $sp
		sw $a0, 24($sp)
		li $v1, 2
		addi $t9, $sp, 12
		sw $v1, 0($t9)
		lw $v1, 24($sp)
		li $t9, 2
		sub $t0, $v1, $t9
		bnez $t0, Label44
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
Label44:	
Label45:	
		lw $t8, 24($sp)
		move $a0, $t8
		lw $t8, 12($sp)
		move $a1, $t8
		jal mod
		nop
		move $t0, $v0
		li $t9, 0
		sub $t1, $t0, $t9
		bnez $t1, Label46
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
Label46:	
		lw $v1, 12($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 12
		sw $t0, 0($t9)
		lw $v1, 12($sp)
		lw $t9, 12($sp)
		mul $t0, $v1, $t9
		lw $t9, 24($sp)
		sub $t1, $t0, $t9
		bltz $t1, Label45
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
prime_factorization:	
		addi $sp, $sp, -28
		sw $ra, 24($sp)
		sw $fp, 20($sp)
		move $fp, $sp
		sw $a0, 28($sp)
		li $v1, 2
		addi $t9, $sp, 16
		sw $v1, 0($t9)
		li $v1, 0
		addi $t9, $sp, 12
		sw $v1, 0($t9)
		lw $v1, 28($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bnez $t0, Label47
		nop
		li $v0, 4
		la $a0, Str20
		syscall
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
Label47:	
Label48:	
		lw $t8, 16($sp)
		move $a0, $t8
		jal is_prime
		nop
		move $t0, $v0
		li $t9, 1
		sub $t1, $t0, $t9
		bnez $t1, Label49
		nop
		lw $t8, 28($sp)
		move $a0, $t8
		lw $t8, 16($sp)
		move $a1, $t8
		jal mod
		nop
		move $t0, $v0
		li $t9, 0
		sub $t1, $t0, $t9
		bnez $t1, Label50
		nop
Label51:	
		lw $v1, 28($sp)
		lw $t9, 16($sp)
		div $t0, $v1, $t9
		addi $t9, $sp, 28
		sw $t0, 0($t9)
		lw $v1, 12($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bnez $t0, Label52
		nop
		li $v0, 4
		la $a0, Str21
		syscall
Label52:	
		li $v1, 1
		addi $t9, $sp, 12
		sw $v1, 0($t9)
		lw $t8, 16($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		lw $t8, 28($sp)
		move $a0, $t8
		lw $t8, 16($sp)
		move $a1, $t8
		jal mod
		nop
		move $t0, $v0
		li $t9, 0
		sub $t1, $t0, $t9
		beqz $t1, Label51
		nop
Label50:	
Label49:	
		lw $v1, 16($sp)
		li $t9, 1
		add $t0, $v1, $t9
		addi $t9, $sp, 16
		sw $t0, 0($t9)
		lw $v1, 16($sp)
		lw $t9, 16($sp)
		mul $t0, $v1, $t9
		lw $t9, 28($sp)
		sub $t1, $t0, $t9
		bltz $t1, Label48
		nop
		lw $v1, 28($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		beqz $t0, Label53
		nop
		lw $v1, 12($sp)
		li $t9, 1
		sub $t0, $v1, $t9
		bnez $t0, Label54
		nop
		li $v0, 4
		la $a0, Str22
		syscall
Label54:	
		lw $t8, 28($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label53:	
		move $sp, $fp
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 28
		jr $ra
		nop
prime_factorization_test:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str23
		syscall
		li $v0, 5
		syscall
		sw $v0, 8($sp)
Label55:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bgez $t0, Label56
		nop
		li $v0, 4
		la $a0, Str24
		syscall
		li $v0, 5
		syscall
		sw $v0, 8($sp)
Label56:	
		lw $v1, 8($sp)
		li $t9, 0
		sub $t0, $v1, $t9
		bltz $t0, Label55
		nop
		li $v0, 4
		la $a0, Str25
		syscall
		lw $t8, 8($sp)
		move $a0, $t8
		jal prime_factorization
		nop
		move $sp, $fp
		lw $ra, 16($sp)
		lw $fp, 12($sp)
		addi $sp, $sp, 20
		jr $ra
		nop
iswrong:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		li $v1, 69
		lw $t9, 12($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label57
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label57:	
		li $v1, 77
		lw $t9, 12($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label58
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label58:	
		li $v1, 72
		lw $t9, 12($sp)
		sub $t0, $v1, $t9
		bnez $t0, Label59
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label59:	
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
main:	
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $fp, 12($sp)
		move $fp, $sp
		li $v0, 4
		la $a0, Str26
		syscall
		li $v0, 12
		syscall
		sw $v0, 8($sp)
		lw $t8, 8($sp)
		move $a0, $t8
		jal iswrong
		nop
		move $t0, $v0
		beqz $t0, Label60
		nop
Label61:	
		li $v0, 4
		la $a0, Str27
		syscall
		li $v0, 12
		syscall
		sw $v0, 8($sp)
		lw $t8, 8($sp)
		move $a0, $t8
		jal iswrong
		nop
		move $t0, $v0
		bnez $t0, Label61
		nop
Label60:	
		lw $v1, 8($sp)
		bne $v1, 69, Label63
		nop
		jal define_test
		nop
		jal operator_test
		nop
		jal fibonaci_test
		nop
		j Label62
		nop
Label63:	
		lw $v1, 8($sp)
		bne $v1, 77, Label64
		nop
		jal dowhile_test
		nop
		jal condition_test
		nop
		jal string_test
		nop
		jal gcd_test
		nop
		j Label62
		nop
Label64:	
		lw $v1, 8($sp)
		bne $v1, 72, Label65
		nop
		jal define_test
		nop
		jal operator_test
		nop
		jal dowhile_test
		nop
		jal condition_test
		nop
		jal string_test
		nop
		jal miscellaneous_test
		nop
		jal prime_factorization_test
		nop
		j Label62
		nop
Label65:	
Label62:	
