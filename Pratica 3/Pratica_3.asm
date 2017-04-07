	.data
a:  .word 1, 2, 3, 4, 32, 43, 12, 98
tam: .word 32

	.text
main:	addi $a0, $zero, 31  # a0 = 31
	addi $a1, $zero, 34  # a1 = 34
	add $s0, $zero, $a0
	add $s1, $zero, $a1
	jal g              	       # chama função
	add $t0, $zero, $v0   #salva em $t0 o valor de retorno da função
	j end                  		# termina programa

g: 	lw $t4, tam		# t4 recebe o limite do vetor para ir preenchendo de 0
	la $t5, a		# t5 recebe endereço base de a
	addi $t0, $zero, 0	# t0 inicia com 0
	addi $t1, $zero, 8	# t1 inicia com 8
loop:	slt $t3, $t1, $t4  	# Se index < limite, t3=1
	beq $t3, $zero,  corpog	# Se t3==0, é pq já preencheu todo o vetor
	add $t6, $t1, $t1	# t6 = 2t1
	add $t6, $t6, $t6	# t6 = 4t1
	add $t2, $t5,  $t6	# Salva em t2 o endereço de a[index]
	sw $t0, 0($t5)		# a[index] = 0
	li $v0, 1             #id 4 é pra printar string
        la $a0, 0($t0)         #passa qual string será printada
        syscall
        li $v0, 4
        la $a0, n
        syscall
        add $a0, $s0, $zero
	addi $t1, $t1, 1		# index++
	j loop			# volta no loop

corpog:	addi $t2, $a0, -1	# t2 = x-1
for:	addi $t2, $t2, 1		# t2++
	slt $t3, $t2, $a1		# Se i<y t3 =1
	beq $t3, $zero,  return	# Se t3==0, sai do for
	add $t3, $t2, $a1	# t3 = i + y
	add $t4, $t2, $t2	# t4 = 2i
	add $t4, $t4, $t4	# t4 = 4i
	add $t4, $t5, $t4	# t4 é o endereço base de a[i]
	sw $t3, 0($t4)		# a[i] = i + y
	li $v0, 1             #id 4 é pra printar string
        la $a0, 0($t3)         #passa qual string será printada
        syscall
        li $v0, 4
        la $a0, n
        syscall
        li $v0, 1
        la $a0, 0($t2)
        syscall
        li $v0, 4
        la $a0, n
        syscall
        add $a0, $s0, $zero
	j for			# volta pro for
	
return: 	
	addi $t2, $t2, -1 	# t2 = i-1
	add $t2, $t2, $t2
	add $t2, $t2, $t2
	add $t2, $t5, $t2	# t2 é o endereço base de a[i-1]
	lw $v0, 0($t2)		# Salva o valor de a[i-1] no registrador de retorno
	jr $ra			# Volta pra linha seguinte à chamada da função

end:
 
.data
n: .ascii "\n"
	
	
	
