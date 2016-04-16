# Ryan Kellerman  158000667
# Exercise 5

.data 0x10000000
ask: .asciiz "\nEnter a number:"
ans: .asciiz "Answer: "
.text 0x00400000
.globl main
main:
li $v0, 4			# syscall for print string
la $a0, ask			# loads the ask string
syscall				# display the ask string

li $v0, 5			# syscall for read int
syscall				# make the syscall

move $t0, $v0		# move user input (n) to t0
addi $t1, $0, 0 	# i = 0
addi $t2, $0, 189	#ans = 189, starting case (n=0)
li $t3, 2			# initialize $t3 to 2

loop:
beq $t1, $t0, END	# loop from i = 0 to n-1 (n times)
addi $t1, $t1, 1 	# i = i+1
div $t2, $t3		# LO = ans / 2, The result is stored on LO
mflo $t2			# ans = LO, Copies the content of LO to t2
j loop

END:
li $v0, 4			# syscall for print string
la $a0, ans 		# loads the answer
syscall				# make the syscall
move $a0, $t2		# loads the answer
li $v0, 1 			# syscall for print int
syscall				# make the syscall

li $v0, 10			# syscall to end program
syscall				# make the syscall

## this program takes in an integer and starting with 189, divides by 2 the
## number of times specified by the integer given by the user.  It then takes
## the answer and rounds down so that we are left with an integer