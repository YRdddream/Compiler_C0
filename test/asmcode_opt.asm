.data
max_num	:	.word	1024
$String0	:	.asciiz	"OVERFLOW! "
$String1	:	.asciiz	"complete number: "
$String2	:	.asciiz	"  "
$String3	:	.asciiz	"  "
$String4	:	.asciiz	"---------------------------------------------------------------\n"
$String5	:	.asciiz	" "
$String6	:	.asciiz	"  "
$String7	:	.asciiz	"The total is "
.text
.globl main
		addi	$fp	$sp	4
		addi	$sp	$sp	4
		j	main
		nop
complete_num:
		subi	$sp	$sp	8
		subi	$sp	$sp	0
		subi	$sp	$sp	4096
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		subi	$sp	$sp	4
		li	$t0	2
		sw	$t0	-4108($fp)
label0:
		li	$t0	0
		li	$t1	1
		sub	$t0	$t0	$t1
		sw	$t0	-4144($fp)
		subi	$sp	$sp	4
		lw	$t0	-4144($fp)
		sw	$t0	-4112($fp)
		lw	$t0	-4108($fp)
		sw	$t0	-4116($fp)
		li	$t0	1
		sw	$t0	-4104($fp)
label1:
		lw	$t0	-4108($fp)
		lw	$t1	-4104($fp)
		div	$t0	$t0	$t1
		sw	$t0	-4148($fp)
		subi	$sp	$sp	4
		lw	$t0	-4148($fp)
		lw	$t1	-4104($fp)
		mul	$t0	$t0	$t1
		sw	$t0	-4152($fp)
		subi	$sp	$sp	4
		lw	$t0	-4152($fp)
		sw	$t0	-4120($fp)
		lw	$t1	-4120($fp)
		lw	$t2	-4108($fp)
		seq	$t0	$t1	$t2
		beq	$t0	0	label2
		lw	$t0	-4112($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4156($fp)
		subi	$sp	$sp	4
		lw	$t0	-4156($fp)
		sw	$t0	-4112($fp)
		lw	$t0	-4116($fp)
		lw	$t1	-4104($fp)
		sub	$t0	$t0	$t1
		sw	$t0	-4160($fp)
		subi	$sp	$sp	4
		lw	$t0	-4160($fp)
		sw	$t0	-4116($fp)
		lw	$t1	-4112($fp)
		li	$t2	1024
		sge	$t0	$t1	$t2
		beq	$t0	0	label3
		li	$v0	4
		la	$t0	$String0
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
label3:
		lw	$t1	-4112($fp)
		li	$t2	1024
		slt	$t0	$t1	$t2
		beq	$t0	0	label4
		lw	$t0	-4104($fp)
		lw	$t1	-4112($fp)
		mul	$t1	$t1	-4
		li	$t2	-8
		add	$t1	$t1	$t2
		add	$t1	$t1	$fp
		sw	$t0	($t1)
label4:
label2:
		lw	$t0	-4104($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4164($fp)
		subi	$sp	$sp	4
		lw	$t0	-4164($fp)
		sw	$t0	-4104($fp)
		lw	$t1	-4104($fp)
		lw	$t2	-4108($fp)
		slt	$t0	$t1	$t2
		beq	$t0	1	label1
		lw	$t1	-4116($fp)
		li	$t2	0
		seq	$t0	$t1	$t2
		beq	$t0	0	label5
		li	$v0	4
		la	$t0	$String1
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$a0	-4108($fp)
		li	$v0	1
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		li	$t0	0
		sw	$t0	-4104($fp)
label6:
		li	$t0	-8
		add	$t0	$t0	$fp
		lw	$t1	-4104($fp)
		mul	$t1	$t1	-4
		add	$t0	$t0	$t1
		lw	$t0	($t0)
		sw	$t0	-4168($fp)
		li	$v0	4
		la	$t0	$String2
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$a0	-4168($fp)
		li	$v0	1
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$t0	-4104($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4172($fp)
		subi	$sp	$sp	4
		lw	$t0	-4172($fp)
		sw	$t0	-4104($fp)
		lw	$t1	-4104($fp)
		lw	$t2	-4112($fp)
		sle	$t0	$t1	$t2
		beq	$t0	1	label6
		li	$v0	4
		la	$t0	$String3
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
label5:
		lw	$t0	-4108($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4176($fp)
		subi	$sp	$sp	4
		lw	$t0	-4176($fp)
		sw	$t0	-4108($fp)
		lw	$t1	-4108($fp)
		la	$t2	max_num
		lw	$t2	($t2)
		slt	$t0	$t1	$t2
		beq	$t0	1	label0
		li	$v0	4
		la	$t0	$String4
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		li	$t0	0
		sw	$t0	-4132($fp)
		li	$t0	1
		sw	$t0	-4136($fp)
		li	$t0	2
		sw	$t0	-4124($fp)
label7:
		lw	$t0	-4124($fp)
		li	$t1	1
		sub	$t0	$t0	$t1
		sw	$t0	-4180($fp)
		subi	$sp	$sp	4
		lw	$t0	-4180($fp)
		sw	$t0	-4128($fp)
		li	$t0	2
		sw	$t0	-4104($fp)
label8:
		lw	$t0	-4124($fp)
		lw	$t1	-4104($fp)
		div	$t0	$t0	$t1
		sw	$t0	-4184($fp)
		subi	$sp	$sp	4
		lw	$t0	-4184($fp)
		lw	$t1	-4104($fp)
		mul	$t0	$t0	$t1
		sw	$t0	-4188($fp)
		subi	$sp	$sp	4
		lw	$t0	-4188($fp)
		sw	$t0	-4140($fp)
		lw	$t1	-4140($fp)
		lw	$t2	-4124($fp)
		seq	$t0	$t1	$t2
		beq	$t0	0	label9
		li	$t0	0
		sw	$t0	-4136($fp)
label9:
		lw	$t0	-4104($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4192($fp)
		subi	$sp	$sp	4
		lw	$t0	-4192($fp)
		sw	$t0	-4104($fp)
		lw	$t1	-4104($fp)
		lw	$t2	-4128($fp)
		sle	$t0	$t1	$t2
		beq	$t0	1	label8
		lw	$t1	-4136($fp)
		li	$t2	1
		seq	$t0	$t1	$t2
		beq	$t0	0	label10
		li	$v0	4
		la	$t0	$String5
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$a0	-4124($fp)
		li	$v0	1
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$t0	-4132($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4196($fp)
		subi	$sp	$sp	4
		lw	$t0	-4196($fp)
		sw	$t0	-4132($fp)
		lw	$t0	-4132($fp)
		li	$t1	10
		div	$t0	$t0	$t1
		sw	$t0	-4200($fp)
		subi	$sp	$sp	4
		lw	$t0	-4200($fp)
		li	$t1	10
		mul	$t0	$t0	$t1
		sw	$t0	-4204($fp)
		subi	$sp	$sp	4
		lw	$t0	-4204($fp)
		sw	$t0	-4140($fp)
		lw	$t1	-4140($fp)
		lw	$t2	-4132($fp)
		seq	$t0	$t1	$t2
		beq	$t0	0	label11
		li	$v0	4
		la	$t0	$String6
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
label11:
label10:
		li	$t0	1
		sw	$t0	-4136($fp)
		lw	$t0	-4124($fp)
		li	$t1	1
		add	$t0	$t0	$t1
		sw	$t0	-4208($fp)
		subi	$sp	$sp	4
		lw	$t0	-4208($fp)
		sw	$t0	-4124($fp)
		lw	$t1	-4124($fp)
		la	$t2	max_num
		lw	$t2	($t2)
		sle	$t0	$t1	$t2
		beq	$t0	1	label7
		li	$v0	4
		la	$t0	$String7
		move	$a0	$t0
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		lw	$a0	-4132($fp)
		li	$v0	1
		syscall
		li	$v0	11
		li	$a0	'\n'
		syscall
		move	$t0	$ra
		lw	$ra	($fp)
		move	$sp	$fp
		lw	$fp	4($fp)
		addi	$sp	$sp	4
		jr	$t0
main:
		subi	$sp	$sp	8
		subi	$sp	$sp	0
		sw	$fp	($sp)
		subi	$sp	$sp	4
		sw	$ra	($sp)
		move	$fp	$sp
		jal	complete_num
		nop
		li	$v0	10
		syscall
