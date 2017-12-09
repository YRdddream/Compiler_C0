		.data
		Str0:  .asciiz " \n"
		Str1:  .asciiz "test line:\n"
		Str2:  .asciiz "test fib:\n"
		Str3:  .asciiz "fib=\n"
		Str4:  .asciiz "test if:\n"
		Str5:  .asciiz "test dowhile:\n"
		Str6:  .asciiz "test switch:\n"
		Str7:  .asciiz "key is 0\n"
		Str8:  .asciiz "key is \n"
		Str9:  .asciiz "key is 2\n"
		Str10:  .asciiz "test printf:\n"
		Str11:  .asciiz "a=\n"
		Str12:  .asciiz "test nesting:\n"

		cona:  .word 10
		conb:  .word 97
		conc:  .word 54
		_cha:  .word 0
		chb:  .space 24
		chc:  .word 0
		chd:  .word 0

		.text
		.globl main
f:	
		addi $sp, $sp, -24
		sw $ra, 20($sp)
		sw $fp, 16($sp)
		move $fp, $sp
		sw $a0, 24($sp)
		sw $a1, 28($sp)
		li $v0, 1
		sw $v0, 12($sp)
		lw $v0, 24($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		blez $t0, Label0
		nop
		lw $v0, 24($sp)
		lw $v1, 12($sp)
		add $t0, $v0, $v1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
Label0:	
		lw $v0, 24($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 24
		sw $t0, 0($v1)
		lw $t8, 24($sp)
		move $a0, $t8
		lw $t8, 28($sp)
		move $a1, $t8
		jal f
		nop
		lw $v0, 24($sp)
		lw $v1, 28($sp)
		add $t0, $v0, $v1
		move $v0, $t0
		move $sp, $fp
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addi $sp, $sp, 24
		jr $ra
		nop
compare:	
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $fp, 4($sp)
		move $fp, $sp
		sw $a0, 12($sp)
		sw $a1, 16($sp)
		lw $v0, 12($sp)
		lw $v1, 16($sp)
		sub $t0, $v0, $v1
		blez $t0, Label1
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label1:	
		lw $v0, 12($sp)
		lw $v1, 16($sp)
		sub $t0, $v0, $v1
		bgtz $t0, Label2
		nop
		li $v0, 1
		sub $t0, $0, $v0
		move $v0, $t0
		move $sp, $fp
		lw $ra, 8($sp)
		lw $fp, 4($sp)
		addi $sp, $sp, 12
		jr $ra
		nop
Label2:	
line:	
		addi $sp, $sp, -856
		sw $ra, 852($sp)
		sw $fp, 848($sp)
		move $fp, $sp
		sw $a0, 856($sp)
		sw $a1, 860($sp)
		li $v0, 1
		addi $v1, $sp, 844
		sw $v0, 0($v1)
		li $v0, 1
		addi $v1, $sp, 840
		sw $v0, 0($v1)
Label3:	
		lw $v0, 844($sp)
		addi $v1, $sp, 440
		lw $t8, 844($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 844($sp)
		addi $v1, $sp, 40
		lw $t8, 844($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 844($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 844
		sw $t0, 0($v1)
		lw $v0, 844($sp)
		lw $v1, 856($sp)
		sub $t0, $v0, $v1
		blez $t0, Label3
		nop
		li $v0, 1
		addi $v1, $sp, 844
		sw $v0, 0($v1)
Label4:	
		li $v0, 5
		syscall
		sw $v0, 36($sp)
		li $v0, 5
		syscall
		sw $v0, 32($sp)
		lw $v0, 32($sp)
		li $v1, 0
		sub $t0, $v0, $v1
		beqz $t0, Label5
		nop
		lw $t8, 32($sp)
		move $a0, $t8
		li $a1, 0
		jal compare
		nop
		move $t0, $v0
		addi $v1, $sp, 28
		sw $t0, 0($v1)
		lw $v0, 28($sp)
		lw $v1, 32($sp)
		mul $t0, $v0, $v1
		addi $v1, $sp, 24
		sw $t0, 0($v1)
		addi $v0, $sp, 440
		lw $v1, 36($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		addi $v1, $sp, 20
		sw $t0, 0($v1)
Label6:	
		lw $v0, 20($sp)
		lw $v1, 28($sp)
		add $t0, $v0, $v1
		addi $v0, $sp, 40
		mulu $v1, $t0, 4
		add $v0, $v0, $v1
		lw $t1, 0($v0)
		addi $v1, $sp, 12
		sw $t1, 0($v1)
		addi $v0, $sp, 440
		lw $v1, 12($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		addi $v1, $sp, 16
		sw $t0, 0($v1)
		lw $v0, 12($sp)
		addi $v1, $sp, 40
		lw $t8, 20($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 20($sp)
		addi $v1, $sp, 440
		lw $t8, 12($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 16($sp)
		addi $v1, $sp, 20
		sw $v0, 0($v1)
		lw $v0, 840($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 840
		sw $t0, 0($v1)
		lw $v0, 840($sp)
		lw $v1, 24($sp)
		sub $t0, $v0, $v1
		blez $t0, Label6
		nop
		lw $v0, 36($sp)
		addi $v1, $sp, 40
		lw $t8, 16($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		addi $v0, $sp, 440
		lw $v1, 36($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		lw $v1, 32($sp)
		add $t1, $t0, $v1
		addi $v1, $sp, 440
		lw $t8, 36($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $t1, 0($v1)
Label5:	
		lw $v0, 844($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 844
		sw $t0, 0($v1)
		lw $v0, 844($sp)
		lw $v1, 860($sp)
		sub $t0, $v0, $v1
		blez $t0, Label4
		nop
		addi $v0, $sp, 40
		lw $t0, 4($v0)
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 2
		addi $v1, $sp, 844
		sw $v0, 0($v1)
Label7:	
		addi $v0, $sp, 40
		lw $v1, 844($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 4
		la $a0, Str0
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v0, 844($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 844
		sw $t0, 0($v1)
		lw $v0, 844($sp)
		lw $v1, 856($sp)
		sub $t0, $v0, $v1
		blez $t0, Label7
		nop
		move $sp, $fp
		lw $ra, 852($sp)
		lw $fp, 848($sp)
		addi $sp, $sp, 856
		jr $ra
		nop
f2:	
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		move $fp, $sp
		sw $a0, 16($sp)
		li $v0, 1
		addi $v1, $sp, 4
		sw $v0, 0($v1)
		lw $v0, 16($sp)
		lw $v1, 4($sp)
		add $t0, $v0, $v1
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
fib:	
		addi $sp, $sp, -32
		sw $ra, 28($sp)
		sw $fp, 24($sp)
		move $fp, $sp
		sw $a0, 32($sp)
		lw $v0, 32($sp)
		li $v1, 0
		sub $t0, $v0, $v1
		bnez $t0, Label8
		nop
		li $t8, 0
		move $v0, $t8
		move $sp, $fp
		lw $ra, 28($sp)
		lw $fp, 24($sp)
		addi $sp, $sp, 32
		jr $ra
		nop
Label8:	
		lw $v0, 32($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		bnez $t0, Label9
		nop
		li $t8, 1
		move $v0, $t8
		move $sp, $fp
		lw $ra, 28($sp)
		lw $fp, 24($sp)
		addi $sp, $sp, 32
		jr $ra
		nop
Label9:	
		lw $v0, 32($sp)
		li $v1, 1
		sub $t0, $v0, $v1
		move $a0, $t0
		sw $t0, 16($sp)
		jal fib
		nop
		lw $t0, 16($sp)
		move $t1, $v0
		lw $v0, 32($sp)
		li $v1, 2
		sub $t2, $v0, $v1
		move $a0, $t2
		sw $t0, 16($sp)
		sw $t1, 12($sp)
		sw $t2, 8($sp)
		jal fib
		nop
		lw $t0, 16($sp)
		lw $t1, 12($sp)
		lw $t2, 8($sp)
		move $t3, $v0
		add $t4, $t1, $t3
		addi $v1, $sp, 20
		sw $t4, 0($v1)
		lw $t8, 20($sp)
		move $v0, $t8
		move $sp, $fp
		lw $ra, 28($sp)
		lw $fp, 24($sp)
		addi $sp, $sp, 32
		jr $ra
		nop
nest:	
		addi $sp, $sp, -132
		sw $ra, 128($sp)
		sw $fp, 124($sp)
		move $fp, $sp
		li $v0, 1
		addi $v1, $sp, 64
		addi $v1, $v1, 0
		sw $v0, 0($v1)
		li $v0, 3
		addi $v1, $sp, 4
		addi $v1, $v1, 4
		sw $v0, 0($v1)
		li $v0, 4
		addi $v1, $sp, 64
		addi $v1, $v1, 12
		sw $v0, 0($v1)
		li $v0, 6
		addi $v1, $sp, 4
		addi $v1, $v1, 16
		sw $v0, 0($v1)
		li $v0, 8
		addi $v1, $sp, 64
		addi $v1, $v1, 24
		sw $v0, 0($v1)
		addi $v0, $sp, 64
		lw $t0, 0($v0)
		addi $v0, $sp, 4
		mulu $v1, $t0, 4
		add $v0, $v0, $v1
		lw $t1, 0($v0)
		addi $v0, $sp, 64
		mulu $v1, $t1, 4
		add $v0, $v0, $v1
		lw $t2, 0($v0)
		addi $v0, $sp, 4
		mulu $v1, $t2, 4
		add $v0, $v0, $v1
		lw $t3, 0($v0)
		addi $v0, $sp, 64
		mulu $v1, $t3, 4
		add $v0, $v0, $v1
		lw $t4, 0($v0)
		li $v0, 2333
		addi $v1, $sp, 4
		mulu $t4, $t4, 4
		add $v1, $v1, $t4
		sw $v0, 0($v1)
		addi $v0, $sp, 64
		lw $t0, 0($v0)
		addi $v0, $sp, 4
		lw $t1, 32($v0)
		add $t2, $t0, $t1
		li $v0, 1
		move $a0, $t2
		syscall
		move $sp, $fp
		lw $ra, 128($sp)
		lw $fp, 124($sp)
		addi $sp, $sp, 132
		jr $ra
		nop
t:	
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $fp, 8($sp)
		move $fp, $sp
		sw $a0, 16($sp)
		lw $v0, 16($sp)
		li $v1, 99
		sub $t0, $v0, $v1
		blez $t0, Label10
		nop
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
Label10:	
		lw $v0, 16($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 16
		sw $t0, 0($v1)
		lw $t8, 16($sp)
		li $v0, 11
		move $a0, $t8
		syscall
		lw $t8, 16($sp)
		move $a0, $t8
		jal t
		nop
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
		move $sp, $fp
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addi $sp, $sp, 16
		jr $ra
		nop
main:	
		addi $sp, $sp, -104
		sw $ra, 100($sp)
		sw $fp, 96($sp)
		move $fp, $sp
		li $v0, 3
		sw $v0, 92($sp)
		li $v0, 43
		la $v1, chc
		sw $v0, 0($v1)
		li $v0, 45
		la $v1, chd
		sw $v0, 0($v1)
		li $v0, 3
		addi $v1, $sp, 84
		sw $v0, 0($v1)
		li $v0, 0
		addi $v1, $sp, 68
		sw $v0, 0($v1)
		li $v0, 2
		sub $t0, $0, $v0
		addi $v1, $sp, 80
		sw $t0, 0($v1)
		li $v0, 4
		la $a0, Str1
		syscall
		li $a0, 8
		li $a1, 3
		jal line
		nop
		li $v0, 4
		la $a0, Str2
		syscall
		lw $t8, 92($sp)
		move $a0, $t8
		jal fib
		nop
		move $t0, $v0
		addi $v1, $sp, 76
		sw $t0, 0($v1)
		li $v0, 4
		la $a0, Str3
		syscall
		lw $t8, 76($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label11:	
		li $v0, 97
		addi $v1, $sp, 28
		lw $t8, 68($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 68($sp)
		addi $v1, $sp, 48
		lw $t8, 68($sp)
		mulu $t8, $t8, 4
		add $v1, $v1, $t8
		sw $v0, 0($v1)
		lw $v0, 68($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 68
		sw $t0, 0($v1)
		lw $v0, 68($sp)
		li $v1, 5
		sub $t0, $v0, $v1
		bltz $t0, Label11
		nop
		li $v0, 5
		syscall
		sw $v0, 72($sp)
		li $v0, 5
		syscall
		sw $v0, 88($sp)
		li $v0, 4
		la $a0, Str4
		syscall
		lw $v0, 72($sp)
		li $v1, 3
		sub $t0, $v0, $v1
		bgez $t0, Label12
		nop
		lw $v0, 88($sp)
		lw $v1, 84($sp)
		add $t0, $v0, $v1
		addi $v1, $sp, 88
		sw $t0, 0($v1)
Label12:	
		lw $v0, 72($sp)
		li $v1, 3
		sub $t0, $v0, $v1
		bgtz $t0, Label13
		nop
		lw $v0, 84($sp)
		lw $v1, 88($sp)
		sub $t0, $v0, $v1
		addi $v1, $sp, 84
		sw $t0, 0($v1)
		addi $v0, $sp, 48
		lw $t0, 0($v0)
		lw $v1, 84($sp)
		add $t1, $t0, $v1
		addi $v1, $sp, 48
		addi $v1, $v1, 0
		sw $t1, 0($v1)
		addi $v0, $sp, 28
		lw $t0, 0($v0)
		li $v1, 1
		add $t1, $t0, $v1
		addi $v1, $sp, 28
		addi $v1, $v1, 0
		sw $t1, 0($v1)
Label13:	
		lw $v0, 72($sp)
		li $v1, 6
		sub $t0, $v0, $v1
		blez $t0, Label14
		nop
		lw $v0, 88($sp)
		lw $v1, 84($sp)
		mul $t0, $v0, $v1
		addi $v1, $sp, 80
		sw $t0, 0($v1)
		addi $v0, $sp, 48
		lw $t0, 4($v0)
		lw $v1, 80($sp)
		add $t1, $t0, $v1
		addi $v1, $sp, 48
		addi $v1, $v1, 4
		sw $t1, 0($v1)
		addi $v0, $sp, 28
		lw $t0, 4($v0)
		li $v1, 1
		add $t1, $t0, $v1
		addi $v1, $sp, 28
		addi $v1, $v1, 4
		sw $t1, 0($v1)
Label14:	
		lw $v0, 72($sp)
		li $v1, 6
		sub $t0, $v0, $v1
		bltz $t0, Label15
		nop
		lw $v0, 88($sp)
		lw $v1, 84($sp)
		div $t0, $v0, $v1
		addi $v1, $sp, 76
		sw $t0, 0($v1)
		addi $v0, $sp, 48
		lw $t0, 8($v0)
		lw $v1, 76($sp)
		add $t1, $t0, $v1
		addi $v1, $sp, 48
		addi $v1, $v1, 8
		sw $t1, 0($v1)
		addi $v0, $sp, 28
		lw $t0, 8($v0)
		li $v1, 1
		add $t1, $t0, $v1
		addi $v1, $sp, 28
		addi $v1, $v1, 8
		sw $t1, 0($v1)
Label15:	
		lw $v0, 72($sp)
		li $v1, 4
		sub $t0, $v0, $v1
		beqz $t0, Label16
		nop
		li $v0, 1
		lw $v1, 92($sp)
		div $t0, $v0, $v1
		lw $v0, 88($sp)
		sub $t1, $v0, $t0
		addi $v1, $sp, 88
		sw $t1, 0($v1)
		addi $v0, $sp, 48
		lw $t0, 12($v0)
		lw $v1, 88($sp)
		add $t1, $t0, $v1
		li $v1, 99
		add $t2, $t1, $v1
		addi $v1, $sp, 48
		addi $v1, $v1, 12
		sw $t2, 0($v1)
		addi $v0, $sp, 28
		lw $t0, 12($v0)
		li $v1, 1
		add $t1, $t0, $v1
		addi $v1, $sp, 28
		addi $v1, $v1, 12
		sw $t1, 0($v1)
Label16:	
		lw $v0, 72($sp)
		li $v1, 4
		sub $t0, $v0, $v1
		bnez $t0, Label17
		nop
		lw $v0, 88($sp)
		sub $t0, $0, $v0
		li $v0, 2
		lw $v1, 92($sp)
		mul $t1, $v0, $v1
		add $t2, $t0, $t1
		addi $v1, $sp, 88
		sw $t2, 0($v1)
		addi $v0, $sp, 28
		lw $t0, 16($v0)
		li $v1, 1
		add $t1, $t0, $v1
		addi $v1, $sp, 28
		addi $v1, $v1, 16
		sw $t1, 0($v1)
Label17:	
		lw $t8, 72($sp)
		beqz $t8, Label18
		nop
		lw $t8, 88($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		lw $v0, 84($sp)
		sub $t0, $0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		lw $t8, 80($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		lw $t8, 76($sp)
		li $v0, 1
		move $a0, $t8
		syscall
Label18:	
		li $v0, 0
		addi $v1, $sp, 68
		sw $v0, 0($v1)
		li $v0, 4
		la $a0, Str5
		syscall
Label19:	
		addi $v0, $sp, 28
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 11
		move $a0, $t0
		syscall
		addi $v0, $sp, 48
		lw $v1, 68($sp)
		mulu $v1, $v1, 4
		add $v0, $v0, $v1
		lw $t0, 0($v0)
		li $v0, 1
		move $a0, $t0
		syscall
		lw $v0, 68($sp)
		li $v1, 1
		add $t0, $v0, $v1
		addi $v1, $sp, 68
		sw $t0, 0($v1)
		lw $v0, 68($sp)
		li $v1, 5
		sub $t0, $v0, $v1
		bltz $t0, Label19
		nop
		lw $t8, 72($sp)
		beqz $t8, Label20
		nop
		li $v0, 2
		sub $t0, $0, $v0
		move $a0, $t0
		li $a1, 3
		sw $t0, 20($sp)
		jal f
		nop
		lw $t0, 20($sp)
		move $t1, $v0
		li $v0, 5
		li $v1, 1
		add $t2, $v0, $v1
		lw $v1, 92($sp)
		mul $t3, $t2, $v1
		add $t4, $t1, $t3
		addi $v1, $sp, 48
		addi $v1, $v1, 16
		sw $t4, 0($v1)
Label20:	
		la $t8, conb
		lw $t8, 0($t8)
		move $a0, $t8
		jal t
		nop
		li $v0, 2
		sub $t0, $0, $v0
		move $a0, $t0
		li $a1, 3
		sw $t0, 20($sp)
		jal f
		nop
		lw $t0, 20($sp)
		la $t8, conb
		lw $t8, 0($t8)
		li $v0, 11
		move $a0, $t8
		syscall
		li $v0, 5
		syscall
		sw $v0, 72($sp)
		li $v0, 4
		la $a0, Str6
		syscall
		lw $v0, 72($sp)
		li $v1, 1
		mul $t0, $v0, $v1
		bne $t0, 0, Label22
		nop
		li $v0, 4
		la $a0, Str7
		syscall
		j Label21
		nop
Label22:	
		bne $t0, 1, Label23
		nop
		li $v0, 4
		la $a0, Str8
		syscall
		lw $t8, 72($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		j Label21
		nop
Label23:	
		bne $t0, 2, Label24
		nop
		li $v0, 4
		la $a0, Str9
		syscall
		j Label21
		nop
Label24:	
Label21:	
		li $a0, 97
		jal f2
		nop
		move $t0, $v0
		li $v0, 11
		move $a0, $t0
		syscall
		li $v0, 12
		syscall
		sw $v0, 24($sp)
		lw $v0, 24($sp)
		bne $v0, 97, Label26
		nop
		li $t8, 2
		li $v0, 1
		move $a0, $t8
		syscall
		j Label25
		nop
Label26:	
		lw $v0, 24($sp)
		bne $v0, 98, Label27
		nop
		li $v0, 2
		li $v1, 2
		add $t0, $v0, $v1
		li $v0, 1
		move $a0, $t0
		syscall
		j Label25
		nop
Label27:	
Label25:	
		li $v0, 4
		la $a0, Str10
		syscall
		li $t8, -2
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 2
		li $v1, -2
		add $t0, $v0, $v1
		li $v0, 1
		move $a0, $t0
		syscall
		li $t8, 0
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 5
		sub $t0, $0, $v0
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, Str11
		syscall
		lw $t8, 88($sp)
		li $v0, 1
		move $a0, $t8
		syscall
		li $v0, 4
		la $a0, Str12
		syscall
		jal nest
		nop
