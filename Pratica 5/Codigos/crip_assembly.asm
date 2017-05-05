.data

vec: .word 48, 56, 49, 54, 54
tam: .word 5

.text

main: 
	la $s0, vec #s0 recebe endereço base de vec
	lw $t0, tam # t0 recebe 10 (tamanho do vetor)
	jal print_orig # printa "Original: "
	jal print_vec # printa vetor
	jal print_enter
	jal crip # criptografa
	jal print_crip # printa "Criptografado: "
	jal print_vec # printa vetor
	jal print_enter
	jal descrip # descriptografa
	jal print_descrip # printa "Descriptografado: "
	jal print_vec # printa vetor
	j end

jump_back:
	jr $ra

print_vec:
	add $t1, $zero, $zero # i inicia com zero
loop1:	slt $t2, $t1, $t0 # Se i(t1) < tam(t0), t2=1
	beq $t2, $zero, jump_back
	add $t2, $t1, $t1
	add $t2, $t2, $t2
	add $t2, $t2, $s0
	lw $t3, 0($t2)
		la $a0, ($t3)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
	addi $t1, $t1, 1 # i++
	j loop1

crip:
	addi $s1, $zero, 1 #s1=1
	subi $t1, $t0, 2 # i = tam-2
	lw $t5, 16($s0)
loop2:	slt $t2, $t1, $zero # Se i>=0, t2=0
	beq $t2, $s1, jump_back # volta para main se i<0 (t2=1)
	add $t2, $t1, $t1 # t2 = 2i
	add $t2, $t2, $t2 # t2 = 4i
	add $t2, $t2, $s0 # t2 é endereço base de vec[i]
	lw $t3, 0($t2) # vec[i]
	add $t6, $t3, $zero
	sub $t3, $t3, $t5 # t3 = vec[i]-vec[i+1]
	add $t5, $t6, $zero
	slt $t4, $t3, $zero # Se t3<0, t4=1
	beq $t4, $zero, maiorzero # se t4 for zero implica que t3>=0
	addi $t3, $t3, 255 # Só entra se t3<0 (t4=1), t3+255
maiorzero:	sw $t3, 0($t2) # salva t3 em vec[i]
	subi $t1, $t1, 1 # i--
	j loop2 # volta no loop

descrip:
	addi $s1, $zero, 1 # s1=1
	subi $t1, $t0, 2 # i(t1) = tam-2
loop3:	slt $t2, $t1, $zero # Se i>=0, t2=0
	beq $t2, $s1, jump_back # volta para main se i<0 (t2=1)
	add $t2, $t1, $t1 # t2 = 2i
	add $t2, $t2, $t2 # t2 = 4i
	add $t2, $t2, $s0 # t2 é endereço base de vec[i]
	lw $t3, 0($t2) # vec[i]
	lw $t4, 4($t2) # vec[i+1]
	add $t3, $t3, $t4 #t3 = vec[i] + vec[i+1]
	subi $s2, $t3, 255 # s2 = t3-255
	slt $t4, $zero, $s2 # Se 0<s2 (t3>255), t4=1
	beq $t4, $zero, menor255 # desvia caso t3<255
	subi $t3, $t3, 255 # subtrai 255 de t3 (só entra se s2>0)
menor255:	sw $t3, 0($t2) #salva t3 em vec[i]
	subi $t1, $t1, 1 #i--
	j loop3 # volta ao loop

.data

space: .asciiz " "
enter: .asciiz "\n"
orig: .asciiz "Original: "
crips: .asciiz "Criptografado: "
descrips: .asciiz "Descriptografado: "

.text
print_enter:
	la $a0, enter
	li $v0, 4
	syscall
	jr $ra
print_crip:
	la $a0, crips
	li $v0, 4
	syscall
	jr $ra
print_descrip:
	la $a0, descrips
	li $v0, 4
	syscall
	jr $ra
print_orig:
	la $a0, orig
	li $v0, 4
	syscall
	jr $ra

end:
