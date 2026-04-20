.data
    n: .word 10          # fib(10)
    result: .word 0      # Resultat

.text
.globl main
main:
    la a1, n             # Adr de 'n'
    lw a2, 0(a1)         # a2 = n
    call fib             # Cridem subrutina
    sw a3, 4(a1)         # Guardem en result
    j end

fib:
    # Casos base
    li t0, 1
    ble a2, t0, cas_base
    # Pila
    addi sp, sp, -12
    sw ra, 0(sp)
    sw a2, 4(sp)
    # fib(n-1)
    addi a2, a2, -1
    call fib
    sw a3, 8(sp)
    # fib(n-2)
    lw a2, 4(sp)
    addi a2, a2, -2
    call fib
    # fib(n-1) + fib(n-2)
    lw t1, 8(sp)
    add a3, t1, a3
    # Restaurar pila
    lw ra, 0(sp)
    addi sp, sp, 12
    ret

cas_base:
    mv a3, a2            # fib(0)=0, fib(1)=1
    ret

end:
    j end
