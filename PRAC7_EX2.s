.data
led_value:  .word 0x0000
led_index:  .word 0
direction:  .word 1       # 1 = R, -1 = L
delay_count: .word 1000000

.text
.globl main

main:
    # Inicialització
    jal init_gpio
    jal enable_all_leds
    
main_loop:
    jal read_switches
    jal update_direction
    jal move_led
    jal delay
    j main_loop

## Subrutinas

init_gpio:
    li t0, 0xFFFF
    li t1, 0x80001408     # GPIO_INOUT
    sw t0, 0(t1)
    ret

enable_all_leds:
    li t0, 0xFFFF
    li t1, 0x80001404     # GPIO_LEDs
    sw t0, 0(t1)
    la t2, led_value
    sw t0, 0(t2)
    ret

read_switches:
    li t1, 0x80001400     # GPIO_SWs
    lw t0, 0(t1)
    srli t0, t0, 16       # switches_value >> 16
    ret

update_direction:
    # Switch 1 (bit 0) actiu i switch 2 (bit 1) inactiu (derecha 1)
    andi t1, t0, 0x0001
    andi t2, t0, 0x0002
    beqz t1, check_sw2
    bnez t2, check_both
    li t3, 1
    j store_direction

check_sw2:
    # Switch 2 actiu y switch 1 inactiu (izquierda -1)
    beqz t2, no_change
    li t3, -1
    j store_direction

check_both:
    # Dos switches actius (parar 0)
    li t3, 0

store_direction:
    la t4, direction
    sw t3, 0(t4)

no_change:
    ret

move_led:
    la t0, direction
    lw t1, 0(t0)
    beqz t1, end_move     # Si adr = 0, quiet
    
    # Apagar LED actual
    la t2, led_index
    lw t3, 0(t2)
    la t4, led_value
    lw t5, 0(t4)
    li t6, 1
    sll t6, t6, t3
    not t6, t6
    and t5, t5, t6
    
    # Actualizar índ
    add t3, t3, t1
    
    # Ajustaments pepr quan arribem als extrems dels LEDS
    #C: if(led<0) led=15 ...
    li t6, 15
    ble t3, t6, no_wrap_right
    li t3, 0
no_wrap_right:
    bgez t3, no_wrap_left
    li t3, 15
no_wrap_left:
    sw t3, 0(t2)
    
    # Encenem LED de nou
    li t6, 1
    sll t6, t6, t3
    or t5, t5, t6
    sw t5, 0(t4)
    
    # Actualitzar estat del Led
    li t1, 0x80001404
    sw t5, 0(t1)

end_move:
    ret

delay:
    la t0, delay_count
    lw t1, 0(t0)
    li t2, 0
delay_loop:
    bge t2, t1, delay_end
    addi t2, t2, 1
    j delay_loop
delay_end:
    ret