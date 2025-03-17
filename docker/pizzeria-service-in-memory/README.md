# pizzeria services


## Instalación

### Instalación en local

Pasos a seguir:

* Verificar la versión de Python que se va a utilizar

```bash
# Opción 1
python --version

# Opción 2
python3 --version
```

* Verificar la versión de Pip que se va a utilizar

```bash
pip --version
```

* (Opcional) Actualizar las dependencias de pip

```bash
pip install --upgrade pip setuptools wheel
```

* Localizar la ubicación del proyecto

* Crear un entorno virtual (Por ejemplo con nombre venv)

```bash
# Ejemplo de creación del entorno virtual "venv" (se define en el segundo parámetro)
python3 -m venv venv
```

Verificar que se ha creado el directorio "venv"

* Activar el entorno virtual

Este script se encuentra dentro del entorno virtual creado en el paso anterior

En cada sistema operativo se encuentra en alguan ubicación

```bash
# On Unix or MacOS (bash shell):
/path/to/venv/bin/activate

# On Unix or MacOS (csh shell):
/path/to/venv/bin/activate.csh

# On Unix or MacOS (fish shell):
/path/to/venv/bin/activate.fish

# On Windows (command prompt):
pathtovenvScriptsactivate.bat

# On Windows (PowerShell):
pathtovenvScriptsActivate.ps1
```

Ejeciutar el script

```bash
# Para Mac y Linux
source venv/bin/activate

# Para Windows
.\env\Scripts\activate
```

Verificar que el entorno virtual se encuentra activo

* Instalar las dependencias en el entorno virtual desde el fichero "dev-requirements.txt"

```bash
pip install -r dev-requirements.txt
````

Verificar las dependencias instaladas

```bash
pip list
```

Verificar la integraidad del entorno

```bash
pip check
```

Se pueden forzar a una actualización de las dependencias de un entorno en base a su fichero

```bash
pip install --upgrade -r dev-requirements.txt
```

* Exportar las dependencias realmente utilizadas

```bash
pip freeze > requirements.txt
```

### Instalación en Docker

Pasos a seguir:

* Verificar la versión de Python que se va a utilizar

```bash
docker --version
```

* Crear la imagen

```bash
docker build -t pizzeria-service-in-memory .
```

* Arrancar el contenedor a partir de la imagen

```bash
docker run -p 8000:80 pizzeria-service-in-memory
```



## Uso

Pasos a seguir:

* Para ejecutar el programa

```bash
uvicorn main:app --reload
```

* Acceder a la URL del servicio

```bash
http://localhost:8000
```

* Acceder a la documentación Swagger del proyecto

```bash
http://localhost:8000/docs
```

* Acceder a la documentación Redoc del proyecto

```bash
http://localhost:8000/redoc
```