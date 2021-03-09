# sonarqube 8.2-community

Este proyecto representa una estructura de recursos utilizados para el uso de  **SonarQube** con **Docker**

* **docker-compose.yaml + sonar.properties :** representa una instalación independiente, básica, y customizada (a nivel de propiedades) de **SonarQube** con **Docker**

Incluye el uso de Base de datos **Postgres** (para conseguir persistencia)





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [SonarQube](https://www.sonarqube.org/) - Analizador de código estático

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
version: "3"

services:

  sonarqube:
    build: ./8.2-community
    ports:
      - "9000:9000"
    environment:
      - SONARQUBE_JDBC_URL=jdbc:postgresql://sonarqubedb:5432/sonar
      - SONARQUBE_JDBC_USERNAME=sonar
      - SONARQUBE_JDBC_PASSWORD=sonar
    networks:
      - sonarqube-net
    volumes:
      - sonarqube_conf:/opt/sonarqube/conf
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_bundled-plugins:/opt/sonarqube/lib/bundled-plugins

  sonarqubedb:
    image: postgres
    container_name: sonarqubedb
    networks:
      - sonarqube-net
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonar
    volumes:
      - sonarqube_postgresql:/var/lib/postgresql
      - sonarqube_postgresql_data:/var/lib/postgresql/data

networks:
  sonarqube-net:

volumes:
  sonarqube_conf:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  sonarqube_bundled-plugins:
  sonarqube_postgresql:
  sonarqube_postgresql_data:
```

En este fichero se establece el constructor de la imagen que se utilizará, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación

Configuración del fichero "Dockerfile"

```bash
FROM sonarqube:8.2-community

COPY sonar.properties /opt/sonarqube/conf/
```

En este fichero se establece la versión a utilizar de sonarqube, contiene una serie de instrucciones que pueden facilitar la preparación de la imagen y el despliegue inicial, incorpora el cambio de las propieaddes de la aplicación

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/sonarqube/8.2-community)

2. Ejecutar el siguiente comando

```bash
docker-compose up --build

ó

docker-compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "82-community_sonarqube"





### Docker Standalone

N/A





## Uso


### Uso con navegador

Cargar la URL :

```bash
http://localhost:9000/
```

Y login con : admin/admin





## Pruebas

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
