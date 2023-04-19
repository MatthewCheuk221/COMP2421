#
# README
# 
# This program returns the value binary, quaternary and octal representation of a positive integer input
# Users are assumed to input correctly, i.e., the input is expected to be a positive integer
# Follow the instructions stated
#
# Procedures:
#1. Print message: "Enter a number: "
#2. Read the input integer from the console
#3. Print message: "Input number is "
#4. Read the input integer from the console
#5. Compute the value binary, quaternary and octal representation of an integer input by a reusable subroutine
#6. Show the results of different representations on console respectively
#
	.text
	.globl main
main:
	ori $s0, $0, 0x2 #Suppose the least base of the numeral system is 2.
	ori $s1, $0, 0xa #Suppose the most base of the numeral system is 10.	
	
	la $a0, ask #Print message: "Enter a number: "
	li $v0, 4 	#Print a string
	syscall
	
	li $v0, 5	#Read an input integer
	syscall
	
	move $t0, $v0
	la $a0, reply	#Print message: "Input number is "	
	li $v0, 4	
	syscall
	
	move $a0, $t0
	li $v0, 1		#Print the integer entered
	syscall

	li $v0, 4
	la $a0, binary	#State that the following is the binary representation of the integer
	syscall

	move $a0, $t0
	ori $a1, $0, 0x2	#Set the base to be 2

	jal con				#Jump to the reusable subroutine for base convertion
	
	li $v0, 4
	la $a0, quaternary	#State that the following is the quaternary representation of the integer
	syscall
	
	move $a0, $t0
	ori $a1, $0, 0x4	#Set the base to be 4

	jal con
	
	li $v0, 4
	la $a0, octal		#State that the following is the octal representation of the integer
	syscall
	
	move $a0, $t0
	ori $a1, $0, 0x8	#Set the base to be 8

	jal con
	
	la $a0, continue	#Ask if the user want to continue
	li $v0, 4
	syscall
	
	li $v0, 5			#Receive input of either 1 or 0. 1 if so, 0 if not
	syscall
	
	beqz $v0, quit		#Go to the subroutine of exiting the program if 0 is the input
	jal main			#Continue and start again if 1 is the input
quit:	
	la $a0, bye			#Tell the user that the program exits
	li $v0, 4
	syscall
	
	li $v0, 10			#Exit the program
	syscall

con:					#Reusable subroutine for base convertion of the integer

	addi $sp, $sp, -16	#Subtract the stack pointer by 16

	sw $s8, 0xc($sp) #Count how many times the stack will be popped
	sw $s0, 0x8($sp) 
	sw $s1, 0x4($sp) 
	sw $ra, 0x0($sp) #Store the return address to the address of the first byte of the stack

	move $s0, $a0	#Store the integer input
	move $s1, $a1	#Store the base of the numeral system

	beqz $s0, end	#End the subroutine if the integer stored becomes 0

	div $t8, $s0, $s1	#Store the quotient of dividing the integer by the base
	rem $t9, $s0, $s1	#Store the remainder of dividing the integer by the base
	addi $sp, $sp, -4	#Subtract the stack pointer by 4
	sw $t9, 0x0($sp)	#Store the remainder to the address of the first byte of the stack

	move $a0, $t8 		#Store the quotient
	move $a1, $s1 		#Store the base
	addi $s8, $s8, 0x1	#Increment the counter
	jal con        

end:

	lw $ra, 0x0($sp)	#Load the address of the first byte of the stack to the return address
	lw $s1, 0x4($sp)
	lw $s0, 0x8($sp)
	lw $s8, 0xc($sp)	#Load the total count of the times the stack is popped to $s8
	beqz $s8, jra		#End the iteration if the above is equal to 0
	lw $a0, 0x10($sp)	#Load the third element of the stack to the integer 
	li $v0, 1			#Print the result of the base convertion
	syscall
jra: 
	addi $sp, $sp, 0x14	#Add 20 to the stack pointer
	jr $ra   			#Jump to the return address
	
	.data
ask: .asciiz "Enter a number: "
reply: .asciiz "Input number is "
binary: .asciiz "\nBinary: "
quaternary: .asciiz "\nQuaternary: "
octal: .asciiz "\nOctal: "
continue: .asciiz "\nContinue? (1=Yes/0=No) "
bye: .asciiz "Bye!"