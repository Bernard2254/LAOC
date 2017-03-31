	.data
number: .word 2344
const:  .word 80
	.text
	
	lw $t0, number        #t0 -> var1 = 2344
	lw $s0, const         #s0 = 80
	addi $t1, $zero, 1    #t1 -> 1
	li $v0, 4             #id 4 é pra printar string
        la $a0, texto         #passa qual string será printada
        syscall		      #coloca na tela

loop:   slt $t2, $t0, $s0     # Se var1 < 80 $t2 = 1
	beq $t2, $t1, menor   # Se t2==1 vai para menor
	beq $t0, $s0, menor   # Se var1==80 vai para menor pq queremos <=
	addi $t0, $t0, -2     # Se não reduz dois
	jal print             # Jump para a label print

menor:  div $t0,$t0,4         # var1 = var1/4
        jal print             # Jump para a label print
	
	
print:  li $v0, 1             # Id=1 printa numero
        la $a0, ($t0)         # Passa o numero a ser printado
	syscall               # Coloca na tela
	li $v0, 4             # Id=4 printa string
        la $a0, enter         # Passa string a ser printada
        syscall               # Coloca na tela
	bne $t0, $t1, loop    # Se var1!=1 volta para o loop
	
	.data
espaço: .asciiz  " "
enter: .asciiz  "\n"
texto: .asciiz  "Teste:\n"