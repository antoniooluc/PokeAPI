FROM node:22-alpine

# Directorio de la aplicación
WORKDIR /app

# Copiar dependencias primero (cache de capas)
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del proyecto
COPY . .

# Exponer el puerto de Nuxt
EXPOSE 3000

# Comando por defecto
CMD ["npm", "run", "dev"]
