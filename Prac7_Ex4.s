.data
display_table:  # Tabla de digits per en 7 segmentos (núm microones)
    .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text
.globl main

main:
    # Configurar GPIO
    li t0, 0xFFFF
    li t1, 0x80001408     # GPIO_INOUT
    sw t0, 0(t1)

loop:
    # Llegir switches (16 bits)
    li t1, 0x80001400     # GPIO_SWs
    lw t2, 0(t1)          # t2 = valor switches (32 bits)
    srli t2, t2, 16       # t2 = switches_value (bits 15-0)

    # Verificar CLEAR (switch 15)
    li t0, 0x8000         # Máscara para switch 15 (bit 15)
    and t3, t2, t0
    bnez t3, clear_display

    # El passem a BCD 
    li t0, 0x7FFF         # Máscara para 0-32,767 (15 bits)
    and t2, t2, t0        # Ignorar bit 15 (CLEAR)

    # Escritura en display
    li t1, 0x8000103C     # DISPPLAY_WRITE (valor hexadecimal)
    sw t2, 0(t1)          # Mostrar valor
    j loop

clear_display:
    # Apagar tots els displays
    li t1, 0x8000103C     # DISPPLAY_WRITE
    sw zero, 0(t1)        # Escriuer 0
    j loop
