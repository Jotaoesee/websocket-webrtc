FROM debian:latest

# Actualizar e instalar Coturn
RUN apt update && apt install -y coturn

# Copiar la configuración de Coturn
COPY turnserver.conf /etc/turnserver.conf

# Exponer el puerto 3478 (TURN)
EXPOSE 3478/udp
EXPOSE 3478/tcp

# Ejecutar Coturn con la configuración correcta
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
