#Ryan Kellerman  158000667
#Assignment 4.3
.data
str1: .asciiz "Enter a string to be printed: \n"
str2: .asciiz "You entered \n"
buffer: .space 20
.text
main:

li $v0, 4				# syscall for print string
la $a0, str1			# address for string to be printed
syscall					# make the system call

li $v0, 8				# syscall for read string
la $a0, buffer			# load space into address
li $a1, 20				# provide space for string
move $t0, $a0			# move a0 to t0
syscall

la $a0, str2			# address for string to be printed
li $v0, 4				# syscall for print string
syscall 				# make the syscall

la $a0, buffer			# make space for string again
move $a0, $t0			# move string to be printed
li $v0, 4				# syscall for print string
syscall					# make the syscall

li $v0, 10				# syscall to end program
syscall 				# make the syscall



