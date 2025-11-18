# Documentación del Despliegue

## Contenedores Docker

- Contenedor Apache:
  - Imagen usada: apache_image
  - Puertos expuestos: 8080 (HTTP), 8443 (HTTPS)
  - Red de Docker: mi_red
  - Comando de ejecución:
    ```
    docker run -d --name apache --network mi_red -p 8080:80 -p 8443:443 apache_image
    ```

- Contenedor cliente:
  - Imagen usada: otra_imagen
  - Comando de ejecución:
    ```
    docker run -it --network mi_red otra_imagen curl http://apache:80
    ```

## Procedimiento de despliegue

1. Crear la red de Docker:
2. Levantar contenedor Apache.
3. Levantar contenedor cliente.
4. Verificar la comunicación entre contenedores usando curl.
