# modelo_analisis_v2.py

import math
import matplotlib.pyplot as plt

# ============================================================
# 1. CONSTANTES
# ============================================================

g = 9.81  # m/s^2


# ============================================================
# 2. GEOMETRÍA DEL BRAZO [m]
# ============================================================

# Altura desde el suelo/base hasta el eje J1
h_base = 0.1000

# Tramo fijo J1 -> J2
L1 = 0.0757      # proyección en el plano X-Z
L1_3d = 0.0781   # dato auxiliar, no usado por ahora
theta_L1_fijo = 61.9  # grados respecto al eje X

# Tramos principales
L2 = 0.1655      # J2 -> J3
L3 = 0.1810      # J3 -> J4
L4 = 0.0487      # J4 -> J5
L5 = 0.0550      # J5 -> punto de montaje del efector

# Efector final
L_EF = 0.1070    # largo propio del efector final

# Extensión trasera asociada a L3 / motor M3
cola_L3 = 0.0647

# Ángulo fijo local de L4 respecto a la referencia de M4
offset_theta_L4 = 62.3


# ============================================================
# 3. MASAS [kg]
# ============================================================

# Motores
m_motor = 0.145

m_M1 = m_motor
m_M2 = m_motor
m_M3 = m_motor
m_M4 = m_motor
m_M5 = m_motor

# Base
m_base = 0.378
m_arduino = 0.025

# Eslabones / piezas impresas
m_L1 = 0.169
m_L2 = 0.085

# Provisorios: mañana se reemplazan por pesos reales
# Estos tres suman 0.200 kg, que es el dato total de PLA L3+L4+L5
m_L3 = 0.100
m_L4 = 0.050
m_L5 = 0.050

# Provisorio hasta pesar o estimar el efector final
m_EF = 0.100


# ============================================================
# 4. CONFIGURACIONES ANGULARES
# ============================================================
# Convención:
# - Los ángulos son relativos, salvo L1 que se toma como fijo.
# - q2 define la orientación de L2 respecto a X.
# - q3 se suma a q2 para obtener L3.
# - q4 se suma a L3 más el offset fijo de montaje de L4.
# - q5 se suma a L4 para orientar el conjunto final / EF.

configuraciones = {
    "reposo": {
        "q2": 95,
        "q3": -130,
        "q4": 0,
        "q5": 0,
    },
    "intermedia": {
        "q2": 45,
        "q3": -45,
        "q4": 0,
        "q5": 0,
    },
    "extendida": {
        "q2": 0,
        "q3": 0,
        "q4": 0,
        "q5": 0,
    },
}


# ============================================================
# 5. FUNCIONES GEOMÉTRICAS
# ============================================================

def punto_desde(p, L, ang_deg):
    """
    Devuelve un punto a distancia L y ángulo ang_deg desde p.
    El ángulo se mide desde el eje X positivo.
    """
    x, z = p
    a = math.radians(ang_deg)
    return (
        x + L * math.cos(a),
        z + L * math.sin(a)
    )


def torque_respecto_a(pivote, masa, punto_masa):
    """
    Torque estático respecto a un pivote en el plano X-Z.

    Como la gravedad actúa hacia -Z, el brazo de palanca
    para el momento alrededor del eje Y es la distancia horizontal X.

    tau = m * g * (x_masa - x_pivote)

    El signo indica sentido de giro.
    """
    x0, _ = pivote
    xm, _ = punto_masa
    return masa * g * (xm - x0)


def imprimir_punto(nombre, p):
    print(f"{nombre}: x={p[0]: .3f} m, z={p[1]: .3f} m")


# ============================================================
# 6. MODELO DEL BRAZO PARA UNA CONFIGURACIÓN
# ============================================================

