# vsftpd

Este proyecto representa una estructura de recursos utilizados para el uso de **VSFTPD** con **Docker**

* **Directorio /vsftpd-alpine-3.9.4 + docker-compose.yaml :** representa una instalación independiente, básica, y customizada de  **VSFTPD** con **Docker** sobre una plataforma **Alpine 3.9.x**





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Alpine 3.9.x](https://www.alpinelinux.org/) - Distribución de Linux Reducida
* [Filezilla](https://filezilla-project.org/) - Cliente FTP Multiplataforma

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

* Modificar la propiedad FTP_MODE del fichero docker-compose con el valor : 'ftps'
* Arrancar el contenedor

**Configurar** 

Pasos a seguir :

* Abrir Filezilla
* Acceder a la opción de "Site Manager"
* Añadir un "New Site" debajo del dominio seleccionado
* Introducir el campo "Host" : localhost
* Acceder a la opción "Encryption list" y seleccionar la opción "Require explicit FTP over TLS"
* Acceder a la opción "Logon Type list" y seleccionar la opción "Normal"
* Introducir el campo "User" : user
* Introducir el campo "Password" : user
* Acceder a la pestaña "Transfer Settings" y seleccionar la opción "Passive"
* Click sobre conexión



### Uso para Filezilla con SFTP 

**Configurar Contenedor**

Pasos a seguir :

* Modificar la propiedad FTP_MODE del fichero docker-compose con el valor : 'ftps-tls'
* Arrancar el contenedor

**Configurar** 

Pasos a seguir :

* Abrir Filezilla
* Acceder a la opción de "Site Manager"
* Añadir un "New Site" debajo del dominio seleccionado
* Introducir el campo "Host" : localhost
* Cambiar protocolo por "SFTP - SSH File Transfer Protocol"
* Acceder a la opción "Logon Type list" y seleccionar la opción "Normal"
* Introducir el campo "User" : user
* Introducir el campo "Password" : user
* Click sobre conexión



## Pruebas

N/A





## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
