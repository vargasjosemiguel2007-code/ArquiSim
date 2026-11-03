# Ejercicio 4 -- De m/s a km/h sin multiplicar ni dividir (punto fijo)
# Instrucciones: sll, add, srl
#
#   km/h = 3.6 * (m/s), pero el procesador no tiene decimales.
#   Aproximamos 3.6 con una fracción cuyo denominador es potencia de 2:
#       3.6  ~  461 / 128 = 3.6016
#       km/h ~  (461 * v) >> 7         con  461 = 256 + 128 + 64 + 8 + 4 + 1
#
# Con v = 20 m/s en $s0:
#   $t0 = 461 * v   (solo sll y add)
#   $s1 = $t0 >> 7  (la velocidad en km/h)
#
# Preguntas: pruebe luego con v = 3 (exacto: 10.8 km/h). ¿Qué da el programa y por qué?
# ¿Qué fracción usaría para más precisión y qué riesgo hay si el numerador crece?
#   - Con v = 3: 461*3 = 1383 y 1383 >> 7 = 10 (exacto 10.8): srl trunca los decimales.
#   - 3.6 ~ 3687/1024 = 3.6006 o 29491/8192 = 3.60001. Riesgo: numerador por v
#     puede pasar de 32 bits y perder los bits altos.
#
# Complete ej4_velocidad.esperado y verifique con:
#   ./sim -t programas/etapa_1/ej4_velocidad.asm
.text
        addi $s0, $zero, 20         # v = 20 m/s
        sll  $t1, $s0, 8            # 256v
        sll  $t2, $s0, 7            # 128v
        sll  $t3, $s0, 6            # 64v
        sll  $t4, $s0, 3            # 8v
        sll  $t5, $s0, 2            # 4v
        add  $t0, $t1, $t2
        add  $t0, $t0, $t3
        add  $t0, $t0, $t4
        add  $t0, $t0, $t5
        add  $t0, $t0, $s0          # 461v = 9220
        srl  $s1, $t0, 7            # km/h = 72

