# vsftpd

Este proyecto representa una estructura de recursos utilizados para el uso de **VSFTPD** con **Docker**

Vsftpd es un servidor que facilita implementar un servidor de FTP

Este servidor se intala sobre ciertas distribuciones de Linux

* **Directorio /vsftpd-1.0:** representa una instalación independiente, básica, y customizada (a nivel de datos) de **VSFTPD** con **Docker**


Install FTP on Mac OS

brew install inetutils

ftp://127.0.0.1 

ftp user@ftp.gnu.org

ftp -p localhost 21

ftp -p vsftpd 21

## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [VSFTPD](https://www.mysql.com/) - Servidor de FTP

Dependencias con Proyectos de Arquitectura

N/A

Dependencias con Terceros

N/A





## Prerrequisitos

Define que elementos son necesarios para instalar el software

* Docker instalado (19+)





## Instalación

### Docker Compose

Configuración del fichero "docker-compose.yaml"

```bash

```

En este fichero se establece el constructor de la imagen que se utilizará, se establecerán una serie de variables de entorno necesarias para su ejecución, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación

Configuración del fichero "Dockerfile"

```bash
FROM mysql:5.7

COPY ./sql-scripts/*.sql /docker-entrypoint-initdb.d/
```

En este fichero se establece la versión a utilizar y se le indicará los ficheros de carga de datos para disponer de datos iniciales

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/mysql)

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "custom-mysql-5.7"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante un cliente de base datos que la conexión se puede realizar





## Pruebas

N/A





## Despliegue

N/A





## Uso

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
