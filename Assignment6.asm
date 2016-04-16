# Ryan Kellerman
# Assignment 6

.data
theArray: .space 100
length:  .asciiz "Enter the length of the array:  "
item:  .asciiz "\nEnter a float for the array: "
mean:  .asciiz "\nThe mean of the entries is "
sDeviation:  .asciiz "\nThe standard deviation of the entries is "

.text
f:
	mul.s $f4, $f3, $f3
	sub.s $f4, $f4, $f2 		# f4 holds x^2 - sd^2
	jr $ra

fPrime:
	li.s $f0, 2.0
	mul.s $f5, $f0, $f3			# f5 holds 2x
	jr $ra


main: 
	li $v0, 4
	la $a0, length
	syscall
	li $v0, 5
	syscall
	move $s0, $v0 				# s0 stores the length of the array

	la $a1, theArray
	li $t0, 0					# counter is set equal to 0

	loop:
		beq $t0, $s0, NEXT
		li $v0, 4
		la $a0, item
		syscall
		li $v0, 6
		syscall
		s.s $f0, 0($a1)
		addi $a1, $a1, 4
		addi $t0, $t0, 1
		j loop

NEXT:

	mtc1 $s0, $f0
	cvt.s.w $f1, $f0 			# f1 holds float equivalent of size
	la $a1, theArray
	li $t0, 0
	li.s $f3, 0.0
	meanLoop:
		beq $t0, $s0, PROCEED
		l.s $f2, 0($a1)
		add.s $f3, $f3, $f2
		addi $a1, 4
		addi $t0, 1
	j meanLoop

PROCEED:
	la $a0, mean
	li $v0, 4
	syscall
	div.s $f5, $f3, $f1
	mov.s $f12, $f5
	li $v0, 2
	syscall

StandardDeviation: 			# f5 holds the value of the mean
	li.s $f2, 0.0
	li $t0, 0
	la $a1, theArray
	devLoop:				# the sum will be stored onto f2
		beq $t0, $s0, divide
		l.s $f6, 0($a1)
		sub.s $f6, $f6, $f5
		mul.s $f6, $f6, $f6
		add.s $f2, $f2, $f6
		addi $a1, 4
		addi $t0, 1
	j devLoop
divide:
	addi $t0, $s0, -1
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0 			# f0 now holds size-1 as a float
	div.s $f2, $f2, $f0			# f2 now holds the standard deviation squared
	li.s $f3, 1000.0			# f3 holds the initial x0
		iterate:
			jal f
			jal fPrime
			div.s $f4, $f4, $f5 		# f4 holds f/f'
			sub.s $f6, $f3, $f4 		# f6 holds x+1
			sub.s $f12, $f6, $f3 		# f12 holds x+1 - x
			abs.s $f12, $f12
			li.s $f11, 0.000001
			c.lt.s $f12, $f11
			bc1t return
			mov.s $f3, $f6
			jal iterate
return:
	li $v0, 4
	la $a0, sDeviation
	syscall
	li $v0, 2
	mov.s $f12, $f6
	syscall






li $v0, 10
syscall