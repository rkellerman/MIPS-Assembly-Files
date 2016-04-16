# Ryan Kellerman 158000667
# Assignment 5

.data
radius: .asciiz "Enter radius of cone: "
height: .asciiz "\nEnter height of cone: "
SA: .asciiz "\nThe surface area of the cone is: "
volume: .asciiz "\nThe volume of the cone is: "

.text

f: 
	mul.s $f8, $f6, $f6
	sub.s $f8, $f8, $f5 			# f8 holds x^2 - (h^2 + r^2)
	jr $ra

fPrime:
	li.s $f9, 2.0
	mul.s $f9, $f6, $f9 			# f9 holds 2x
	jr $ra


surfaceArea:  ## value of SA will be stored on f10
	mul.s $f4, $f1, $f1
	mul.s $f4, $f4, $f3 			# f4 holds pi*r^2
	mul.s $f5, $f2, $f2
	mul.s $f6, $f1, $f1
	add.s $f5, $f5, $f6 			# f5 holds h^2 + r^2
	li.s $f6, 1000.00				# f6 holds starting value of x

	iterate:
		jal f
		jal fPrime
		div.s $f10, $f8, $f9
		sub.s $f10, $f6, $f10
		sub.s $f12, $f10, $f6
		abs.s $f12, $f12			# f12 holds the value of x+1-x
		li.s $f11, 0.000001
		c.lt.s $f12, $f11
		bc1t return 
		mov.s $f6, $f10
		jal iterate



main:
	## pi will be stored on f3
	## radius will be stored on f1
	## height will be stored on f2

	li $v0, 4
	la $a0, radius
	syscall
	li $v0, 6
	syscall
	mov.s $f1, $f0

	li $v0, 4
	la $a0, height
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0

	li.s $f3, 3.14159

	jal surfaceArea 				# f10 has value of sqrt(h^2 + r^2)

return:
	mul.s $f6, $f1, $f3
	mul.s $f10, $f6, $f10
	add.s $f10, $f4, $f10
	mov.s $f12, $f10
	la $a0, SA
	li $v0, 4
	syscall
	li $v0, 2
	syscall

	mul.s $f4, $f4, $f2
	li.s $f10, 1.0
	li.s $f9, 3.0
	div.s $f5, $f10, $f9
	mul.s $f4, $f4, $f5 			# f4 has value of 1/3*pi*r^2
	la $a0, volume
	li $v0, 4
	syscall
	mov.s $f12, $f4
	li $v0, 2
	syscall





	li $v0, 10
	syscall