# Tesis de Tecnólogo — Brazo robótico con HerkuleX DRS-0602

Repositorio de respaldo y continuidad del Proyecto Final de Tecnólogo en Mecatrónica (UTEC). Incluye el código del cobot, la librería HerkuleX, análisis y espacio para diseños 3D.

El documento escrito del proyecto se elabora en **Google Docs / Word (docx)**; no se mantiene en este repositorio una versión LaTeX.

## Estructura del proyecto

```
tesis_tecn-logo/
├── codigo/
│   └── herkulex-drs0602-lib/   ← Submodule: librería HerkuleX DRS-0602
├── Análisis/                   ← scripts y figuras de análisis del brazo
├── diseno_3d/                  ← CAD fuente y exportaciones (estructura)
├── docs/                       ← normativa, plantillas Word y notas
└── normativa/                  ← guías de la universidad (si se centralizan aquí)
```

## Archivos del proyecto

| Contenido | Ubicación |
|-----------|-----------|
| Código fuente (librería HerkuleX, firmware del brazo, bridge ESP y servidor web) | `codigo/herkulex-drs0602-lib/` |
| Análisis en Python (modelo del brazo y figuras) | `Análisis/` |
| Diseños 3D (CAD editables y exportaciones) | `diseno_3d/` |
| Documentación de referencia (normativa UTEC, plantillas docx y notas) | `docs/`, `normativa/` |

## Cómo empezar

### 1. Clonar con submodules

Si clonaste el repo sin submodules, inicialízalos:

```bash
git submodule update --init
```

### 2. Normativa y plantillas Word

- **docs/**: Manuales, circular de trabajos finales, normas APA y plantilla Word oficial UTEC.
- El informe del proyecto se redacta fuera del repo (Google Docs / docx).

### 3. Actualizar la librería HerkuleX

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
- **Repositorio en GitHub**: https://github.com/tecnologo-cobot-utec/tesis_tecn-logo