def calcular_modelo(config):
    """
    Calcula articulaciones, centros de masa, motores y torques
    para una configuración angular dada.
    """

    q2 = config["q2"]
    q3 = config["q3"]
    q4 = config["q4"]
    q5 = config["q5"]

    # -------------------------
    # Ángulos absolutos
    # -------------------------
    theta1 = theta_L1_fijo
    theta2 = q2
    theta3 = theta2 + q3
    theta4 = theta3 + q4 + offset_theta_L4
    theta5 = theta4 + q5

    # -------------------------
    # Articulaciones
    # -------------------------
    J0 = (0.0, 0.0)          # suelo / referencia
    J1 = (0.0, h_base)       # eje base
    J2 = punto_desde(J1, L1, theta1)
    J3 = punto_desde(J2, L2, theta2)
    J4 = punto_desde(J3, L3, theta3)
    J5 = punto_desde(J4, L4, theta4)

    # Punto de montaje del EF
    P_EF = punto_desde(J5, L5, theta5)

    # Centro de masa estimado del efector:
    # se toma a mitad de su largo propio desde el montaje.
    CM_EF = punto_desde(P_EF, L_EF * 0.5, theta5)

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
    # -------------------------
    # M1 en la base
    M1 = J1

    # M2 asociado a J2
    M2 = J2

    # M3 desplazado hacia atrás respecto a J3.
    # Esto representa el "contrapeso" por la cola de L3.
    M3 = punto_desde(J3, -cola_L3, theta3)

    # M4 y M5 ubicados en sus ejes
    M4 = J4
    M5 = J5

    # -------------------------
    # Lista de masas
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
        ("Efector final", m_EF, CM_EF),
    ]

    modelo = {
        "angulos": {
            "theta1": theta1,
            "theta2": theta2,
            "theta3": theta3,
            "theta4": theta4,
            "theta5": theta5,
        },
        "puntos": {
            "J0": J0,
            "J1": J1,
            "J2": J2,
            "J3": J3,
            "J4": J4,
            "J5": J5,
            "P_EF": P_EF,
            "CM_EF": CM_EF,
        },
        "cms": {
            "CM_L1": CM_L1,
            "CM_L2": CM_L2,
            "CM_L3": CM_L3,
            "CM_L4": CM_L4,
            "CM_L5": CM_L5,
            "CM_EF": CM_EF,
        },
        "motores": {
            "M1": M1,
            "M2": M2,
            "M3": M3,
            "M4": M4,
            "M5": M5,
        },
        "elementos": elementos,
    }

    return modelo


# ============================================================
# 7. TORQUES
# ============================================================

def torque_total(pivote, elementos):
    total = 0.0
    aportes = []

    for nombre, masa, punto in elementos:
        tau = torque_respecto_a(pivote, masa, punto)
        total += tau
        aportes.append((nombre, masa, punto, tau))

    return total, aportes


def filtrar_elementos_para_articulacion(elementos, articulacion):
    """
    Devuelve solo los elementos que realmente cargan a cada articulación.
    """

    if articulacion == "J2":
        nombres_validos = {
            "L2",
            "L3",
            "L4",
            "L5",
            "Motor M3",
            "Motor M4",
            "Motor M5",
            "Efector final",
        }

    elif articulacion == "J3":
        nombres_validos = {
            "L3",
            "L4",
            "L5",
            "Motor M3",  # se incluye porque está montado en el conjunto distal / cola de L3
            "Motor M4",
            "Motor M5",
            "Efector final",
        }

    elif articulacion == "J4":
        nombres_validos = {
            "L4",
            "L5",
            "Motor M4",
            "Motor M5",
            "Efector final",
        }

    else:
        nombres_validos = set()

    return [
        (nombre, masa, punto)
        for nombre, masa, punto in elementos
        if nombre in nombres_validos
    ]


def calcular_torques(modelo):
    puntos = modelo["puntos"]
    elementos = modelo["elementos"]

    J2 = puntos["J2"]
    J3 = puntos["J3"]
    J4 = puntos["J4"]

    elementos_J2 = filtrar_elementos_para_articulacion(elementos, "J2")
    elementos_J3 = filtrar_elementos_para_articulacion(elementos, "J3")
    elementos_J4 = filtrar_elementos_para_articulacion(elementos, "J4")

    tau_J2, aportes_J2 = torque_total(J2, elementos_J2)
    tau_J3, aportes_J3 = torque_total(J3, elementos_J3)
    tau_J4, aportes_J4 = torque_total(J4, elementos_J4)

    return {
        "J2": {
            "total": tau_J2,
            "aportes": aportes_J2,
        },
        "J3": {
            "total": tau_J3,
            "aportes": aportes_J3,
        },
        "J4": {
            "total": tau_J4,
            "aportes": aportes_J4,
        },
    }

# ============================================================
# 8. FILTRAR ELEMENTOS SEGÚN ARTICULACIÓN
# ============================================================
# Nota:
# Por ahora se suman todos los elementos en todos los pivotes.
# Para el análisis final podemos filtrar:
# - En J2 no deberían aportar base, M1 ni quizá L1.
# - En J3 no deberían aportar L1, L2 ni M2.
# De momento dejamos el cálculo general para ver signos y comportamiento.
# Luego hacemos una versión "física" filtrada.


