# Ryan Kellerman  158000667
# Assignment 7

.data
input: .asciiz "Enter an item for the array.  Enter -9999 when finished: "
str1: .asciiz "Sorted array:\n"
theArray: .space 400
positive: .asciiz "\nThe number of positives is: "
negative: .asciiz "\nThe number of negatives is: "
zero: .asciiz "\nThe number of zeroes is: "
median: .asciiz "\nThe median is: "
space: .asciiz " "

.text

NEGATIVE:
addi $s2, 1
addi $a1, 4
addi $s0, 1
j countloop

POSITIVE:
addi $s1, 1
addi $a1, 4
addi $s0, 1
j countloop

ZERO:
addi $s3, 1
addi $a1, 4
addi $s0, 1
j countloop

Condition:						# if array[i] <= array[i+1]

	sw $s2, 3($a1) 				# the items are swapped and then stored as such
	sw $s1, 7($a1)
	addi $a1, 4
	addi $t0, 1

j bubbleLoop

back:
jr $ra


BubbleSort:
la $a1, theArray 							# this procedure loads the array and sorts
li $t0, 0
addi $s5, -1
beq $s5, 1, back
	bubbleLoop: 							# after each completed pass, we go 1 less time
		beq $t0, $s5, BubbleSort
		lw $s1, 3($a1) 						# load the two items to be compared
		lw $s2, 7($a1) 
		bgt $s1, $s2, Condition 			# if the latter is less than the former, we break to swap
		addi $a1, 4
		addi $t0, 1
	j bubbleLoop



main:
la $a0, input
li $v0, 4
syscall

la $a1, theArray 				# load allocated memory for our array
li $s3, 0xF 					# start with 0xF loaded into the end of the array
sw $s3, 3($a1)
li $s5, 0
loop:

	li $v0, 5
	syscall
	
	
	
	beq $v0, -9999, NEXT
	lw $s3, 3($a1)
	sw $s3, 7($a1) 						# takes in an integer from the user, breaks when the input is -9999
	sw $v0, 3($a1) 						# also moves the 0xF to the end of the array before adding the next item
	addi $a1, $a1, 4
	addi $s5, 1
	la $a0, input
	li $v0, 4
	syscall

j loop

NEXT:
move $t5, $s5
addi $s5, 1 						# $t5 holds the number of digits
jal BubbleSort 						# jumps to the bubble sorting procedure
la $a1, theArray
li $s6, 1
la $a0, str1
li $v0, 4
syscall
	printloop:
		blt $t5, $s6, finito 			# loop across the array, printing the values that are at each byte
		lw $a0, 3($a1)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall

		addi $a1, 4

		addi $s6, 1
	j printloop

finito:
la $a1, theArray 				# load the array again to calculate negatives, positives, etc...
li $s0, 1
li $s1, 0
li $s2, 0
li $s3, 0
	countloop:
		blt $t5, $s0, Prints
		
		lw $v0, 3($a1)
		blt $v0, $zero, NEGATIVE 		# load each byte, if positive, increment positive, if negative, etc..
		bgt $v0, $zero, POSITIVE
		beqz, $v0, ZERO
		addi $a1, 4
		addi $s0, 1
	j countloop

Prints:
	li $s5, 2 							# loads the array to calculate the median value based on the input size
	div $t5, $s5
	mfhi $s5
	mflo $s4
	add $s4, $s4, $s4
	add $s4, $s4, $s4
	la $a1, theArray
	bnez $s5, ODD
	
	add $s4, $s4, $a1
	lw $t1, -1($s4) 					# if even we take the average of the two middle items
	lw $t2, 3($s4)
	add $t3, $t1, $t2
	li $s5, 2
	div $t3, $s5
	mflo $s4
	j Prints2
ODD:

add $s4, $s4, $a1 						# if odd we simply take the middle item
lw $s4, 3($s4)
j Prints2
Prints2:
	la $a0, median 						# load and print the values that we gathered earlier
	li $v0, 4
	syscall
	move $a0, $s4
	li $v0, 1
	syscall

	la $a0, positive
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall

	la $a0, negative
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall

	la $a0, zero
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall



li $v0, 10
syscall