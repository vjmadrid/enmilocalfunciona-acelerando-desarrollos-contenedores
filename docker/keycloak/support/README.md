
# keycloak-support

Este proyecto representa una estructura de recursos utilizados para el uso de **Keycloak** con **Docker** y persistencia
en base de datos **Postgresql**

Existe la posibilidad de utilizar una versión que incorpora el sistema de email fake **smtp4dev** y el administrador de la base de datos Postgres **pg-admin**

>**Importante**
>
>SE INICIA SIN CONFIGURACIONES EXTRA, UNICAMENTE TENDRÁ EL USUARIO ADMIN
>
>Posteriormente se persistirá todo lo que se haga





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Público
* [Keycloak](https://www.keycloak.org/) - Herramienta IAM / IdP
* [Postgresql](https://www.postgresql.org/) - Base de datos relacional
* [PGAdmin](https://www.pgadmin.org/) - Cliente de la base de datos Postgres
* [Smtp4dev](https://github.com/rnwood/smtp4dev) - Servidor smtp email fake

Dependencias con Proyectos de Arquitectura

N/A

Dependencias con Terceros

N/A





## Prerrequisitos

Define que elementos son necesarios para instalar el software

* Docker instalado (19+)
* curl
* [jq](https://jqlang.github.io/jq/download/)





## Instalación

### Docker Compose

Configuración del fichero "docker-compose.yaml"

```bash

```

En este fichero se establece el constructor de la imagen que se utilizará para Keycloak (versión específica o la última disponible), se establecerán una serie de variables de entorno necesarias para su ejecución.

Se proporciona el fichero que ha sido exportado previamente y que contiene una configuración determinada, dicho fichero será importado por Keycloak en el arranque. Para ello establece un volumen de intercambio entre un fichero en una ruta local y el mismo fichero dentro del contenedor.

Además se establece el constructor de la imagen que se utilizará para Postgres, se establecerán una serie de variables de entorno necesarias para su ejecución, se definirán una serie de volúmenes y se publicará por el puerto específico de la aplicación


Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH>

2. Ejecutar el siguiente comando

```bash
docker compose -f <nombre_fichero.xml> up --build

ó

docker compose -f <nombre_fichero.xml> up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "keycloak"

4. Verificar la instalación

Listar todos los contenedores en ejecución en tu sistema

```bash
docker ps
```


5. Comprobar que las aplicación ha sido desplegada correctamente

Verificar mediante el acceso a la aplicación mediante la URL : http://localhost:8083





## Configuración



### Configuración Postgres

#### Detalle

La configuración de la aplicación se encuentra disponible en la sección de las variables de entorno del contenedor.

[Documentación](https://hub.docker.com/_/postgres)

Estas varibles de entorno son las propias de la herramienta y estan referenciadas con otras variables de entorno ubicadas en el fichero ".env"

Se identificarán por el prefijo "DB_"

#### Particularidades

Principalmente hará uso de: base de datos que utilizará y las credenciales de acceso

#### Persistencia

Monta un volumen local para almacenar los datos persistentes: **db-data**



### Configuración PGAdmin

#### Detalle

La configuración de la aplicación se encuentra disponible en la sección de las variables de entorno del contenedor.

[Documentación](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html)

Estas varibles de entorno son las propias de la herramienta y estan referenciadas con otras variables de entorno ubicadas en el fichero ".env"

Se identificarán por el prefijo "PGADMIN_"

#### Particularidades

Principalmente hará uso de: las credenciales de acceso

#### Persistencia

Monta un volumen local para almacenar los datos persistentes: **pgadmin-data**

#### Configurar Postgres

**Agregar un Servidor Postgres**

Pasos a seguir:

* Verificar que el contenedor de Postgres se encuentra disponible
* Verificar que el contenedor de PGAdmin se encuentra disponible
* Acceder a la URL de la herramienta PGAdmin: http://localhost:5050
* Iniciar sesión con las credenciales por defecto (email: admin@acme.com y password: admin)
* Añadir un nuevo Server
* Establecer el nombre: db
* Acceder a la pestaña de Conexion
* Rellenar los siguientes campos
  * Hostname (nombre del contenedor): db
  * Username: keycloak
  * Password: keycloak
* Verificar que se puede acceder desde el menu de servidores



### Configuración smtp4dev

#### Detalle

La configuración de la aplicación se encuentra disponible en la sección de las variables de entorno del contenedor.

[Documentación](https://github.com/rnwood/smtp4dev)

#### Particularidades

Principalmente hará uso de: las credenciales de acceso

#### Persistencia

Monta un volumen local para almacenar los datos persistentes: **smtp4dev-data**




### Configuración Keycloak

#### Detalle

La configuración de la aplicación se encuentra disponible en la sección de las variables de entorno del contenedor.

[Documentación](https://www.keycloak.org/guides#getting-started)
[Expicación de variables desde el entorno Keycloak de Bitnamo](https://hub.docker.com/r/bitnami/keycloak/)
[Keycloak Admin REST API](https://www.keycloak.org/docs-api/22.0.5/rest-api/index.html)
[Documentaciíon version 25.0](https://www.keycloak.org/docs/25.0.6/release_notes/index.html)

Estas varibles de entorno son las propias de la herramienta y estan referenciadas con otras variables de entorno ubicadas en el fichero ".env"

Se identificarán por el prefijo "KEYCLOAK_"

#### Particularidades

Principalmente hará uso de: las credenciales de acceso, elementos de configuración, conexión a la base de datos, etc.

#### Persistencia

N/A





## Uso

### Acceso a las UI de los contedores

Nota: Depende de la configuración de puertos de los contenedores

Despliegue básico

* **Keycloak**: http://localhost:8083

Despliegue full

* **Keycloak**: http://localhost:8083
* **PgAdmin**: http://localhost:5050
* **Smtp4dev**: http://localhost:5051

### Configuración inicial del servidor Keycloak

Pasos a seguir:

* Verificar que los contenedores se encuentran arrancados
* Verificar que NO se muestra un error en ventana que contiene el login de los contenedores
* Acceder a la plataforma de keycloak: http://localhost:8083
 * La primera vez que se acceda aparecerá una ventana de "Bienvenida"
 * En este caso concreto, pulsar sobre el botón "Create"
* Iniciar sesión con el usuario admin configurado en las variables de entorno de docker
 * Importante: Este usuario tendrá todos los privilegios necesarios para acceder y manipular nuestro servidor
* Visualizar la interfaz de administración con el usuario admin autenticado
 * Visualizar la pestañas: "Welcome". "Server info" y "Provider info"
 * Este realm se corresponde con el realm principal

### Configurar el correo para el usuario "admin"

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar sesión con el usuario admin
* Acceder a la opción "Users" del menú lateral en la sección "Manage"
* Localizar en el buscador el usuario "admin"
* Acceder a las opciones de este usuario
* Establecer el email del usuario. Por ejemplo: admin@acme.com
* Pulsar sobre el botón "Save"
* Verificar en el modal que el usuario ha sido actualizado correctamente

### Configurar SMTP en un Realm

**IMPORTANTE**

* Require tener desplegado el contenedor "smtp4dev" correctamente
* requiere tener implementado el punto anterior de disponer de un usuario admin con correo

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
  * En este caso elegiremos el principal
* Acceder a la opción "Realm setting" del menú lateral en la sección "Configure"
* Acceder a pestaña "Email"
* En la sección "Template"
 * Establecer el correo from: support@acme.com
* En la sección "Connection"
 * Establecer host: smtp4dev
 * Establecer port: 25
* Probar la conexión
* Verificar que se ha realizado adecuadamente
* Pulsar sobre el botón "Save"
* Verificar en el modal que el realm ha sido actualizado correctamente
* Verificar que se creado un email en servidor smtp4dev

### Visualización de clientes predeterminados

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
  * En este caso elegiremos el principal
* Acceder a la opción "Clients" del menú lateral en la sección "Manage"
* Visualizar los clientes disponibles
  * **Account**: Cliente responsable de gestionar las cuentas de usuario del realm/dominio. Realiza acciones variadas como: cambiar su contraseña, desbloquear su cuenta, etc.
  * **Account Console**: UI responsable de gestionar las cuentas a los usuarios del realm/dominio mediante la consola proporcionada por Keycloak. Similar a "Account" pero con el uso de la interfaz de Keycloak
  * **Admin CLI**: Cliente responsable de permitir a los desarrolladores administrar el servidor Keycloak a través de la consola de línea de comandos (CLI). Realiza acciones como automatizar tareas de administración o bien con uso restringido a usuario que tengan permisos
  * Esto es útil para automatizar tareas de administración y su uso está restringido a los usuarios que tengan permisos de administración.
  * **Broker**: Ciente responsable de gestionar los clientes externos que se conecten al servidor Keycloak. Realiza acciones variadas como: habilitar la federación de identidades
  * **Security Admin Console**: Cliente responsable de gestionar los parámetros de seguridad de Keycloak. Realiza acciones variadas como: control de acceso, configuración de SSL, etc.






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