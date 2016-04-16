#Ryan Kellerman  158000667
#Assignment 5\
.data
str: .asciiz "Enter number of operands: \n"
str1: .asciiz "Enter number to be multiplied \n"
str2: .asciiz "The product is \n"
.text
main:
li $v0, 4			# load syscall for print_str
la $a0, str 		# address of string to print
syscall				# print the string

li $v0, 5			# load syscall for read int
syscall				# make the syscall

move $t0, $v0		# move N to t0
li $t1, 0			# load 0 to t1 for comparison
li $t2, 1 			# load 1 to the initial operand
loop:				# loop returns here

li $v0, 4			# syscall for print string
la $a0, str1		# address of string to print
syscall				# make the syscall

li $v0, 5			# load syscall for read int
syscall				# make the syscall

mul $t2, $t2, $v0	# multiply user input by previous result
addi $t1, 1			# add one to the count
bge $t1, $t0, END	# break when count is equal to N
j loop				# jump back to start of the loop

END:				# returns here when loop is broken

li $v0, 4			# syscall for print string
la $a0, str2		# address for string to be printed
syscall				# make the syscall

li $v0, 1 			# syscall for print integer
move $a0, $t2		# move product to be printed
syscall				# make the syscall

li $v0, 10			# syscall to end program
syscall				# make the syscall



