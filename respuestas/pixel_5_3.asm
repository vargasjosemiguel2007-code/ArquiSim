# Pregunta 4.1: pinta de verde (color 2) el pixel (5,3) -> 0x400 + 32*3 + 5 = 0x465
        addi $t0, $zero, 2
        sb   $t0, 0x465($zero)
