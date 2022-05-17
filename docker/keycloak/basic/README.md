
# keycloak

Este proyecto representa una estructura de recursos utilizados para el uso de **Keycloak** con **Docker**

>**Importante**
>
>En este caso con funcionamiento será modo "standalone" lo que significa que usará persistencia interna, lo que  
>implica que en cada arranque se pierda lo que se ha configurado.
>
>SE INICIA SIN CONFIGURACIONES EXTRA, UNICAMENTE TENDRÁ EL USUARIO ADMIN





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Keycloak](https://www.keycloak.org/) - Herramienta IAM / IdP

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

  keycloak:
    #image: jboss/keycloak
    image: jboss/keycloak:16.1.0
    environment:
      KEYCLOAK_USER: admin
      KEYCLOAK_PASSWORD: password
      KEYCLOAK_LOGLEVEL: DEBUG
      ROOT_LOGLEVEL: DEBUG
    ports:
      - '8083:8080'
```

En este fichero se establece el constructor de la imagen que se utilizará (versión específica o la última disponible), se establecerán una serie de variables de entorno necesarias para su ejecución.

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

Una vez arrancado el contenedor de Keycloak se puede establecer una configuración de un usuario básica



### Acceso

* Acceder a la consola de administración




### Creación de un Realm

Pasos a seguir:

* Acceder a la plataforma con el usuario admin utilizado (si es necesario)
* Añadir un realm nuevo desde el desplegable superior de la izquierda 
  * Por defecto pondrá "Master" (realm proporcionado por defecto)
* Pulsar sobre el botón "Add realm"
* Establecer el nombre del realm : **test**
* Pulsar sobre el botón "Create"
* Verificar que se ha cargado las opciones de configuración del nuevo realm "test" (Opción "Realm Settings" marcada en el menu de la izquierda)
  * Al crear el realm automáticamente se cambia de realm
* En la pestaña "Login"
  * Activar la opción "User registration" para permitir registro de usuarios
* Pulsar sobre el botón "Save"





### Creación de un cliente (Oauth)

Pasos a seguir:

* Acceder a la plataforma con el usuario admin utilizado (si es necesario)
* Seleccionar el realm objetivo -> En nuestro caso el creado anteriormente "test"
* Acceder a la opción "Clients" del menú lateral izquierdo
* Pulsar sobre el botón "Create"
* Establecer el client id : **client-postman**
* Establecer el client protocol : **openid-connect**
* Pulsar sobre el botón "Save"
* Si todo ha ido bien se accedera a la pestaña de "Setting" del cliente que se acaba de crear

**Configuración del cliente**

Pasos a seguir:

* Pulsar sobre la pestaña "Settings" (En caso de que no se haya accedido previamente habrá que acceder primero al cliente)
* Establecer el client name (opcional)
* Establecer la client description (opcional)
* Verificar que el client protocol es "openid-connect" (Para nuestro caso concreto)
* Establecer el access type : **confidential**
  * Significa que requerirá "client id" y "client secret"
  * Aparecerán unas opciones particulares al seleccionarla
  * La app cliente requerirá incluir los valores client_id y client_secret  en la solicitud de token de acceso
* Establecer Valid Redirect URIs : http://localhost:8083/*
  * Debería ser la URL de la aplicación sobre la que redirigir en caso de utilizar un desarrollo
* Habilitar la opcion "Service Account Enabled" -> Se podrán copiar "client credentials" y así usarlas en peticiones HTTP
  * Proporciona el soporte de "Client Credentials Grant" a este cliente
* Pulsar sobre el botón "Save"
* Copiar el campo Client ID (por ejemplo en un fichero de texto, ya que luego lo utilizaremos)
* Pulsar sobre la pestaña "Credentials"
* Verficar que el campo Cliente Authenticator tien la opcion marcada de "Client Id and Secret"
* Copiar el valor "Client Secret" (por ejemplo en el mismo fichero que antes)






### Creación de un Usuario

Pasos a seguir:

* Acceder a la plataforma con el usuario admin utilizado (si es necesario)
* Acceder a la opción "Users"
* Pulsar sobre el botón "Add user" de la cabecera de la tabla
* Establecer el id : **user1**
* Pulsar sobre el botón "Save"
* Seleccionar pestaña de "Credentials"


**Configuración del Usuario**

Pasos a seguir:

* Pulsar sobre la pestaña "Credentials"
* Establecer el password : user1
* Establecer el password : **user1**
* Confirmar el password
* Deshabilitar la opción "Temporary"
  * Flag que obliga a cambiar la password cuando el usuario se conecte la primera vez
* Pulsar sobre el botón "Set Password"
* Confirmar la ventana modal

Debido a que el sistema de Keycloak está basado en roles por usuario, sería interesante crear un rol y asociarlo a un usuario. En nuestro caso no lo hemos hecho, pero si fuera necesario se realiza de la siguiente manera 

* Acceder a la opción "Roles"
* Pulsar sobre el botón "Add user"
* Establecer el role name : **role-test**
* Pulsar sobre el botón "Save"
* Acceder sobre el usuario seleccionado
* Seleccionar pestaña de "Role Mappings"
* Añadir el role "role-test"




## Versionado

**Nota :** [SemVer](http://semver.org/) es usado para el versionado.





## Autores

* **Víctor Madrid**
