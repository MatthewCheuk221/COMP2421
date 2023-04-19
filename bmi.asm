#
# This program returns Body Mass Index (BMI) value
#
# Procedures:
#1. Print message: "Enter Weight (whole pound): "
#2. Read the input integer from the console
#3. Print message: "Enter Height (whole inch): "
#4. Read the input integer from the console
#5. Calculate the BMI
#6. Show the result on Console: "Your BMI is: "
#
.data
str1: .asciiz "Enter Weight (whole pound): "
str2: .asciiz "Enter Height (whole inch): "
str3: .asciiz "Your BMI is: "
.globl main # Global variable: the entry point of the prog.
.text
main:
#
#Step 1: Print the prompt message using system call 4 #
la $a0, str1 # load string address into $a0 and I/O code into $v0
li $v0, 4
syscall # print the message on console
#
#Step 2: Read the integer from the console using system call 5
#
li $v0, 5
syscall
move $s0, $v0
#
#Step 3: Repeat Step 1 and Step to read in "Height"
#
la $a0, str2 # load string address into $a0 and I/O code into $v0
li $v0, 4
syscall # print the message on console
li $v0, 5
syscall
move $s1, $v0
#
#Step 4: Calculate the BMI (mass * 703) / (height)^2
#
li $t0, 703
mult $t0, $s0
mflo $t1
mult $s1, $s1
mflo $t2
div $t1, $t2
mflo $s2
#
#Step 5: Print the result message using system call 4
#
la $a0, str3 # load string address into $a0 and I/O code into $v0
li $v0, 4
syscall # print the message on console
#
#Step 6: Print the BMI
#
move $a0, $s2
li $v0, 1
syscall
li $v0, 10 # syscall code 10 for terminating the program
syscall