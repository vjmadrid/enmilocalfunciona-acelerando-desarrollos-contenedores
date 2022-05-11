
# keycloak-with-import-persistence

Este proyecto representa una estructura de recursos utilizados para el uso de **Keycloak** con **Docker**, con la importación
de una configuración previa y con persistencia
en base de datos **Postgresql**

>**Importante**
>
>SE INICIA CON LA CONFIGURACION ESTABLECIDA EN EL FICHERO, UNICAMENTE TENDRÁ EL USUARIO ADMIN
> 
>Posteriomente se persitirá todo lo que se haga



## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Keycloak](https://www.keycloak.org/) - Herramienta IAM / IdP
* [Postgresql](https://www.postgresql.org/) - Base de datos relacional

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
version: '3'
services:

  db:
    #image: postgres
    image: postgres:14.2
    environment: 
      POSTGRES_DB: keycloakdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - '5432:5432'
    volumes:
      - ./db:/var/lib/postgresql/data
      - ./config/postgres:/docker-entrypoint-initdb.d

  keycloak:
    #image: jboss/keycloak
    image: jboss/keycloak:16.1.0
    environment:
      DB_VENDOR: POSTGRES
      DB_ADDR: db
      DB_DATABASE: keycloakdb
      DB_USER: postgres
      DB_PASSWORD: postgres
      KEYCLOAK_USER: admin
      KEYCLOAK_PASSWORD: password
      #KEYCLOAK_LOGLEVEL: DEBUG
      #ROOT_LOGLEVEL: DEBUG
      KEYCLOAK_IMPORT: /tmp/realm-export.json
    ports:
      - '8083:8080'
    volumes:
      - ./config/keycloak/realm-export.json:/tmp/realm-export.json
    command: ["-Dkeycloak.profile.feature.upload_scripts=enabled"]
    depends_on:
      - db

volumes:
  db:
    driver: local
```

En este fichero se establece el constructor de la imagen que se utilizará para Keycloak (versión específica o la última disponible), se establecerán una serie de variables de entorno necesarias para su ejecución.

Se proporciona el fichero que ha sido exportado previamente y que contiene una configuración determinada, dicho fichero será importado por Keycloak en en arranque. Para ello establece un volumen de intercambio entre un fichero en una ruta local y el mismo fichero dentro del contenedor.

Se ha activado un comando de Keycloak para permitir la actualización mediante script

Además se establece el constructor de la imagen que se utilizará para Postgres, se establecerán una serie de variables de entorno necesarias para su ejecución, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación


Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH>

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "keycloak"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante el acceso a la aplicación mediante la URL : http://localhost:8083





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
