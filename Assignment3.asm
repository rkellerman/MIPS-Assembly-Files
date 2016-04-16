# Ryan Kellerman
# Assignment 3

# PSUEDO CODE:
#
# do {
# 	int a from user input
# 	int b from user input
# } while ( a > 500 || a < 10 || b > 500 || b < 10 || a % b == 0 || b % a == 0)
# if (b > a){
#	if (b % 2 == 0){
# 		for (int i = a; i < b; i = i + 2){
# 			sum += i;
#		}
# 	}
#	else {
#		a = a + 1;
#		for (int i = a; i < b; i = i + 2){
#			sum += i;
#		}
#	}
# }
# else{
# 	if (a % 2 == 0){
# 		for (int i = b; i < a; i = i + 2){
# 			sum += i;
#		}
# 	}
#	else {
#		b = b + 1;
#		for (int i = b; i < a; i = i + 2){
#			sum += i;
#		}
#	}
# }


.data
str1: .asciiz "Enter 2 integers between 10 and 500\n"
str2: .asciiz "\t1st Number: "
str3: .asciiz "\t2nd Number: "
str4: .asciiz "\nThe result is "
error1: .asciiz "Not between 10 and 500, enter new values...\n"
error2: .asciiz "One input divisible by other\n"

.text
main:
li $s5, 0
li $s3, 2
la $a0, str1 			# load string to be printed
li $v0, 4				# load syscall for print string
syscall

ErrorLoop:

la $a0, str2			# load string to be printed
li $v0, 4				# load syscall for print string
syscall

li $v0, 5				# load syscall for read int
syscall
move $t0, $v0			# move user value to t0

la $a0, str3			# load string to be printed
li $v0, 4				# load syscall for print string
syscall

li $v0, 5				# load syscall for read int
syscall
move $t1, $v0			# move user value to t1

blt $t0, 10, ErrorMessage1		# break if t0 < 10
bgt $t0, 500, ErrorMessage1		# break if t0 > 500

blt $t1, 10, ErrorMessage1		# break if t1 < 10
bgt $t1, 500, ErrorMessage1		# break if t1 > 500

div $t0, $t1					# divide and move remainder to s1
mfhi $s1 						# move HI to s1
beqz $s1, ErrorMessage2 		# trigger error if remainder is 0

div $t1, $t0 					# divide and move remainder to s1
mfhi $s1 						# move HI to s1
beqz $s1, ErrorMessage2 		# trigger error if remainder is 0

j notError 						# otherwise we have no error

ErrorMessage1: 					# load and print error message
la $a0, error1
li $v0, 4
syscall
j ErrorLoop 					# retries

ErrorMessage2: 					# load and print other error message
la $a0, error2
li $v0, 4
syscall
j ErrorLoop 					# retry

notError: 		
sub $s0, $t0, $t1 				# if valid, find which is greater
bgt $s0, $zero, Condition1 		# go to a > b
blt $s0, $zero, Condition2 		# go to b > a

Condition1: 				 	# This condition is when $t0 > $t1
addi $t1, 1
div $t1, $s3
mfhi $s4
bne $s4, $zero, Condition1Odd 		# if lower number is odd, branch
bge $t1, $t0, END 					# break to end when counter is greater than larger number
add $s5, $s5, $t1 					# add to sum
addi $t1, 1
j Condition1 						# loop again

Condition1Odd: 						# same as above but for the odd case
addi $t1, 1
bge $t1, $t0, END
add $s5, $s5, $t1
addi $t1, 1
j Condition1Odd

Condition2: 						# same as above but for case when b > a
addi $t0, 1
div $t0, $s3
mfhi $s4
bne $s4, $zero, Condition2Odd 		# if a is odd, then branch
bge $t0, $t1, END
add $s5, $s5, $t0
addi $t0, 1
j Condition2

Condition2Odd: 						# same as above but for odd
addi $t0, 1
bge $t0, $t1, END
add $s5, $s5, $t0
addi $t0, 1
j Condition2Odd

END:   								# load and print string
la $a0, str4
li $v0, 4
syscall
move $a0, $s5 						# load and print answer
li $v0, 1
syscall

li $v0, 10
syscall

 
