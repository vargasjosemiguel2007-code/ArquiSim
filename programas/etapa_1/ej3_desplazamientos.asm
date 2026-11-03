# Ejercicio 3 -- Multiplicar y dividir con desplazamientos
# Instrucciones: sll, srl, sra, add, sub, addi
#
# Con x = 37 en $s0, calcule SIN mult (solo desplazamientos, sumas y restas):
#   $s1 = 10x        pista: 10x = 8x + 2x
#   $s2 = 7x
# Con y = -20 en $s3 y z = -7 en $s4:
#   $s5 = y sra 2
#   $s6 = y srl 2
#   $s7 = z sra 1
#
# Preguntas: ¿por qué $s6 da un número enorme? ¿Hacia dónde redondea sra (-7/2)?
#   - srl rellena con ceros: el signo se pierde y 0xFFFFFFEC pasa a ser 0x3FFFFFFB.
#   - sra redondea hacia menos infinito: -7/2 = -3.5 da -4 (no -3).
#
# Complete ej3_desplazamientos.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej3_desplazamientos.asm
.text
        addi $s0, $zero, 37         # x
        addi $s3, $zero, -20        # y
        addi $s4, $zero, -7         # z
        sll  $t0, $s0, 3            # 8x
        sll  $t1, $s0, 1            # 2x
        add  $s1, $t0, $t1          # 10x = 370
        sub  $s2, $t0, $s0          # 7x = 8x - x = 259
        sra  $s5, $s3, 2            # -20 >> 2 = -5
        srl  $s6, $s3, 2            # 0x3FFFFFFB
        sra  $s7, $s4, 1            # -7 >> 1 = -4

