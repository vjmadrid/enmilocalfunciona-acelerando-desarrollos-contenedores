# pypi-server

Este proyecto representa una estructura de recursos utilizados para el uso de **pypi** con **Docker**

Pip es una herramienta para instalar , actualizar y eliminar dependencias a nivel de paquetes de Python

PyPI (Python Package Index) es un repositorio público de paquetes para Python utilizado para instalarse mediante el comando pip

PyPI Server es un servidor que permite establecer un repositorio privado de paquetes para Python utilizado para instalarse mediante el comando pip

* **Directorio /pypi-server-alpine-3.9.4 + docker-compose.yaml :** representa una instalación independiente, básica, y customizada de  **pypi** con **Docker** sobre una plataforma **Alpine 3.9.x**


http://localhost:8080/

# Generate Target
python setup.py sdist

# Move a pacakage
mv ./hello-project/dist/hello-project-1.0.tar.gz ~/pypi-server-alpine-3.9.4/pypiserver-server-alpine-3.9.4-vol/packages

cp hello-project/dist/hello-project-1.0.tar.gz pypi-server-alpine-3.9.4/pypiserver-server-alpine-3.9.4-vol/packages

pip install --index-url http://localhost:8080/simple/

pip install --index-url http://localhost:8080/simple/ hello-project-1.0.tar.gz

pip install --extra-index-url http://192.0.2.0:8080/simple/ --trusted-host 192.0.2.0 linode_example.

Wheel


# install wheel (to build packages in the bdist_wheel format)
pip install wheel

# create the package
python setup.py bdist_wheel

Generate *.whl

# install the local package
pip install dist/*

# call the script
make-person


## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Alpine 3.9.x](https://www.alpinelinux.org/) - Distribución de Linux Reducida
* [PyPI Server](https://pypi.org/project/pypiserver/) - Repositorio privado de paquetes para Python

Dependencias con Proyectos de Arquitectura

N/A

Dependencias con Terceros

N/A





## Prerrequisitos

Define que elementos son necesarios para instalar el software

* Docker instalado (19+)
* Filezilla instalado





## Instalación

### Docker Compose

Configuración del fichero "docker-compose.yaml"

```bash
xxx
```

En este fichero se establece el constructor de la imagen que se utilizará, se definirán una serie de volúmenes (en ese caso uno relacionado con el mapeo de un fichero WAR que ubicará en el propio directorio de despliegue de tomcat) y se publicará por el puerto específico de la aplicación

Configuración del fichero "Dockerfile"

```bash
xxx
```

En este fichero se establece la versión a utilizar de Tomcat, contiene una serie de instrucciones que pueden facilitar la preparación de la imagen y el despliegue inicial, incorpora una capa de usuarios y roles establecida previamente, además de un fichero donde se habilita el uso de la interfaz UI

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/vsftpd/<distribution>)

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "mysql_test"

4. Comprobar que la aplicación ha sido desplegada correctamente




### Docker Standalone

Se puede ejecutar de forma individual con los comandos de docker sobre el fichero "Dockerfile"





## Uso


### Uso para Filezilla con FTPS (Explicit SSL)

**Configurar Contenedor**

Pasos a seguir :



## Pruebas

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
