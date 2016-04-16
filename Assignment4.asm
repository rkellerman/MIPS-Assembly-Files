# Ryan Kellerman  158000667
# Assignment 4

# PSEUDO CODE

# get input from user
# determine if input is odd or even using a % 2
# number of stars = 1
# if (a % 2 == 0)
#	while (stars < input)
#		number of spaces = (input - stars)/2
#		number of stars + 2
#		print spaces and stars
#	while (stars > 0)
#		number of spaces = (input - stars)/2
#		numer of stars - 2
# else 
#	number of stars++
#	while (stars < input)
#		number of spaces = (input - stars)/2
#		number of stars + 2
#		print spaces and stars
#	while (stars > 0)
#		number of spaces = (input - stars)/2
#		number of stars - 2
#		print spaces and stars



.data
str1: .asciiz "The number of lines? \n"
space: .asciiz " "
star: .asciiz "*"
return: .asciiz "\n"

.text
main:

li $t0, 2
li $s5, 1 					# stores number of stars to be printed

la $a0, str1 				# load and print prompt string
li $v0, 4
syscall

li $v0, 5
syscall
move $s0, $v0				# store user input into $s0

div $s0, $t0				# determine if input is even or odd
mfhi $t0
bne $t0, $zero, ODD 		# if the iput is odd, break to odd condition loop
addi $s5, 1
j EVEN

EVEN:						# 2*space + stars = input --> space = (input - stars)/2
la $a0, return
li $v0, 4
syscall
li $s1, 0					# space counter
li $s2, 0					# star counter
sub $s4, $s0, $s5
div $s4, $s4, 2				# number of spaces held by $s4
	EvenSpaceloop:
		beq $s1, $s4, EvenStarloop 			# when the correct amount of spaces are done
		la $a0, space 						# we begin the star loop
		li $v0, 4 							# prints spaces in the same line
		syscall
		addi $s1, 1
		j EvenSpaceloop
			EvenStarloop:
				beq $s2, $s5, EvenEndStarloop 			# when done, breaks to move to next line
				la $a0, star 							# loads and prints stars in the same line
				li $v0, 4
				syscall
				addi $s2, 1
				j EvenStarloop
EvenEndStarloop:
beq $s5, $s0, END1 						# returns to print next line if not done
addi $s5, 2

j EVEN

ODD:						# starting stars = 1
la $a0, return
li$v0, 4
syscall
li $s1, 0					# space counter
li $s2, 0					# star counter
sub $s4, $s0, $s5
div $s4, $s4, 2				# number of spaces held by $s4
	Spaceloop:
		beq $s1, $s4, Starloop 				# breaks to printing stars when spaces have been printed
		la $a0, space 						# loads and prints spaces in same line
		li $v0, 4
		syscall
		addi $s1, 1
		j Spaceloop
			Starloop:
			beq $s2, $s5, EndStarloop 			# breaks to move to next line
			la $a0, star 						# loads and prints stars in the same line
			li $v0, 4
			syscall
			addi $s2, 1
			j Starloop
EndStarloop:
beq $s5, $s0, END1 					# if not done, move into the next line and begins again
addi $s5, 2
j ODD

END1:
addi $s5, -2
j END

END:
la $a0, return 				# both finish with the same loops
li$v0, 4
syscall
li $s1, 0					# space counter
li $s2, 0					# star counter
sub $s4, $s0, $s5
div $s4, $s4, 2				# number of spaces held by $s4
	EndSpaceloop:
		beq $s1, $s4, FinalStarloop 			# when spaces are done, break to print stars
		la $a0, space 							# load and print appropriate number of spaces
		li $v0, 4
		syscall
		addi $s1, 1
		j EndSpaceloop
			FinalStarloop:
			beq $s2, $s5, Final 				# when done, moves onto the next line
			la $a0, star 						# loads and prints stars to be printed
			li $v0, 4
			syscall
			addi $s2, 1
			j FinalStarloop
Final:
ble $s5, 2, QUIT 					# if done, we break to the end of the program
addi $s5, -2
j END



QUIT:
la $a0, return
li $v0, 4
syscall
li $v0, 10
syscall