# Ryan Kellerman
# Assignment 6
.data 
Array1: .word 0 1 1 0 0 0 0 0 0 0
Size: .word 10
.text

main:

li $t5, 1 			# initialize t5 to 1
li $t6, 2			# initialize t6 to 2
li $t7, 3			# initialize t7 to 3
li $t0, 3			# initialize n to 3
li $t4, 4			# initialize t4 to 4
mul $t0, $t0, $t4	# multiply n * 4
mul $t5, $t5, $t4	# multiply $t5 by 4
mul $t6, $t6, $t4	# multiply $t6 by 4
mul $t7, $t7, $t4	# multiply $t7 by 4

loop:

sub $t1, $t0, $t5	# index of n - 1
sub $t2, $t0, $t6	# index of n - 2
sub $t3, $t0, $t7	# index of n - 3

lw $a1, Array1($t1)	# load array[n-1] onto a1
lw $a2, Array1($t2) # load array[n-2] onto a2
lw $a3, Array1($t3) # load array(n-3) onto a3

add $a1, $a1, $a2 	# adds a[n-1] and a[n-2]
add $a1, $a1, $a3	# adds (a[n-1] + a[n-2]) + a[n-3]

sw $a1, Array1($t0)	# stores the sum to a[n]

add $t0, $t0, $t4 	# increment n

bge $t0, 40, END	# break when n is equal to 40 (10)
j loop				# return to beginning of loop

END:

sub $t0, $t0, $t4 	# reduce n back to 9
lw $a0, Array1($t0)	# reload the value of a[9]
li $v0, 1 			# syscall for print int
syscall				# make the syscall

li $v0, 10			# syscall for ending program
syscall				# make the syscall




