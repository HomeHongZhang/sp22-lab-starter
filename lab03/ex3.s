.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1 		# (x+1)
    sub t1, x0, a0		# (-x)
    mul a0, t0, t1		# -x * (x+1)
    jr ra				# return with the result

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20	# allocate stack with 5 frames
    sw s0, 0(sp)		# sum
    sw s1, 4(sp)		# source
    sw s2, 8(sp)		# dest
    sw s3, 12(sp)		# offset of index
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0		# k = 0
    addi s0, x0, 0		# sum = 0
    la s1, source 		# load the address of the source
    la s2, dest   		# load the address of the destination
loop:
    slli s3, t0, 2		# get begin address offset
    add t1, s1, s3		# t1 = source[k]
    lw t2, 0(t1)		# t2 = source[k], write to memory
    beq t2, x0, exit	# exit loop once 
    add a0, x0, t2		# a0 = source[k]
    addi sp, sp, -8		# allocate 2 new frames
    sw t0, 0(sp)		# save k
    sw t2, 4(sp)		# save source[k]
    jal fun				# call `fun()`
    lw t0, 0(sp)		# restore k
    lw t2, 4(sp)		# restore source[k]
    addi sp, sp, 8		# deallocate 2 frames
    add t2, x0, a0		# source[k] = a0
    add t3, s2, s3		# t3 = dest[k]
    sw t2, 0(t3)		# t2 = dest[k], write to memory
    add s0, s0, t2		# sum += dest[k]
    addi t0, t0, 1		# k++
    jal x0, loop		# jump to `loop` without saving the return address
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra
