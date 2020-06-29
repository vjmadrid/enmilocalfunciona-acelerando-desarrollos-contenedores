# postgresql

Contenedor Docker para el uso de la base de datos **Postgresql**





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

   test:
      build: ./postgres-11
      environment:
         POSTGRES_USER: test
         POSTGRES_PASSWORD: test
         POSTGRES_DB: acme
      ports:
         - 5432:5432
```

En este fichero se establece el constructor de la imágen que se utilizará, se establecerán una serie de variables de entorno necesarias para su ejecución, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación

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

3. Comprobar que la imágen ha sido creada

Verificar que parece como imágen Docker el nombre "postgresql_test"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante un cliente de base datos que la conexión se puede realizar

![Comprobación Conexión de Cliente de Base de datos](https://github.com/vjmadrid/enmilocalfunciona-schemaspy/blob/master/images/postgresql-client-test.png)





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
