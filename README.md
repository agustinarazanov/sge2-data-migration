## Guía

### Prerequisitos
+ node
+ npm
+ docker

### Consideraciones
Completar la sección "target" en config/config.json y la variable DATABASE_URL en .env con los datos de la base de datos objetivo sobre la que se realizará la migración.

Es necesario que la base de datos objetivo exista.

### Migración
Copiar el dump de MySQL en el directorio actual con el nombre dump.sql y ejecutar:

```bash
sh migrate.sh
```