
# Training Keycloak

Este directorio contiene una serie de prácticas sobre Keycloak para la versión **254**

## Uso

### Configuración inicial del servidor Keycloak

Pasos a seguir:

* Verificar que los contenedores se encuentran arrancados
* Verificar que NO se muestra un error en ventana que contiene el login de los contenedores
* Acceder a la plataforma de keycloak: http://localhost:8083
 * La primera vez que se acceda aparecerá una ventana de "Bienvenida"
* Iniciar con el usuario admin configurado


### Realm

#### Creación de un Realm en Keycloak

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Añadir un realm nuevo desde el desplegable superior de la izquierda
  * Por defecto pondrá "Master" (realm proporcionado por defecto)
* Pulsar sobre el botón "Create realm"
* Establecer el nombre del realm: **Test**
* Pulsar sobre el botón "Create"
  * Al crear el realm automáticamente se cambia de realm
* Verificar que se encuentra en el realm "Test"
  * Aparecerá el realm "Test" seleccionado en el desplegable
  * Aparece una pantalla de home que da la bienvenida al realm Test



### Permitir el registro de usuarios en un Realm

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
* Verificar que se encuentra en ese realm
* Acceder a "Realm setting"
* Acceder a pestaña "Login"
  * Activar la opción "User registration" para permitir registro de usuarios
* Pulsar sobre el botón "Save"

### Creación de un cliente con servicio de roles de cuenta

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
* Acceder a la opción "Clients" del menú lateral izquierdo
* Seleccionar la pestaña "Client list"
* Pulsar sobre el botón "Create client"
* Verificar la pantalla de "Create client"
* Verificar seccion "General Settings"
* Establecer el client type : **openid-connect**
* Establecer el client ID : **client-postman**
* Pulsar sbre el botón "Next"
* Verificar seccion "Capability config"
* Establecer "Client Autentication" : true
* Establecer como único flujo de autenticación: "Service accounts roles"
* Pulsar sbre el botón "Next"
* Verificar seccion "Login settings"
* Pulsar sobre el botón "Save"
* Si todo ha ido bien se accedera a la pestaña de "Setting" del cliente que se acaba de crear

### Asociar el servicio de roles de cuenta para el cliente

* Verificar que nos encontramos en el cliente seleccionado
* Seleccionar la pestaña "Service accounts roles"
* Pulsar sobre el botón "Assign role"
* Buscar en el Buscador el termino: client
* Seleccionar la opcion: view-clients (asociado a realm-management)
* Pulsar sobre "Assign"

### Obtener un token al consultar el Admin API

```bash
curl --location 'http://localhost:8083/realms/test/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=client-postman' \
--data-urlencode 'client_secret=yg3me86bsNv5RuzvCjjppWmofZO8MvhS'
```

```bash
curl --location 'http://localhost:8083/realms/test/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=client-postman' \
--data-urlencode 'client_secret=yg3me86bsNv5RuzvCjjppWmofZO8MvhS' | jq -r '.access_token'
```

```bash
export ACCESS_TOKEN=$(curl --location 'http://localhost:8083/realms/test/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=admin-api-sample' \
--data-urlencode 'client_secret={your-client-secret}' | jq -r '.access_token')
```

```bash
curl --location 'http://localhost:8083/admin/realms' \
--header 'Authorization: Bearer '$ACCESS_TOKEN | jq

curl --location 'http://localhost:8083/admin/realms/test/clients' \
--header 'Authorization: Bearer '$ACCESS_TOKEN | jq
```

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

## Usuario

### Creación de un Usuario

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
* Acceder a la opción "Users"
* Pulsar sobre el botón "Create new user" or "Add user"
* Establecer el "username" : **user1**
* Establecer el email: **user1@gmail.com**
* Establecer el nombre: Tony
* Establecer el nombre: Stark
* Pulsar sobre el botón "Create"
* Verificar que se le ha asignado un ID y una fecha de creación

### Establecer la password de un usuario

Pasos a seguir:

* Pulsar sobre la pestaña "Credentials"
* Pulsar sobre el butón "Set password"
* Establecer el password: **changeit**
* Confirmar el password
* Deshabilitar la opción "Temporary"
  * Flag que obliga a cambiar la password cuando el usuario se conecte la primera vez
* Pulsar sobre el botón "Save"
* Confirmar la ventana modal con "Save password"

### Verificar el usuario creado

Pasos a seguir:

* Acceder a la plataforma de keycloak para ese realm: http://localhost:8083/realms/test/account
* Verificar que nos encontramos en ese realm
* Autenticarse con el usuario anteriormente creado
* Verificar que se entra en la plataforma con esas credenciales

### Verificar el usuario creado con impersonacion

Pasos a seguir:

* Acceder a la plataforma de keycloak: http://localhost:8083
* Iniciar con el usuario admin configurado
* Seleccionar el Realm sobre el que trabajar
* Acceder a la opción "Users"
* Seleccionar el usuario sobre el que se quiere aplicar impersonación
* Desplegar las acciones y seleccionar "Impersonate"
* Confirmar el modal
* Verificar que nos encontramos con la sesión del usuario impersonado




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