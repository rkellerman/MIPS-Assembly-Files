# Ryan Kellerman  158000667
# Assignment1.asm

.data
A: .asciiz "Enter A: "
B: .asciiz "\nEnter B: "
select: .asciiz "\nPlease select from the following operations:\n1) A and B,\n2) A or B,\n3) A xnor B,\n4) A xor B,\n5) A nand B,\n6) Exit."
choice: .asciiz "\nYour choice: "
AND: .asciiz "\nA and B = "
OR: .asciiz "\nA or B = "
XNOR: .asciiz "\nA xnor B = "
XOR: .asciiz "\nA xor B = "
NAND: .asciiz "\nA nand B = "


.text
And:
and $t5, $t0, $s0
li $v0, 4
la $a0, AND
syscall
li $v0, 1
move $a0, $t5
syscall
j SWITCHLOOP

Or:
or $t5, $t0, $s0
li $v0, 4
la $a0, OR
syscall
li $v0, 1
move $a0, $t5
syscall
j SWITCHLOOP

Xnor: 				# using only nor operations
nor $s3, $s0, $t0
nor $s1, $s0, $s3
nor $t1, $t0, $s3
nor $t5, $t1, $s1
addu $t5, $t5, $zero
li $v0, 4
la $a0, XNOR
syscall
li $v0, 1
move $a0, $t5
syscall
j SWITCHLOOP

Xor:
nor $s1, $s0, $s0
nor $t1, $t0, $t0
nor $s3, $s1, $t1
nor $t3, $s0, $t0
nor $t5, $s3, $t3
li $v0, 4
la $a0, XOR
syscall
move $a0, $t5
li $v0, 1
syscall
j SWITCHLOOP

Nand:
nor $s1, $s0, $s0
nor $t1, $t0, $t0
nor $s3, $t1, $s1
nor $t5, $s3, $s3
li $v0, 4
la $a0, NAND
syscall
li $v0, 1
move $a0, $t5
syscall
j SWITCHLOOP

main:

## register $s0 will be used to hold A
## register $t0 will be used to hold B
## register $s5 will be used to hold the users choice
## register $t5 will be used for the output
## register $s3 will be used for intermediate calculations

li $v0, 4 				# load and print statement A
la $a0, A
syscall

li $v0, 5 				# read int and save it to $s0
syscall
move $s0, $v0

li $v0, 4 				# load and print statement B
la $a0, B
syscall

li $v0, 5 				# read int and save it to $s0
syscall
move $t0, $v0

li $v0, 4
la $a0, select
syscall

SWITCHLOOP:

	li $v0, 4
	la $a0, choice
	syscall
	
	li $v0, 5
	syscall
	move $s5, $v0
	
	beq $s5, 1, And
	beq $s5, 2, Or
	beq $s5, 3, Xnor
	beq $s5, 4, Xor
	beq $s5, 5, Nand
	beq $s5, 6, END
	
j SWITCHLOOP
	
END:
li $v0, 10
syscall
