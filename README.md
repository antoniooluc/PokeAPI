# Instrucciones para ejecutarlo en local 

Este proyecto utiliza **Docker Compose** para simplificar la instalación y evitar conflictos de dependencias o versiones de Node/Nuxt.

## Cómo levantar el entorno

```bash
# CLonar el repositorio
git clone https://github.com/antoniooluc/PokeAPI.git

# Construir la imagen y arrancar el contenedor en segundo plano
docker compose up --build -d

# Ver logs en tiempo real
docker compose logs -f

# Parar y eliminar contenedores
docker compose down

```
