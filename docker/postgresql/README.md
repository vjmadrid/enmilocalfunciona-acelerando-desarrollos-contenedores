# postgresql

Este proyecto representa una estructura de recursos utilizados para el uso de **Postgresql** con **Docker**

* **docker-compose.yaml + Directorio /postgresql-11:** representa una instalación independiente, básica, y customizada (a nivel de datos) de  **Postgresql** con **Docker**




## Stack Tecnológico

* [Docker](https://www.docker.com/) - Technología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [Postgresql](https://www.postgresql.org/) - Base de Datos relacional (Version 11)

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
version: '3.7'

services:

   custom-postgres-11:
      build: ./postgres-11
      container_name: custom-postgres-11
      environment:
         POSTGRES_USER: test
         POSTGRES_PASSWORD: test
         POSTGRES_DB: acme
      #volumes:
      #   - ./custom-postgres-11/data/:/var/lib/postgresql/data/  
      ports:
         - 5432:5432
```

En este fichero se establece el constructor de la imagen que se utilizará, se establecerán una serie de variables de entorno necesarias para su ejecución, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación

Configuración del fichero "Dockerfile"

```bash
FROM postgres:11

COPY ./sql-scripts/*.sql /docker-entrypoint-initdb.d/
```

En este fichero se establece la versión a utilizar y se le indicará los ficheros de carga de datos para disponer de datos iniciales

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (infrastructure-db/docker/postgres)

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "custom-postgres-11"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante un cliente de base datos que la conexión se puede realizar

Comprobación Conexión de Cliente de Base de datos





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
