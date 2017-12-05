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
