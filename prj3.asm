# Group 4
# Jonathan Martin and Bradyn Combs

.data
x1: .asciiz "x1 = "
x2: .asciiz "\nx2 = "
x3: .asciiz "\nx3 = "
newline: .asciiz "\n"
noAns: .asciiz "no solution"
infinity: 

.text 
.globl main
addi $t0, $zero, 0
main:
#get the 12 floats
li $v0, 6
syscall
mfc1 $t0, $f0 #a11 in $t0

li $v0, 6
syscall
mfc1 $t1, $f0 #a12 in $t1

li $v0, 6
syscall
mfc1 $t2, $f0 #a13 in $t2

li $v0, 6
syscall
mfc1 $t3, $f0 #a21 in $t3

li $v0, 6
syscall
mfc1 $t4, $f0 #a22 in $t4s

li $v0, 6
syscall
mfc1 $t5, $f0 #a23 in $t5

li $v0, 6
syscall
mfc1 $t6, $f0 #a31 in $t6

li $v0, 6
syscall
mfc1 $t7, $f0 #a32 in $t7

li $v0, 6
syscall
mfc1 $t8, $f0 #a33 in $t8

li $v0, 6
syscall
mfc1 $s0, $f0 #b1 in $s0

li $v0, 6
syscall
mfc1 $s1, $f0 #b2 in $s1

li $v0, 6
syscall
mfc1 $s2, $f0 #b3 in $s2


#take floats out of regs to fp regs
mtc1 $t0, $f0
mov.s $f1, $f0

mtc1 $t1, $f0
mov.s $f2, $f0

mtc1 $t2, $f0
mov.s $f3, $f0

mtc1 $t3, $f0
mov.s $f4, $f0

mtc1 $t4, $f0
mov.s $f5, $f0

mtc1 $t5, $f0
mov.s $f6, $f0

mtc1 $t6, $f0 
mov.s $f7, $f0

mtc1 $t7, $f0
mov.s $f8, $f0

mtc1 $t8, $f0
mov.s $f9, $f0

mtc1 $s0, $f0
mov.s $f10, $f0

mtc1 $s1, $f0 
mov.s $f11, $f0

mtc1 $s2, $f0
mov.s $f12, $f0

sub.s $f0, $f0, $f0 #set f0 = 0 for later use
# f1x + f2x + f3x = f10
# f4x + f5x + f6x = f11
# f7x + f8x + f9x = f12

#impliment Cramer's Rule

#find D
#D matrix 
# f1, f2, f3
# f4, f5, f6
# f7, f8, f9
mul.s $f21, $f5, $f9
mul.s $f22, $f6, $f8
sub.s $f22, $f21, $f22     
mul.s $f22, $f22, $f1 # f22 = f1[(f5)(f9) - (f8)(f6)]
       
mul.s $f23 $f4, $f9
mul.s $f24, $f6, $f7
sub.s $f24, $f23, $f24
mul.s $f24, $f24, $f2 # f24 = f2[(f4)(f9) - (f7)(f6)]

sub.s $f24, $f22, $f24 #f22 - f24
        
mul.s $f25, $f4, $f8
mul.s $f26, $f5, $f7
sub.s $f26,$f25,$f26
mul.s $f26, $f26,$f3 # f26 = f3[(f4)(f8) - (f5)(f7)]      

add.s $f27, $f24,$f26 # f27 = $f24 + $f26

mov.s $f28, $f27 #determinant D in $f28
c.eq.s $f28, $f0 #if D = 0, no solution
bc1t noAnsExit

#find Dx
#Dx matrix 
# f10, f2, f3
# f11, f5, f6
# f12, f8, f9
mul.s $f21, $f5, $f9
mul.s $f22, $f6, $f8
sub.s $f22, $f21, $f22     
mul.s $f22, $f22, $f10 # f22 = f10[(f5)(f9) - (f8)(f6)]
        
mul.s $f23 $f11, $f9
mul.s $f24, $f6, $f12
sub.s $f24, $f23, $f24
mul.s $f24, $f24, $f2 # f24 = f2[(f11)(f9) - (f12)(f6)]  

sub.s $f24, $f22, $f24 #f22 - f24
            
mul.s $f25, $f11, $f8
mul.s $f26, $f5, $f12
sub.s $f26,$f25,$f26
mul.s $f26, $f26,$f3 # f26 = f3[(f11)(f8) - (f5)(f12)]   

add.s $f27, $f24,$f26 # f27 = $f24 + $f26

mov.s $f29, $f27 #determinant Dx in $f29
c.eq.s $f29, $f0 #if Dx = 0, no solution
bc1t noAnsExit

#find Dy
#Dy matrix 
# f1, f10, f3
# f4, f11, f6
# f7, f12, f9
mul.s $f21, $f11, $f9
mul.s $f22, $f6, $f12
sub.s $f22, $f21, $f22     
mul.s $f22, $f22, $f1 # f22 = f1[(f11)(f9) - (f12)(f6)]

mul.s $f23 $f4, $f9
mul.s $f24, $f6, $f7
sub.s $f24, $f23, $f24
mul.s $f24, $f24, $f10 # f24 = f10[(f4)(f9) - (f7)(f6)] 

sub.s $f24, $f22, $f24 #f22 - f24
             
mul.s $f25, $f4, $f12
mul.s $f26, $f11, $f7
sub.s $f26,$f25,$f26
mul.s $f26, $f26,$f3 # f26 = f3[(f4)(f12) - (f11)(f7)]     

add.s $f27, $f24,$f26 # f27 = $f24 + $f26

mov.s $f30, $f27 #determinant Dy in $f30
c.eq.s $f30, $f0 #if Dy = 0, no solution
bc1t noAnsExit

#find Dz
#Dz matrix 
# f1, f2, f10 = f3
# f4, f5, f11 = f6
# f7, f8, f12 = f9
mul.s $f21, $f5, $f12
mul.s $f22, $f11, $f8
sub.s $f22, $f21, $f22     
mul.s $f22, $f22, $f1 # f22 = f1[(f5)(f12) - (f8)(f11)]
      
mul.s $f23 $f4, $f12
mul.s $f24, $f11, $f7
sub.s $f24, $f23, $f24
mul.s $f24, $f24, $f2 # f24 = f2[(f4)(f12) - (f7)(f11)]   

sub.s $f24, $f22, $f24 #f22 - f24
           
mul.s $f25, $f4, $f8
mul.s $f26, $f5, $f7
sub.s $f26,$f25,$f26
mul.s $f26, $f26,$f10 # f26 = f10[(f4)(f8) - (f5)(f7)]   

add.s $f27, $f24,$f26 # f27 = $f24 + $f26

mov.s $f31, $f27 #determinant Dz in $f31
c.eq.s $f31, $f0 #if Dz = 0, no solution
bc1t noAnsExit

#find x1, x2, and x3
div.s $f29, $f29, $f28  #x1 = Dx/D

div.s $f30, $f30, $f28  #x2 = Dy/D

div.s $f31, $f31, $f28 #x3 = Dz/D


li      $v0,4       
la      $a0,x1
syscall
li $v0, 2
mov.s $f12, $f29   
syscall

li      $v0,4       
la      $a0,x2
syscall
li $v0, 2
mov.s $f12, $f30 
syscall

li      $v0,4       
la      $a0,x3
syscall
li $v0, 2
mov.s $f12, $f31   
syscall

exit:
li $v0, 10
syscall

noAnsExit:
li      $v0,4       
la      $a0,noAns  
syscall             
j exit


