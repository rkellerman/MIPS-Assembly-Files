#  Ryan Kellerman 		158000667
#  Assignment 5

.data
prompt:  .asciiz "Enter n for a[n]: "
theArray: .word 0 1 1
size: .word 3
overflow: .asciiz "\nArithmetic Overflow\n"


.ktext 0x80000180
mfc0 $t4, $13 			# get excode
srl $t3, $t4, 2			
and $t3, $t3, 0x1f 		# excode field
bne $t3, 0, exception 	# if == 0, its not an interrupt

li $v0, 10
syscall

ret_handler:
	mfc0 $t4, $12
	ori $t4, $t4, 0xff01
	mtc0 $t4, $12

	lui $t6, 0x0040
	ori $t6, 0x00bc
	jr $t6

exception:
	li $v0, 4
	la $a0, overflow
	syscall
	j ret_handler



.text
main:



begin:

li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall

move $t5, $v0 			# holds user value
li $s5, 2 				# initial counter starts at 2
ble $t5, $s5, less

loop:
	
	
	la $a1, theArray
	lw $s0, 0($a1)
	lw $s1, 4($a1)
	lw $s2, 8($a1)
	add $t0, $s0, $s1
	add $t0, $t0, $s2



	addi $s5, 1
	beq $s5, $t5, FOUND
	sw $s1, 0($a1)
	sw $s2, 4($a1)
	sw $t0, 8($a1)

j loop

FOUND:

	
	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

less:
	bne $t5, $zero, one
	li $a0, 0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

one:
	li $a0, 1
	li $v0, 1
	syscall
	li $v0, 10
	syscall

fromException:
	li $t6, 0
	li $t7, 1
	la $a1, theArray
	sw $t6, 0($a1)
	sw $t7, 4($a1)
	sw $t7, 8($a1)
	j begin


