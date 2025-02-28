# gotenberg 8.17

Este proyecto representa una estructura de recursos utilizados para el uso de **gotenberg** con **Docker**

* **docker-compose.yaml** representa una instalación independiente, básica, y customizada (a nivel de datos) de **gotenberg** con **Docker**





## Stack Tecnológico

* [Docker](https://www.docker.com/) - Tecnología de Contenedores/Containers
* [Docker Hub](https://hub.docker.com/) - Repositorio de Docker Publico
* [gotenberg](https://github.com/gotenberg/gotenberg) - API REST conversor a PDF

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
   # Project URL: https://github.com/gotenberg/gotenberg
   # Docs URL: https://gotenberg.dev/docs/getting-started/introduction
   gotenberg:
      image: gotenberg/gotenberg:8.17.1
      container_name: gotenberg
      restart: always
      networks: ['demo']
      command:
         # *** General ***
         - gotenberg
         - --log-level=debug # Logging levels
         - --api-timeout=10s
      ports:
         - 3000:3000
      #volumes:
         # *** Volume configuration ***
         #- ./gotenberg-data:/home/gotenberg

#volumes:
#   gotenberg-data:

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