# ============================================================
# 9. REPORTES
# ============================================================

def imprimir_reporte(nombre_config, modelo, torques):
    print("\n" + "=" * 70)
    print(f"CONFIGURACIÓN: {nombre_config}")
    print("=" * 70)

    print("\n--- Ángulos absolutos de eslabones ---")
    for nombre, valor in modelo["angulos"].items():
        print(f"{nombre:8s}: {valor: .2f}°")

    print("\n--- Puntos principales ---")
    for nombre in ["J1", "J2", "J3", "J4", "J5", "P_EF", "CM_EF"]:
        imprimir_punto(nombre, modelo["puntos"][nombre])

    print("\n--- Torques totales filtrados ---")
    for articulacion in ["J2", "J3"]:
        tau = torques[articulacion]["total"]
        print(f"{articulacion}: {tau: .3f} N·m | abs = {abs(tau):.3f} N·m")

    print("J4: no se toma como resultado final en este modelo 2D, porque su eje de giro es X.")

    print("\n--- Aportes respecto a J2 ---")
    for nombre, masa, punto, tau in torques["J2"]["aportes"]:
        print(f"{nombre:15s} m={masa: .3f} kg  tau={tau: .3f} N·m")


# ============================================================
# 10. GRÁFICO
# ============================================================

def graficar_modelo(nombre_config, modelo, guardar=False):
    puntos = modelo["puntos"]
    cms = modelo["cms"]
    motores = modelo["motores"]

    cadena = [
        puntos["J1"],
        puntos["J2"],
        puntos["J3"],
        puntos["J4"],
        puntos["J5"],
        puntos["P_EF"],
        puntos["CM_EF"],
    ]

    nombres_cadena = ["J1", "J2", "J3", "J4", "J5", "P_EF", "CM_EF"]

    xs = [p[0] for p in cadena]
    zs = [p[1] for p in cadena]

    plt.figure(figsize=(9, 6))

    # Brazo
    plt.plot(xs, zs, marker="o", linewidth=2, label="Eslabones")

    for nombre, p in zip(nombres_cadena, cadena):
        plt.text(p[0], p[1] + 0.012, nombre, ha="center", fontsize=8)

    # Centros de masa
    for nombre, p in cms.items():
        plt.scatter(p[0], p[1], marker="x")
        plt.text(p[0], p[1] - 0.018, nombre, ha="center", fontsize=8)

    # Motores
    for nombre, p in motores.items():
        plt.scatter(p[0], p[1], marker="s")
        plt.text(p[0], p[1] + 0.020, nombre, ha="center", fontsize=8)

    # Flecha gravedad
    xg = min(xs) - 0.08
    zg = max(zs) + 0.06
    plt.arrow(
        xg, zg,
        0, -0.08,
        head_width=0.01,
        length_includes_head=True
    )
    plt.text(xg + 0.01, zg - 0.05, "g")

    plt.axhline(0, linewidth=0.8)
    plt.axvline(0, linewidth=0.8)

    plt.xlabel("X [m]")
    plt.ylabel("Z [m]")
    plt.title(f"Modelo simplificado del brazo - {nombre_config}")
    plt.axis("equal")
    plt.grid(True)
    plt.legend()

    if guardar:
        nombre_archivo = f"modelo_brazo_{nombre_config}.png"
        plt.savefig(nombre_archivo, dpi=300, bbox_inches="tight")
        print(f"Imagen guardada: {nombre_archivo}")

    plt.show()


# ============================================================
# 11. EJECUCIÓN
# ============================================================

if __name__ == "__main__":

    resumen = []

    for nombre_config, config in configuraciones.items():
        modelo = calcular_modelo(config)
        torques = calcular_torques(modelo)

        imprimir_reporte(nombre_config, modelo, torques)
        graficar_modelo(nombre_config, modelo, guardar=False)

        resumen.append({
            "configuracion": nombre_config,
            "tau_J2": torques["J2"]["total"],
            "tau_J3": torques["J3"]["total"],
        })

    print("\n" + "=" * 70)
    print("RESUMEN DE TORQUES")
    print("=" * 70)

    print(f"{'Configuración':15s} {'J2 [N·m]':>12s} {'J3 [N·m]':>12s}")
    print("-" * 42)

    for fila in resumen:
        print(
            f"{fila['configuracion']:15s} "
            f"{fila['tau_J2']:12.3f} "
            f"{fila['tau_J3']:12.3f}"
    )
        
    