# Ryan Kellerman  158000667
# Assignment 2

## Pseudo Code:
## 
## for (int i = 2; i < 300; i++){
##		for (int j = 2; j < i; j++){
##			if (i % j == 0 && j != i){
## 				i is NOT prime
##				jump to outer loop
## 			}
##		}
##		store value
## }

.data
str1: .asciiz "The largest prime < 300 is: "

.text
main:
li $t0, 300					# store value 300 onto t0
li $t1, 1					# store 1 onto outer loop counter value, i
li $t2, 1					# store 1 onto inner loop counter value, j

outerloop:
addi $t1, 1 				# increment outer loop counter
beq $t1, $t0, END			# break when outer loop counter is equal to 300
li $t2, 2 					# initialize inner loop parameter to 2 (lowest prime number)
	
	innerloop:
	div $t1, $t2			# divide t1 by t2
	mfhi $s0				# move HI to s0
	j If 					

		If:
		beq $t1, $t2, isPrime 			# maybe prime if t1 is equal to t2
		beq $s0, $zero, notPrime 		# maybe not prime if remainder is equal to 0

	addi $t2, 1 						# increment inner loop counter
	j innerloop

notPrime:
addi $t2, 1 							# if not prime jump to outer loop after incrementing
j outerloop

isPrime:
move $s5, $t1 							# if number is prime save value
j outerloop

END:
la $a0, str1							# load string to be printed
li $v0, 4								# syscall for print string
syscall

move $a0, $s5							# print saved value 
li $v0, 1
syscall

li $v0, 10
syscall




