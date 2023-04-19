	.data
msg1: .asciiz "Please insert value (A > 0) : "
msg2: .asciiz "Please insert the number system B you want to convert to (2<=B<=10): "
#Above sting must be in one line
msg3: .asciiz "\nResult : "
	.text
	.globl main
main:
	addi $s0,$zero,2
	addi $s1,$zero,10
getA:

	li $v0,4
	la $a0,msg1
	syscall
	li $v0,5
	syscall
	blt $v0,$zero,getA

	move $t0,$v0
getB:

	li $v0,4
	la $a0,msg2
	syscall
	li $v0,5
	syscall
	blt $v0,$s0,getB
	bgt $v0,$s1,getB

	add $t1,$zero,$v0

	li $v0,4
	la $a0,msg3
	syscall

	add $a0,$zero,$t0
	add $a1,$zero,$t1

	jal convert

	li $v0,10
	syscall

convert:
#a0=A
#a1=B

	addi $sp,$sp,-16

	sw $s3,12($sp) #counter,used to know
	#how many times we will pop from stack
	sw $s0,8($sp) #A
	sw $s1,4($sp) #B
	sw $ra,0($sp)

	add $s0,$zero,$a0
	add $s1,$zero,$a1

	beqz $s0,end

	div $t4,$s0,$s1 #t4=A/B
	rem $t3,$s0,$s1 #t3=A%B
	add $sp,$sp,-4
	sw $t3,0($sp) #save t3

	add $a0,$zero,$t4 #pass A/B
	add $a1,$zero,$s1 #pass B
	addi $s3,$s3,1
	jal convert        #call convert

end:

	lw $ra,0($sp)
	lw $s1,4($sp)
	lw $s0,8($sp)
	lw $s3,12($sp)
	beqz $s3,done
	lw $a0,16($sp)
	li $v0,1
	syscall
done: 
	addi $sp,$sp,20
	jr $ra   #return