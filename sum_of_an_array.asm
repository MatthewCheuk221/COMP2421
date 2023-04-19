# Program: sum of an array
.data
array: .word 17, 2, 3, -5, 4 # declare an array
.globl main
.text
main:
li $s1, 0 # zero the sum
li $t1, 0 # init index to 0
li $t2, 0 # init loop counter
for:
beq $t2, 5, endfor # for(i = 0; i < 5 ; i++)
lw $v1, array($t1)
add $s1, $s1, $v1 # sum = sum + array[i]
addi $t1, $t1, 4 # index++
addi $t2, $t2, 1 # counter++
j for
endfor:
li $v0, 10 # exit
syscall