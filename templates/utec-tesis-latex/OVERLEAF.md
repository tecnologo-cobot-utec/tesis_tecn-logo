# Template LaTeX - Proyecto Final Tecnólogo en Mecatrónica (UTEC Uruguay)

## Compilar localmente

**1. Instalar LaTeX** (una sola vez, en Ubuntu/Debian):
```bash
sudo apt update
sudo apt install texlive-latex-base texlive-latex-extra texlive-lang-spanish texlive-bibtex-extra
```

**2. Compilar:**
```bash
cd templates/utec-tesis-latex
./compilar.sh
# o: make
```

**3. Ver el PDF:**
```bash
xdg-open main.pdf
```

---

Adaptado al template oficial UTEC ITR Suroeste, Sede Fray Bentos. Incluye:
- Portada con campos UTEC Uruguay
- Declaración de autoría
- Resumen y Abstract (máx. 250 palabras)
- Cap. 1 El problema, Cap. 2 Marco teórico, Cap. 3 Desarrollo, Cap. 4 Resultado y análisis
- Conclusiones, Recomendaciones, Bibliografía (APA), Anexo

---

# Usar este template en Overleaf

## Opción 1: Subir como ZIP (gratuito)

1. **Crear el ZIP** desde la carpeta `templates/utec-tesis-latex`:
   ```bash
   cd templates/utec-tesis-latex
   zip -r tesis-overleaf.zip . -x "*.git*" -x "*.aux" -x "*.log" -x "*.pdf"
   ```

2. **Antes de subir**: Asegúrate de tener `images/logo-utec.png` (logo de tu institución). Sin él, la compilación fallará.

3. **En Overleaf**:
   - Ve a [overleaf.com](https://www.overleaf.com)
   - **New Project** → **Upload Project**
   - Arrastra el archivo `tesis-overleaf.zip` o selecciónalo
   - Overleaf creará el proyecto y podrás editar en línea

## Opción 2: Importar desde GitHub (requiere Overleaf premium/Commons)

Si tu institución tiene Overleaf Commons (p. ej. plan institucional):

1. En Overleaf: **New Project** → **Import from GitHub**
2. Selecciona el repositorio de tu tesis
3. Elige la carpeta que contiene los archivos `.tex` (por ejemplo `templates/utec-tesis-latex` o una copia en la raíz)

**Nota**: Overleaf no soporta submodules. Si tu repo tiene la librería Herkulex como submodule, la carpeta `codigo/` no se importará completa. El proyecto LaTeX debe estar en una carpeta con solo los archivos necesarios para la tesis.

## Límites de Overleaf (plan gratuito)

- ZIP máximo ~50 MB por archivo
- Hasta 180 archivos por subida
- Solo texto e imágenes (`.tex`, `.png`, `.pdf`, `.eps`, `.svg`)

## Sincronización manual

Si trabajas local y en Overleaf:
- Descarga el proyecto desde Overleaf (Menu → Download)
- Reemplaza los archivos en tu repo
- Haz commit y push
