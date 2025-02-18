FROM debian:latest

# Actualizar e instalar Coturn
RUN apt update && apt install -y coturn

# Copiar la configuración de Coturn
COPY turnserver.conf /etc/turnserver.conf

# Ejecutar Coturn con la configuración correcta
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
