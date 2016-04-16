# Ryan Kellerman  158000667
# Assignment 6

.data
theString: .space 32
str1: .asciiz "Hex string: (max 7 characters) "
str2: .asciiz "Its binary value: "
str3: .asciiz "Invalid hex string.\n"
done: .asciiz "Done"
binaryString: .space 128

.text
printZero:
	la $a0, 0
	li $v0, 1
	syscall
jr $ra

print:
	beqz $a1, printZero 			# if the bit to be printed is 0, break to approprite segment
	la $a0, 1
	li $v0, 1
	syscall
jr $ra

convertAlpha:
	addi $s0, $s0, -55 				# converts hex characters A-F
	add $t0, $t0, $s0
	sll $t0, $t0, 4
	addi $a3, 1
	addi $t5, 1
j convertloop


convert:
	convertloop:
		
		
		lb $s0, 0($a3) 				# each byte is loaded
		beq $s0, 10, END
		bge $s0, 58, convertAlpha
		addi $s0, $s0, -48
		add $t0, $t0, $s0
		sll $t0, $t0, 4
		addi $a3, 1
		addi $t5, 1
	j convertloop

	check:
		checkloop:

		lb $s0, 0($a3) 			# load each byte of the hex string
		li $v0, 0
		li $s4, 10
		beq $s0, $s4, bk_check
		slti $t1, $s0, 48		# set to 1 if character is less than 0 in ascii
		li $s4, 57
		slt $t2, $s4, $s0
		
		or $t1, $t1, $t2 		# convert the character to the ASCII value
		li $s4, 65 				# we then use OR and AND to determine if it is between x AND y OR w AND z
		slt $t2, $s0, $s4
		li $s4, 70
		slt $t3 $s4, $s0
		or $t2, $t2, $t3

		and $v0, $t1, $t2
		addi $a3, 1
		beq $v0, $zero, checkloop	# if done checking, it returns to the main procedure
		jr $ra					# if valid, set $v0 to 0

bk_check:
jr $ra

main:
li $t0, 0

loop:
li $v0, 4					# load string 1 to be printed
la $a0, str1
syscall

li $v0, 8
li $a1, 32
la $a0, theString 			# loads allocated memory for hex string to be inputted
syscall
move $a3, $a0

jal check 					# call procedure to check if it is a valid hex string
la $a3, theString 			# loads the hex string to be converted
li $t5, 0
beq $v0, $zero, convert 	# if v0 is set to 1 we have to retry, otherwise we continue to convert
la $a0, str3
li $v0, 4
syscall
j loop

END:
	srl $t0, $t0, 4
	la $a3, binaryString
	
	li $s0, 0 					# loop counter
	mul $s1, $t5, 4
	li $s2, 32
	sub $s1, $s2, $s1
	
	sll $t0, $t0, $s1

	la $a0, str2
	li $v0, 4
	syscall

	printloop:
		bge $s0, $t5, FINISH 			# in irder to print, we load 4 registers with 
		li $s1, 0x08 					# 1, 2, 4, and 8, shifted 24 bits
		sll $s1, $s1, 28 				# and then anded with the sequence to be converted
		li $s2, 0x04
		sll $s2, $s2, 28
		li $s3, 0x02
		sll $s3, $s3, 28
		li $s4, 0x01
		sll $s4, $s4, 28

		and $s1, $s1, $t0
		and $s2, $s2, $t0
		and $s3, $s3, $t0
		and $s4, $s4, $t0

		move $a1, $s1
		jal print
		move $a1, $s2
		jal print
		move $a1, $s3
		jal print
		move $a1, $s4
		jal print

		addi $a3, 1
		addi $s0, 1
		sll $t0, $t0, 4 				# we shift left to get the next 4 bits as many times as we need
	j printloop
	
	
	

FINISH:

	li $v0, 10
	syscall
