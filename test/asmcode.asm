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
