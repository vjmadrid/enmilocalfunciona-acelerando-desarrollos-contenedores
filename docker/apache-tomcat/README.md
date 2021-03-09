# apache-tomcat

Este proyecto representa una estructura de recursos utilizados para el uso de  **Tomcat** con **Docker**

* **docker-compose.yaml + Directorio /tomcat-8.5:** representa una instalación independiente, básica, y customizada (a nivel de usuario y uso de UI) de  **Tomcat** con **Docker**





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Tomcat 8.5](http://tomcat.apache.org) - Contenedor de Servlets

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

   custom-tomcat-8.5:
      build: ./tomcat-8.5
      container_name: custom-tomcat-8.5
      volumes:
         - ./example/myapp.war:/usr/local/tomcat/webapps/myapp.war
      ports:
         - "8080:8080"
```

En este fichero se establece el constructor de la imagen que se utilizará, se definirán una serie de volúmenes (en ese caso uno relacionado con el mapeo de un fichero WAR que ubicará en el propio directorio de despliegue de tomcat) y se publicará por el puerto específico de la aplicación

Configuración del fichero "Dockerfile"

```bash
FROM tomcat:8.5.47-jdk8-corretto

# Delete the webapps directory from the beginning
#RUN rm -rf /usr/local/tomcat/webapps/*

# Add a sample WAR file
#ADD sample.war /usr/local/tomcat/webapps/

# Add a new role and user structure
ADD tomcat-users.xml /usr/local/tomcat/conf/

# Activate the use of the web console (UI)
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/

EXPOSE 8080

CMD ["catalina.sh","run"]
```

En este fichero se establece la versión a utilizar de Tomcat, contiene una serie de instrucciones que pueden facilitar la preparación de la imagen y el despliegue inicial, incorpora una capa de usuarios y roles establecida previamente, además de un fichero donde se habilita el uso de la interfaz UI

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/apache-tomcat)

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


### Uso con navegador

El servicio aceptará una peticion GET HTTP como :

```bash
http://localhost:8080/
```

Y login con : admin/admin





## Pruebas

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
