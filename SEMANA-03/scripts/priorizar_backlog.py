import csv
from pathlib import Path

# Ubicación del Product Backlog
BASE_DIR = Path(__file__).resolve().parent.parent
BACKLOG = BASE_DIR / "docs" / "sprints" / "PRODUCT_BACKLOG.csv"

# Leer backlog
with open(BACKLOG, "r", encoding="utf-8-sig", newline="") as f:
    reader = csv.DictReader(f)
    filas = list(reader)

# Calcular índice de prioridad
for fila in filas:
    valor = float(fila["Valor (1-5)"])
    riesgo = float(fila["Riesgo (1-5)"])

    indice = round(valor * 0.6 + riesgo * 0.4, 2)
    fila["Prioridad"] = f"{indice:.2f}"

# Ordenar de mayor a menor prioridad
filas.sort(
    key=lambda x: float(x["Prioridad"]),
    reverse=True
)

# Guardar backlog priorizado
with open(BACKLOG, "w", encoding="utf-8-sig", newline="") as f:
    campos = [
        "id",
        "Épica",
        "Tipo",
        "Historia de usuario",
        "Criterios de aceptación",
        "Valor (1-5)",
        "Riesgo (1-5)",
        "Puntos",
        "Prioridad",
        "¿Trata datos personales?",
        "¿Requisitos de seguridad?",
        "Sprint previsto"
    ]

    writer = csv.DictWriter(f, fieldnames=campos)
    writer.writeheader()
    writer.writerows(filas)

# Mostrar resultado
print("=== PRODUCT BACKLOG PRIORIZADO ===")
print(f"Historias procesadas: {len(filas)}")
print()

for fila in filas:
    print(
        f"{fila['id']} | "
        f"Valor: {fila['Valor (1-5)']} | "
        f"Riesgo: {fila['Riesgo (1-5)']} | "
        f"Prioridad: {fila['Prioridad']} | "
        f"Puntos: {fila['Puntos']}"
    )

# Verificar historias de 13 puntos o más
grandes = [
    fila for fila in filas
    if float(fila["Puntos"]) >= 13
]

print()
print("=== CONTROL DE HISTORIAS >= 13 PUNTOS ===")

if grandes:
    print("ATENCIÓN: existen historias de 13 puntos o más:")
    for fila in grandes:
        print(f"- {fila['id']}: {fila['Puntos']} puntos")
else:
    print("OK: no existen historias de 13 puntos o más.")