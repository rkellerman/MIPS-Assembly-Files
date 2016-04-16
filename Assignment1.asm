# Ryan Kellerman  158000667
# Assignment 1

# branch.asm - Loop and Branches Program
# Registers used:
# $t0 - used to holf the number of iterations
# $t1 - used to hold the counter value in each iteration
# $v0 - syscall parameter and return value
# $a0 - syscall parameter - the string to print

.text
main:
li $t0, 5					# $t0 is given the value of 5
li $t1, 0					# $t1 is given the value of 0

loop:
beq $t0, $t1, endloop		# if ($t0 == $t1), break to endloop
addi $t1, $t1, 1			# increment the counter $t1 + 1
b loop						# branch back to loop label

endloop:
li $v0, 10					# syscall for exit
syscall						# make the syscall

## for the fist case, the program will enter the loop and then check if t1 and t0 are equal,
# it will then increment the value of t1 and the proceed back to the loop
# it will b loop 5 times, after which it will break to endloop and exit the program
## If line 12 is replaced with blt $t0, $t1, endloop, it will break when t0 is less than t1,
# so it will only break when t1 is 6, so it will loop an additional time
## If line 12 is replaced with bge $t0, $t1, endloop, it will break when t0 is greater than
# or equal to t1, which is the case at the first iteration, so it will never loop
## If line 12 is replaced with bnez $t1, endloop, it will break if t1 is not equal to 0,
# meaning it will increment once, loop to the top, and meet the break condition after the first loop