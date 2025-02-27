# mysql 5.7

Este proyecto representa una estructura de recursos utilizados para el uso de **MySQL** con **Docker**

* **docker-compose.yaml + Directorio /mysql-5.7:** representa una instalación independiente, básica, y customizada (a nivel de datos) de  **MySQL** con **Docker**





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [MySQL](https://www.mysql.com/) - Base de Datos relacional (Version 5.7)

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
# Use Case: Basic Installation
services:
   # Project URL: https://github.com/mysql
   # Docs URL: https://dev.mysql.com/doc/
   custom-mysql-5.7:
      build: ./mysql-5.7
      container_name: custom-mysql-5.7
      environment:
         MYSQL_ROOT_PASSWORD: root
         MYSQL_DATABASE: acme
         MYSQL_USER: test
         MYSQL_PASSWORD: test
      volumes:
         # *** MySQL configuration ***
         - ./custom-mysql-5.7/config/my.cnf:/etc/mysql/conf.d/my.cnf
         - ./mysql-5.7/sql-scripts:/docker-entrypoint-initdb.d
      ports:
         - 3306:3306
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
