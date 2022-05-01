# registry

Este proyecto representa una estructura de recursos utilizados para el uso de **Registry** para Docker con **Docker**

* **docker-compose.yaml** representa una instalación independiente y básica del **Registry**


https://hub.docker.com/_/registry
https://github.com/docker/distribution-library-image
https://github.com/distribution/distribution
https://github.com/docker/docker.github.io/blob/master/registry/deploying.md



## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [Registry](https://www.mysql.com/) - Docker Registry

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

### Ejemplo de uso de Push

1. Ejecutar el siguiente comando

```bash
docker pull alpine:3.7
```

2. Comprobar que la imagen ha sido creada en local

3. Taguear la imagen añadiendole la dirección del registry

Nota : Para esta prueba tambien se ha tagueado con un nuevo nombre

```bash
docker tag alpine:3.7 localhost:1000/test-alpine
```

4. Comprobar que la imagen ha sido creada en local

5. Realizar el push de la imagen al registry

```bash
docker push localhost:1000/test-alpine
```

6. Verificar que se ha creado la imagen en el registry accediendo al volumen y comprobando que allí existe



### Ejemplo de uso de "Pull"


1. Comprobar si existe la imagen en local : alpine:3.7

2. Eliminar la imagen local

```bash
docker image remove alpine:3.7
```

3. Comprobar si existe la imagen en local : localhost:1000/test-alpine

4. Eliminar la imagen local

```bash
docker image remove localhost:1000/test-alpine
```

5. Verificar que no existe ninguna imagen de las anteriores en local

6. Realizar el pull de la imagen desde el registruy

```bash
docker pull localhost:1000/test-alpine
```

7. Verificar que se ha creado la imagen en local




## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
