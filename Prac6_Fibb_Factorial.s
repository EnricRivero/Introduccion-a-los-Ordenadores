.data
    valor: .word 10
    factorial: .word 0

.text
.globl main
main:
    la a1, valor
    lw a2, 0(a1)
    li a3, 1
    ble a2, a3, final
    call subrutinaFactorial
    call subrutinaFibonacci
final:
    sw a4, 4(a1)
while_true:
    nop
    j while_true

subrutinaFactorial:
    addi sp, sp, -8
    sw a2, 0(sp)
    sw a3, 4(sp)
loopFac:
    beqz a2, end
    mul a3, a2, a3
    bltz a3, negatiu
    addi a2, a2, -1
    j loopFac
negatiu:
    li a3, -1
end:
    mv a4, a3
    lw a3, 4(sp)
    lw a2, 0(sp)
    addi sp, sp, 8
    ret

subrutinaFibonacci:
    addi sp, sp, -16
    sw a1, 0(sp)
    sw a2, 4(sp)
    sw a3, 8(sp)
    sw a4, 12(sp)
    lw a2, 0(a1)
    li a3, 0
    li a4, 1
    li a0, 0
    beq a2, a3, endFib
    sw a3, 0x50(a1)
    addi a0, a0, 1
    beq a0, a2, endFib
    addi a1, a1, 4
    sw a4, 0x50(a1)
    addi a0, a0, 1
loopFib:
    beq a0, a2, endFib
    add a5, a4, a3
    mv a3, a4
    mv a4, a5
    addi a1, a1, 4
    sw a5, 0x50(a1)
    addi a0, a0, 1
    j loopFib
endFib:
    lw a4, 12(sp)
    lw a3, 8(sp)
    lw a2, 4(sp)
    lw a1, 0(sp)
    addi sp, sp, 16
    ret
