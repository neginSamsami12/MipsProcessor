# fib1
addi $t0, $zero, 1

# fib2
addi $t1, $zero, 1

# counter
addi  $t3, $zero, 2

# nth fib number greater than 2
addi $t4, $zero, 6

# result
add $t2, $t0, $t1

addi $t3, $t3, 1
beq $t3, $t4, 3
addi $t0, $t1, 0
addi $t1, $t2, 0
j 4
