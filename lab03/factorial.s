.globl factorial

.data
n: .word 30

.text
main:
    la t0, n				# load the address of value of n
    lw a0, 0(t0)			# a0 = n, serve as parameter
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp, sp, -8		
    sw s0, 0(sp)		# save s0
    sw ra, 4(sp)		# save ra
    
    addi s0, x0, 1		# res = 1
    addi t1, x0, 1		# i = 1
    add t2, x0, a0		# n
loop:
    beq t1, t2, finish  
    addi t1, t1, 1		# i += 1
    mul s0, s0, t1    	# res *= i
    jal x0, loop
	
finish:
	add a0, x0, s0	# save return value
    
    lw s0, 0(sp)	# restore s0
    lw ra, 4(sp)	# restore ra
    
    jr ra