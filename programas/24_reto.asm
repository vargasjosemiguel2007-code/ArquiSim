# Reto -- Contar los negativos de un arreglo y pintar un pixel rojo por cada uno
# Autor: Jose Miguel
# CONTAR($a0 = dirección del arreglo, $a1 = tamaño) devuelve en $v0 cuántos son negativos.
# El principal guarda el resultado en NEG (sw) y pinta un pixel rojo (color 1) por cada
# negativo en la fila 0 de la pantalla: pixel (x, 0) = 0x400 + x.

.data
ARR:    .word 5, -3, 8, -1, -7, 2, -4, 9     # 4 negativos
NEG:    .word 0

.text
        la    $a0, ARR              # $a0 = dirección del arreglo
        li    $a1, 8                # $a1 = tamaño
        jal   CONTAR
        la    $t0, NEG
        sw    $v0, 0($t0)           # NEG = cantidad de negativos

        addi  $t1, $zero, 1         # color rojo
        add   $t2, $zero, $zero     # x = 0
PINTA:  beq   $t2, $v0, FIN         # un pixel por negativo
        sb    $t1, 0x400($t2)       # pixel (x, 0)
        addi  $t2, $t2, 1
        j     PINTA
FIN:    j     SALIR

# ---------------- CONTAR ----------------
CONTAR: add   $v0, $zero, $zero     # contador = 0
        add   $t3, $zero, $zero     # i = 0
CICLO:  beq   $t3, $a1, VUELVE
        sll   $t4, $t3, 2           # i * 4
        add   $t4, $t4, $a0
        lw    $t5, 0($t4)           # ARR[i]
        slt   $t6, $t5, $zero       # 1 si es negativo
        add   $v0, $v0, $t6
        addi  $t3, $t3, 1
        j     CICLO
VUELVE: jr    $ra
SALIR:
