	.data
str1: .asciiz "Enter an integer: "
r_str: .asciiz " Remainder: "
q_str: .asciiz " Quotient: "
cr: .asciiz "\n"
	.text
	.globl main
main:
#
# Step 1: Print the prompt message using system call 4
#
	la $a0, str1 # load string address into $a0
	li $v0, 4 # and I/O code into $v0
	syscall # execute the syscall to perform input/output via the console
#
# Step 2: load integer from memory and print it to console using a loop
#
	li $v0, 5 	# call syscall 5 to read the integer
	syscall 	# after the call, the number is stored in $v0
	move $t0, $v0 	# $t0 stores the input integer
#
# Step 3: print a newline
#
	la $a0, cr
	li $v0, 4 
	syscall
#
# Step 4: divide the input number by 2 for ten times
#
	li $t1, 10 # $t1 -- loop counter li $t2, 2
loop:
	li $t2, 2
	div $t0, $t2 # divide $t0 by 2
	mflo $t0 # $t0 stores quotient
	mfhi $t3 # $t3 stores remainder
	move $a0, $t0 # first parameter: quotient
	move $a1, $t3 # second parameter: remainder
	jal print_qr # Subroutine: print_qr(quotient, remainder)
	add $t1, $t1, -1 # decrease loop counter by 1
	bnez $t1, loop # if $t1 !=0, jump to loop
#End of program
	li $v0, 10 # syscall code 10 for terminating the program
	syscall
#
# Sub-Routine to print the Remainder and Quotient
# Procedure: print_qr
# Input: $a0-Quotient, $a1-remainder
#
print_qr:
	move $s0, $a0 # $s0 for Quotient
	move $s1, $a1 # $s1 for Remainder
# print remainder
	la $a0, r_str # load string address
	li $v0, 4 # call syscall 4 to print the string to the console
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
# print Quotient
	la $a0, q_str # load string address
	li $v0, 4 # call syscall 4 to print the string to the console
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
# print a newline
	la $a0, cr
	li $v0, 4
	syscall
	jr $ra