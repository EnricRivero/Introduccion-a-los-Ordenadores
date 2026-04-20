#EUCLIDES
.data 
a: .word 252 
b: .word 105
resultat: .word 0 

.text 
la a0, a
lw a1, 0(a0)
lw a2, 4(a0)

loop:
beq a1, a2, desa     #En cas de ser iguals seguim
blt a2, a1, ifAgran  #If a2 < a1 -> Anirem a la etiqueta if
j else

ifAgran:
sub a2, a2, a1        #a2 = a2 -a1
j loop
else:
sub a1, a1, a2        #a1 = a1 -a2
j loop

desa: 
sw a1, 8(a0) 
