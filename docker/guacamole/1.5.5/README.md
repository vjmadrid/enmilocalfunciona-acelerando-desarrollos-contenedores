

## Inicializaar la base de datos

Pasos a seguir

* Crear un directorio de inicialización de la base de datos

```bash
mkdir ./config/postgres/init
```

* Establecer permisos de ejecución

```bash
chmod -R +x ./config/postgres/init
```

* Generar script de creación de base de datos compatible con la versión de guacamole

```bash
docker run --rm guacamole/guacamole:1.5.5 /opt/guacamole/bin/initdb.sh --postgresql > ./config/postgres/init/initdb.sql
```