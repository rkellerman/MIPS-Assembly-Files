# Ryan Kellerman  158000667
# Assignment 5

.data
incorrect1: .asciiz "Incorrect, you have "
incorrect2: .asciiz " more chance(s).  Please re-enter password:\n"
set: .asciiz "Set a password: "
confirm:  .asciiz "Re-enter password: "
error1: .asciiz "Failed.  Please enter a password with the size of 6 to 10.\n"
error2: .asciiz "Failed again.  Program terminating.\n"
success: .asciiz "Password is set up.\n"

theString: .space 50
theString2: .space 50


.text
main:
li $s2, 0 					# load and print the prompt asking for the password
li $s4, 3
loop:
la $a0, set
li $v0, 4
syscall

li $v0, 8
la $a0, theString 			# loads the allocated area that the string will be saved to
li $a1, 50
syscall
move $t2, $a0
add $s7, $t2, $zero

li $t0, 0					# initialize counter to 0

length:

lb $t1, 0($t2)
beqz $t1, CHECK 				# performs a bytewise check to determine the length
addi $t2, 1
addi $t0, 1
j length

CHECK:
addi $t0, -1 					# we check if it is less than ten first
ble $t0, 10, CHECK2
j Bad

CHECK2:
bge $t0, 6, CONFIRM 			# if less than ten, we check if greater than 6
j Bad

Bad:
la $a0, error1 					# if not within 6-10 cheracters, error is printed
li $v0, 4
syscall
j loop 							# then we try again

CONFIRM:
la $a0, confirm 				# if valid, we ask the user to confirm the password
li $v0, 4
syscall

li $v0, 8
la $a0, theString2 				# loads memory allocated for the second string to be saved
li $a1, 50
syscall
move $t3, $a0
add $t2, $s7, $zero

Retry:

lb $t4, 0($t3) 					# load characters and compare byte by byte
lb $t1, 0($t2)
addi $s2, 1
bne $t4, $t1, WRONG 			# if any do not match, we must retry
beq $t0, $s2, RIGHT 			# if they all match, we move on to the end
addi $t3, 1
addi $t2, 1

j Retry	

WRONG:
addi $s4, -1
beqz $s4, TERMINATE 			# if wrong enough times, the program is terminated

la $a0, incorrect1 				# otherwise we print out how many tries the user has left
li $v0, 4
syscall

move $a0, $s4
li $v0, 1
syscall

la $a0, incorrect2
li $v0, 4
syscall

li $v0, 8
la $a0, theString2 				# loads memory location again to be retried
li $a1, 50
syscall
move $t3, $a0

li $s2, 0
add $t2, $s7, $zero
j Retry

TERMINATE:
la $a0, error2 					# if terminating, load and print terminating statement
li $v0, 4
syscall
j END

RIGHT:
la $a0, success 				# if successful, load and print success statememt
li $v0, 4
syscall
j END

END:

li $v0, 10
syscall