# mysql-liquibase-standalone

Este proyecto representa una estructura de recursos utilizados para el uso de **MySQL** con **Docker** y la incorporación de estructura y contenido mediante la ejecución de **Liquibase** de forma independiente





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Technología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [MySQL](https://www.mysql.com/) - Base de Datos relacional (Version 5.7)
* [Liquibase](https://www.liquibase.org/) - Herramienta de control de cambios en la base de datos

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

   mysql-5.7:
      build: ./mysql-5.7
      container_name: mysql-5.7
      environment:
         MYSQL_ROOT_PASSWORD: root
         MYSQL_DATABASE: acme
         MYSQL_USER: test
         MYSQL_PASSWORD: test
      volumes:
         - ./mysql-5.7/config/my.cnf:/etc/mysql/conf.d/my.cnf
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

En este fichero se establece la versión a utilizar y se le indicará los ficheros de carga de datos para disponer de datos iniciales (en este caso únicamente el esquema)

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/database-liquibase/standalone/mysql-liquibase-standalone)

2. Ejecutar el siguiente comando

```bash
java -jar liquibase.jar \
      --driver=com.mysql.cj.jdbc.Driver \
      --classpath=./mysql-connector-java-6.0.6.jar \
      --changeLogFile=./liquibase-changeLog.xml \
      --url="jdbc:mysql://127.0.0.1:3306/acme?useUnicode=true&characterEncoding=UTF-8" \
      --username=test \
      --password=test \
      update
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "mysql-liquibase-standalone_mysql-5.7"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante un cliente de base datos que la conexión se puede realizar





## Uso

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/database-liquibase/standalone/custom-mysql-liquibase-standalone)

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada





## Pruebas

N/A





## Despliegue

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
