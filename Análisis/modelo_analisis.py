# modelo_basico_brazo.py

import math

g = 9.81

# -------------------------
# Longitudes [m]
# -------------------------
L1 = 0.08
L2 = 0.16
L3 = 0.12
L4 = 0.05
L5 = 0.06

# -------------------------
# Masas [kg]
# -------------------------
m_motor = 0.145

m_L1 = 0.00
m_L2 = 0.00
m_L3 = 0.00
m_L4 = 0.00
m_L5 = 0.00
m_EF = 0.05
m_L2 = 0.18
m_L3 = 0.16
m_L4 = 0.10
m_L5 = 0.08

# Motores individuales, por si después alguno cambia
m_M1 = m_motor
m_M2 = m_motor
m_M3 = m_motor
m_M4 = m_motor
m_M5 = m_motor

# -------------------------
# Ángulos absolutos [grados]
# Medidos desde eje X positivo
# -------------------------
theta1 = 60
theta2 = 95
theta3 = -35
theta4 = -70
theta5 = -10

# -------------------------
# Funciones auxiliares
# -------------------------
def punto_desde(p, L, ang_deg):
    """Devuelve un punto a distancia L y ángulo ang_deg desde p."""
    x, z = p
    a = math.radians(ang_deg)
    return (
        x + L * math.cos(a),
        z + L * math.sin(a)
    )

def torque_respecto_a(pivote, masa, punto_masa):
    """
    Torque estático respecto a un pivote en el plano X-Z.
    La gravedad actúa hacia -Z.
    El brazo de palanca es la distancia horizontal en X.
    """
    x0, z0 = pivote
    xm, zm = punto_masa
    return masa * g * (xm - x0)

def imprimir_punto(nombre, p):
    print(f"{nombre}: x={p[0]:.3f} m, z={p[1]:.3f} m")

# -------------------------
# Cálculo de articulaciones
# -------------------------
J1 = (0.0, 0.0)
J2 = punto_desde(J1, L1, theta1)
J3 = punto_desde(J2, L2, theta2)
J4 = punto_desde(J3, L3, theta3)
J5 = punto_desde(J4, L4, theta4)
EF = punto_desde(J5, L5, theta5)

# -------------------------
# Centros de masa de eslabones
# -------------------------
CM_L1 = punto_desde(J1, L1 * 0.5, theta1)
CM_L2 = punto_desde(J2, L2 * 0.5, theta2)
CM_L3 = punto_desde(J3, L3 * 0.5, theta3)
CM_L4 = punto_desde(J4, L4 * 0.5, theta4)
CM_L5 = punto_desde(J5, L5 * 0.5, theta5)

# -------------------------
# Posiciones de motores
# Por ahora: algunos en el eje; M3 con offset negativo como contrapeso
# -------------------------
M1 = J1
M2 = J2
M3 = punto_desde(J3, -0.04, theta3)  # motor desplazado hacia atrás
M4 = J4
M5 = J5

# -------------------------
# Lista de masas para cálculo
# -------------------------
elementos = [
    ("L1", m_L1, CM_L1),
    ("L2", m_L2, CM_L2),
    ("L3", m_L3, CM_L3),
    ("L4", m_L4, CM_L4),
    ("L5", m_L5, CM_L5),
    ("Motor M1", m_M1, M1),
    ("Motor M2", m_M2, M2),
    ("Motor M3", m_M3, M3),
    ("Motor M4", m_M4, M4),
    ("Motor M5", m_M5, M5),
    ("Efector final", m_EF, EF),
]

# -------------------------
# Reporte de puntos
# -------------------------
print("=== Puntos principales ===")
for nombre, punto in [
    ("J1", J1), ("J2", J2), ("J3", J3),
    ("J4", J4), ("J5", J5), ("EF", EF),
]:
    imprimir_punto(nombre, punto)

# -------------------------
# Torques respecto a J2 y J3
# -------------------------
def torque_total(pivote, elementos, ignorar_antes_de=None):
    """
    Suma torques respecto a pivote.
    Por ahora suma todos los elementos pasados.
    """
    total = 0.0
    aportes = []

    for nombre, masa, punto in elementos:
        tau = torque_respecto_a(pivote, masa, punto)
        total += tau
        aportes.append((nombre, tau))

    return total, aportes

tau_J2, aportes_J2 = torque_total(J2, elementos)
tau_J3, aportes_J3 = torque_total(J3, elementos)

print("\n=== Torque respecto a J2 ===")
for nombre, tau in aportes_J2:
    print(f"{nombre:15s}: {tau: .3f} N·m")
print(f"TOTAL J2: {tau_J2:.3f} N·m")
print(f"TOTAL J2 abs: {abs(tau_J2):.3f} N·m")

print("\n=== Torque respecto a J3 ===")
for nombre, tau in aportes_J3:
    print(f"{nombre:15s}: {tau: .3f} N·m")
print(f"TOTAL J3: {tau_J3:.3f} N·m")
print(f"TOTAL J3 abs: {abs(tau_J3):.3f} N·m")

import matplotlib.pyplot as plt

def graficar_brazo():
    # Articulaciones
    puntos = [J1, J2, J3, J4, J5, EF]
    nombres = ["J1", "J2", "J3", "J4", "J5", "EF"]

    xs = [p[0] for p in puntos]
    zs = [p[1] for p in puntos]

    plt.figure(figsize=(9, 6))

    # Brazo
    plt.plot(xs, zs, marker="o", linewidth=2)

    for nombre, p in zip(nombres, puntos):
        plt.text(p[0], p[1] + 0.015, nombre, ha="center")

    # Centros de masa de eslabones
    cms = [
        ("CM_L1", CM_L1),
        ("CM_L2", CM_L2),
        ("CM_L3", CM_L3),
        ("CM_L4", CM_L4),
        ("CM_L5", CM_L5),
    ]

    for nombre, p in cms:
        plt.scatter(p[0], p[1], marker="x")
        plt.text(p[0], p[1] - 0.02, nombre, ha="center", fontsize=8)

    # Motores
    motores = [
        ("M1", M1),
        ("M2", M2),
        ("M3", M3),
        ("M4", M4),
        ("M5", M5),
    ]

    for nombre, p in motores:
        plt.scatter(p[0], p[1], marker="s")
        plt.text(p[0], p[1] + 0.025, nombre, ha="center", fontsize=8)

    # Flecha de gravedad
    plt.arrow(
        xs[0] - 0.08, max(zs) + 0.05,
        0, -0.08,
        head_width=0.01,
        length_includes_head=True
    )
    plt.text(xs[0] - 0.075, max(zs) - 0.03, "g")

    plt.axhline(0, linewidth=0.8)
    plt.axvline(0, linewidth=0.8)

    plt.xlabel("X [m]")
    plt.ylabel("Z [m]")
    plt.title("Modelo simplificado del brazo robótico")
    plt.axis("equal")
    plt.grid(True)
    plt.show()

graficar_brazo()