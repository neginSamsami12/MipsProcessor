addi $t0, $zero, 5
addi $t1, $zero, 10
add  $t2, $t0, $t1
sub  $t3, $t1, $t0
and  $t4, $t0, $t1
or   $t5, $t0, $t1
slt  $t6, $t0, $t1
sw   $t2, 0($zero)
lw   $t7, 0($zero)
beq  $t7, $t2, 2
addi $t7, $t7, 1
addi $t0, $zero, 100
j    14
addi $t0, $zero, 200
addi $t1, $zero, 50