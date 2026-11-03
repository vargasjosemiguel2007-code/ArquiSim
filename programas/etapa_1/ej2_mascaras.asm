# Ejercicio 2 -- Constantes de 32 bits y máscaras
# Instrucciones: lui, ori, addi, and, andi, or, xor, xori, nor, srl
#
# 1. Cargue x = 0x12345678 en $s0 (con lui + ori).
# 2. $s1 = los bits 11..8 de x, como número de 0 a 15.
# 3. $s2 = x con el bit 3 apagado (los demás bits iguales).
#    Ojo: andi extiende el inmediato con CEROS; arme la máscara en un registro.
# 4. $s3 = x con el byte bajo (bits 7..0) invertido.
# 5. Ya está escrito al final: prediga el valor de $s4 y de $s5 antes de ejecutar.
#
# Preguntas: ¿por qué $s4 no es 0xDEADBEEF? ¿Por qué el paso 3 no sirve con andi?
#   - addi extiende el signo de 0xBEEF (bit 15 = 1): suma 0xFFFFBEEF y le resta 1 a la
#     parte alta, por eso queda 0xDEACBEEF. Para armar la constante se usa ori.
#   - andi extiende con ceros: la máscara 0x0000FFF7 borra también los 16 bits altos
#     ($s5 = 0x00005670), mientras que el paso 3 debe conservarlos.
#
# Complete ej2_mascaras.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej2_mascaras.asm
.text
        lui  $s0, 0x1234
        ori  $s0, $s0, 0x5678       # 1. x = 0x12345678
        srl  $t0, $s0, 8
        andi $s1, $t0, 0xF          # 2. bits 11..8 de x = 6
        addi $t1, $zero, -9         # máscara 0xFFFFFFF7: solo el bit 3 en 0
        and  $s2, $s0, $t1          # 3. x con el bit 3 apagado
        xori $s3, $s0, 0xFF         # 4. x con el byte bajo invertido

# ---------------- Paso 5 (no lo modifique) ----------------
        lui  $s4, 0xDEAD
        addi $s4, $s4, 0xBEEF       # ¿qué valor queda?
        andi $s5, $s0, 0xFFF7       # ¿es lo mismo que el paso 3?
