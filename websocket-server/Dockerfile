# Usar la imagen base de Node.js
FROM node:16

# Crear y establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos del proyecto
COPY . .

# Instalar dependencias
RUN npm install

# Exponer el puerto en el que se ejecuta el servidor WebSocket
EXPOSE 8080

# Iniciar el servidor WebSocket
CMD ["node", "server.js"]


# para contruir el contenedor hacer : docker build -t websocket-server .
# para runear el contenedor hacer : docker run -p 8080:8080 websocket-server
