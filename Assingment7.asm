# Ryan Kellerman  158000667
# Assignment 7

.data
ArrayA: .word 1 2 3 4 5 6 7 8 9 0
ArrayB: .word 0 0 0 0 0 0 0 0 0 0
Size: .word 10
str1: .asciiz "Enter value for i:\n"
str2: .asciiz "Enter value for j:\n"
str3: .asciiz "Enter value for k:\n"
str4: .asciiz "Your new array: \n"
space: .asciiz " "

.text
main:
li $s4, 0				# initialize byte address of s4 to 0
li $s5, 0			    # initialize byte address of s5 to 0

li $t4, 4				# initialize t4 to 4

li $v0, 4				# syscall for print string
la $a0, str1			# address of string one to print
syscall					# make the syscall

li $v0, 5				# syscall for read int
syscall					# make the syscall
move $s1, $v0 			# move this integer to s1
mul $s1, $s1, $t4		# *4 to get byte address of index

li $v0, 4				# syscall for print string
la $a0, str2			# address of string one to print
syscall					# make the syscall

li $v0, 5				# syscall for read int
syscall					# make the syscall
move $s2, $v0 			# move this integer to s2
mul $s2, $s2, $t4		# *4 to get byte address of index

li $v0, 4				# syscall for print string
la $a0, str3			# address of string one to print
syscall					# make the syscall

li $v0, 5				# syscall for read int
syscall					# make the syscall
move $s3, $v0 			# move this integer to s3
mul $s3, $s3, $t4		# *4 to get byte address of index

lw $a1, ArrayA($s1)		# load a[i] onto a1
lw $a2, ArrayA($s2)		# load a[j] onto a2
add $a3, $a1, $a2		# add elements of index i and j
mul $a3, $a3, $a2		# multilpy this sum ny a[j]

sw $a3, ArrayB($s3)		# store this value to b[k]

li $v0, 4				# syscall for print str
la $a0, str4			# address of string to be printed
syscall					# make the syscall
li $t0, 0				# initialize counter to 0

loop:

lw $a0, ArrayB($s5)		# load b[index] to be printed
li $v0, 1 				# syscall for print int
syscall					# make the syscall
la $a0, space			# address for space
li $v0, 4				# syscall for print string
syscall					# make the syscall

addi $t0, 1 			# increment the counter
add $s5, $s5, $t4		# increment index by 4

bge $t0, 10, END		# break when counter is equal to 10
j loop					# jump to beginning of loop

END:

li $v0, 10				# syscall to end program
syscall					# make the syscall


