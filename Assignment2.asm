# Ryan Kellerman
# Assignment2.asm

.data 
theArray: .space 200
size: .asciiz "Enter the size of the array: "
input: .asciiz "\nEnter an item for the array: "
sorted: .asciiz "\nThe Sorted Array: \n"
space: .asciiz " "
search: .asciiz "\nEnter item to add: "


.text


## registers $t5 & $t6 will be used to hold the user given size
## register $s5 will be used as a counter
## register $t0 will hold the new item to be added

BinarySearch:
## $t7 is left
## $t8 is middle
## $t9 is right
	li $t7, 0 						# left initialized to 0
	add $t9, $t6, $zero 			# right initialized to size-1
	addi $t9, -1
	searchloop:
		bgt $t7, $t9, ADD
		add $t8, $t7, $t9
		li $s2, 2
		div $t8, $s2
		mflo $t8
		
		mul $t8, $t8, 4
		la $a1, theArray
		add $t8, $t8, $a1
		lw $s0, 0($t8)
		sub $t8, $t8, $a1
		srl $t8, $t8, 2
		beq $s0, $t0, ADD
		ble $t0, $s0, MIDM1
		j MIDP1
		
MIDM1:
	addi $t9, $t8, -1
	j searchloop

MIDP1:
	addi $t7, $t8, 1
	j searchloop





Swap:
 	sw $s2, 0($a1)
 	sw $s1, 4($a1)
 	addi $a1, 4
 	addi $s5, 1
j bubbleLoop

main:

li $v0, 4
la $a0, size
syscall
li $v0, 5
syscall
move $t5, $v0

li $s5, 0
la $a1, theArray
li $s3, 0xF
sw $s3, 0($a1)

addLoop:

	bge $s5, $t5, toBubbleSort
	li $v0, 4
	la $a0, input
	syscall

	lw $s3, 0($a1)
	sw $s3, 4($a1)

	li $v0, 5
	syscall
	sw $v0, 0($a1)
	addi $a1, 4
	addi $s5, 1
j addLoop

toBubbleSort:
	add $t6, $t5, $zero
	addi $t5, 1
j BubbleSort

BubbleSort:
	li $s5, 0
	la $a1, theArray
	addi $t5, -1
	beq $t5, 1, Print
	bubbleLoop:
		beq $s5, $t5, BubbleSort
		lw $s1, 0($a1)
		lw $s2, 4($a1)
		bgt $s1, $s2, Swap
		addi $a1, 4
		addi $s5, 1
	j bubbleLoop
j BubbleSort

Print:
	li $v0, 4
	la $a0, sorted
	syscall

	la $a1, theArray
	li $s0, 1
	printLoop:
		bge $s5, $t6, toBinarySearch
		lw $a0, 0($a1)
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, space
		syscall
		addi $a1, 4
		addi $s5, 1
	j printLoop

toBinarySearch:
	li $v0, 4
	la $a0, search
	syscall

	li $v0, 5
	syscall
	move $t0, $v0
jal BinarySearch
FOUND:
ADD:
	add $s0, $t6, $zero
	la $a1, theArray
	sll $s1, $s0, 2
	add $s1, $a1, $s1
	lw $t1, 0($s1)
	sw $t1, 4($s1)

	# size of the current array is $t6
	moveLoop:
		addi $s0, -1
		sll $s1, $s0, 2
		la $a1, theArray
		add $a1, $a1, $s1
		lw $t1, 0($a1)
		sw $t1, 4($a1)
		beq $s0, $t8, INSERT
		j moveLoop
INSERT:
la $a1, theArray
sll $s0, $s0, 2
add $s0, $a1, $s0
sw $t0, 0($s0)

li $v0, 4
la $a0, sorted
syscall

la $a1, theArray

LastprintLoop:
		lw $a0, 0($a1)
		li $v0, 1
		beq $a0, 0xF, END
		syscall
		li $v0, 4
		la $a0, space
		syscall
		addi $a1, 4
	j LastprintLoop


END:
li $v0, 10
syscall