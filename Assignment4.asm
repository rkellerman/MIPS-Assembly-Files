# Ryan Kellerman  158000667
# Assignment 4

.data
m:  .asciiz "\nm = "
n:  .asciiz "\nn = "
p:  .asciiz "\np = "
x0: .asciiz "\nx_0 = "
root:  .asciiz "\nA root is "

.text

f:
	mul.s $f5, $f4, $f4 			# f5 is x^2
	mul.s $f5, $f5, $f1 			# f5 is mx^2
	mul.s $f6, $f4, $f2 			# f6 is nx
	add.s $f5, $f5, $f6, 
	add.s $f5, $f5, $f3 			# f5 is mx^2 + nx + p
	jr $ra

jr $ra


fPrime:
	li.s $f6, 2.0
	mul.s $f6, $f6, $f1
	mul.s $f6, $f6, $f4
	add.s $f6, $f6, $f2			# f6 is 2mx + n
	jr $ra


main: 

li $v0, 4
la $a0, m
syscall
li $v0, 6
syscall
mov.s $f1, $f0				# register f1 holds the value of m

li $v0, 4
la $a0, n
syscall
li $v0, 6
syscall
mov.s $f2, $f0 				# register f2 holds the value of n

li $v0, 4
la $a0, p
syscall
li $v0, 6
syscall
mov.s $f3, $f0 				# register f3 holds the value of p

li $v0, 4
la $a0, x0
syscall
li $v0, 6
syscall
mov.s $f4, $f0				# register f4 holds the value of x0

## f(x) = mx^2 + nx + p
## f'(x) = 2mx + n

# register $f7 will hold x_iplus1

iterate:
	jal f
	jal fPrime
	div.s $f8, $f5, $f6
	sub.s $f7, $f4, $f8 
	sub.s $f9, $f7, $f4 			# f9 holds abs value of x+1 - x
	abs.s $f9, $f9
	li.s $f11, 0.000001
	c.lt.s $f9, $f11
	bc1t END
	mov.s $f4, $f7
	jal iterate

END:
li $v0, 4
la $a0, root
syscall

mov.s $f12, $f7
li $v0, 2
syscall

li $v0, 10
syscall




