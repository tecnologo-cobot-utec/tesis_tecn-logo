# Tesis de Tecnólogo — Brazo robótico con HerkuleX DRS-0602

Repositorio para el desarrollo de la tesis de tecnólogo. Incluye el código de la librería de motores HerkuleX, el brazo robótico construido y los documentos de la tesis.

## Estructura del proyecto

```
tesis_tecn-logo/
├── codigo/
│   └── herkulex-drs0602-lib/   ← Submodule: librería HerkuleX DRS-0602
├── Análisis/                   ← scripts y figuras de análisis del brazo
├── diseno_3d/                  ← CAD fuente y exportaciones (estructura)
├── docs/                       ← capítulos, borradores, notas
├── templates/                  ← plantillas LaTeX
│   └── utec-tesis-latex/       ← template para tesis UTEC
├── normativa/                  ← guías de la universidad
└── tesis/                      ← espacio para tu documento en desarrollo
```

## Archivos del proyecto

| Contenido | Ubicación |
|-----------|-----------|
| Código fuente (librería HerkuleX, firmware del brazo, bridge ESP y servidor web) | `codigo/herkulex-drs0602-lib/` |
| Análisis en Python (modelo del brazo y figuras) | `Análisis/` |
| Diseños 3D (CAD editables y exportaciones) | `diseno_3d/` |
| Documentación del proyecto (tesis LaTeX, normativa, plantillas y notas) | `docs/`, `templates/utec-tesis-latex/`, `normativa/` |

## Cómo empezar

### 1. Clonar con submodules

Si clonaste el repo sin submodules, inicialízalos:

```bash
git submodule update --init
```

### 2. Crear el documento de LaTeX para Overleaf

El template está en `templates/utec-tesis-latex/`. Para usarlo en Overleaf:

1. **Reemplaza el logo** en `templates/utec-tesis-latex/images/logo-utec.png` por el logo oficial de tu institución.

2. **Crea un ZIP** para subir a Overleaf:
   ```bash
   cd templates/utec-tesis-latex
   zip -r tesis-overleaf.zip . -x "*.git*" -x "*.aux" -x "*.log" -x "*.pdf"
   ```

3. **Sube a Overleaf**: [overleaf.com](https://www.overleaf.com) → New Project → Upload Project → selecciona el ZIP.

Ver instrucciones detalladas en [templates/utec-tesis-latex/OVERLEAF.md](templates/utec-tesis-latex/OVERLEAF.md).

### 3. Normativa y plantillas

- **normativa/**: Coloca aquí los PDFs o guías de formato que te proporcione la universidad.
- **templates/**: Template LaTeX adaptado al formato oficial UTEC Uruguay (ITR Suroeste, Fray Bentos). Ver `templates/utec-tesis-latex/OVERLEAF.md` para usarlo en Overleaf.

### 4. Actualizar la librería HerkuleX

```bash
cd codigo/herkulex-drs0602-lib
git pull
cd ../..
git add codigo/herkulex-drs0602-lib
git commit -m "Actualizar librería herkulex-drs0602-lib"
```

## Referencias

- **Librería HerkuleX**: [codigo/herkulex-drs0602-lib](codigo/herkulex-drs0602-lib) — API y ejemplos en `docs/` y `examples/`
- **Brazo robótico**: ejemplo en `codigo/herkulex-drs0602-lib/examples/proyecto_cobot/`
- **Guía de vinculación**: [codigo/herkulex-drs0602-lib/docs/GUIA_REPO_TESIS.md](codigo/herkulex-drs0602-lib/docs/GUIA_REPO_TESIS.md)
