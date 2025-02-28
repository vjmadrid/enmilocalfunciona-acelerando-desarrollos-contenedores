# smtp4dev v3

Este proyecto representa una estructura de recursos utilizados para el uso de **smtp4dev** con **Docker**

* **docker-compose.yaml** representa una instalación independiente, básica, y customizada (a nivel de datos) de **smtp4dev** con **Docker**





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [smtp4dev](https://github.com/rnwood/smtp4dev) - Fake SMTP

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
# Use Case: Basic Installation
services:
   # Project URL: https://github.com/rnwood/smtp4dev
   # Docs URL: https://github.com/rnwood/smtp4dev/blob/master/README.md
   smtp4dev:
      image: rnwood/smtp4dev:v3
      container_name: smtp4dev
      restart: always
      networks: ['demo']
      environment:
         # Uncomment to customise these settings
         #Specifies the virtual path from web server root where SMTP4DEV web interface will be hosted. e.g. "/" or "/smtp4dev"
         #- ServerOptions__BasePath=/smtp4dev
         #Specifies the server hostname. Used in auto-generated TLS certificate if enabled.
         - ServerOptions__HostName=smtp4dev
         #Locks settings from being changed by user via web interface
         #- ServerOptions__LockSettings=true
         #Specifies the path where the database will be stored relative to APPDATA env var on Windows or XDG_CONFIG_HOME on non-Windows. Specify "" to use an in memory database.
         #- ServerOptions__Database=database.db
         #Specifies the number of messages to keep
         #- ServerOptions__NumberOfMessagesToKeep=100
         #Specifies the number of sessions to keep
         #- ServerOptions__NumberOfSessionsToKeep=100
         #Specifies the TLS mode to use. None=Off. StartTls=On demand if client supports STARTTLS. ImplicitTls=TLS as soon as connection is established.
         #- ServerOptions__TlsMode=None
         #Specifies the TLS certificate to use if TLS is enabled/requested. Specify "" to use an auto-generated self-signed certificate (then see console output on first startup)
         #- ServerOptions__TlsCertificate=
         #Sets the name of the SMTP server that will be used to relay messages or "" if messages should not be relayed
         #- RelayOptions__SmtpServer=
         #Sets the port number for the SMTP server used to relay messages.
         #- RelayOptions__SmtpPort=25
         #Specifies a comma separated list of recipient addresses for which messages will be relayed. An empty list means that no messages are relayed.
         #- RelayOptions__AllowedEmailsString=
         #Specifies the address used in MAIL FROM when relaying messages. (Sender address in message headers is left unmodified). The sender of each message is used if not specified.
         #- RelayOptions__SenderAddress=
         #The username for the SMTP server used to relay messages. If "" no authentication is attempted.
         #- RelayOptions__Login=
         #The password for the SMTP server used to relay messages
         #- RelayOptions__Password=
         #Specifies the port the IMAP server will listen on - allows standard email clients to view/retrieve messages
         #"ServerOptions__ImapPort"=143
      ports:
         - 5051:80 # Web interface
         - 25:25 # SMTP server
         - 143:143 # IMAP server
      volumes:
         # *** Volume configuration ***
         - ./smtp4dev-data:/smtp4dev

volumes:
   smtp4dev-data:

networks:
   demo:
      name: demo
      driver: bridge
```

Pasos a seguir


1. Localizar el directorio principal del proyecto : <PROJECT_PATH> (/docker/smpt4dev/v3)

2. Ejecutar el siguiente comando

```bash
docker compose up --build

ó

docker compose up --build -d
```

3. Comprobar que la imagen ha sido creada

Verificar que parece como imagen Docker el nombre "smtp4dev"

4. Comprobar que la aplicación ha sido desplegada correctamente

Verificar mediante su interfaz web que esta disponible





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
