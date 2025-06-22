💬 WebSocket-WebRTC: Comunicación en Tiempo Real con Flutter 🚀
Descripción del Proyecto
WebSocket-WebRTC es una aplicación de demostración construida con Flutter que explora y ejemplifica la comunicación en tiempo real a través de dos tecnologías clave: WebSockets y WebRTC. Este proyecto ofrece una plataforma para experimentar con un chat de texto basado en WebSockets y una solución de videochat punto a punto que también incluye un canal de datos para chat de texto, utilizando WebRTC. Es una excelente base para comprender cómo integrar estas poderosas capacidades de comunicación en tus propias aplicaciones Flutter.

El Problema que Resuelve
En el desarrollo de aplicaciones modernas, la comunicación en tiempo real es fundamental para una experiencia de usuario rica. Este proyecto aborda el desafío de implementar:

Chat de Baja Latencia: Permite el intercambio instantáneo de mensajes de texto utilizando WebSockets.

Videollamadas P2P: Habilita la comunicación de audio y video directamente entre dos dispositivos, sin necesidad de un servidor intermedio para el streaming de medios (una vez establecida la conexión).

Canales de Datos Directos: Demuestra el uso de WebRTC DataChannels para enviar mensajes de texto o cualquier otro dato en un contexto P2P.

¿Para Quién es Útil?
Este proyecto es ideal para:

Desarrolladores de Flutter: Que desean aprender a implementar comunicación en tiempo real.

Estudiantes y Profesionales: Interesados en las bases de WebSockets y WebRTC.

Equipos: Que buscan un punto de partida para construir funciones de chat, videollamadas o streaming en sus aplicaciones móviles.

Investigadores: Que experimentan con tecnologías de comunicación en tiempo real en entornos móviles.

✨ Características Destacadas
Aplicación Flutter Multiplataforma: Desarrollada para Android, iOS (y potencialmente web/escritorio con configuraciones adicionales).

Integración de WebSockets:

Conexión a un servidor WebSocket.

Envío y recepción de mensajes de texto en tiempo real.

Interfaz de usuario para visualizar el flujo de mensajes.

Integración de WebRTC:

Videochat P2P: Establece conexiones de video y audio en vivo entre dos pares.

Canales de Datos (DataChannels): Permite el envío de mensajes de texto a través de la conexión WebRTC establecida.

Utiliza servidores STUN y TURN (configurables) para facilitar la conexión entre pares.

Muestra el feed de video local y remoto.

Separación de Funcionalidades: Menú de inicio claro que permite al usuario elegir entre la demo de WebSocket o la demo de WebRTC.

Código Claro y Modular: Estructura de código fácil de entender, ideal para fines educativos y de extensión.

🛠️ Tecnologías Utilizadas
Lenguaje de Programación: Dart

Framework de Desarrollo: Flutter

Comunicación WebSocket: web_socket_channel

Implementación WebRTC: flutter_webrtc

Sistema de Construcción: Gradle (para Android nativo)

Servicios Externos Requeridos (No incluidos en este repositorio):

Servidor WebSocket/Señalización: Necesario para el intercambio inicial de información (ofertas SDP, candidatos ICE) entre los pares WebRTC, y para el chat de texto vía WebSockets.

Servidor STUN/TURN: Fundamental para que WebRTC funcione correctamente en redes complejas (NAT, firewalls). En el código se usa stun:stun.l.google.com:19302 y un placeholder turn:localhost:3478.

🚀 Cómo Instalar y Ejecutar
Este proyecto requiere que tengas un entorno de desarrollo Flutter configurado, y para la funcionalidad completa de WebRTC, necesitarás un servidor de señalización y opcionalmente un servidor STUN/TURN.

Prerrequisitos
Flutter SDK: Se recomienda la última versión estable.

Un editor de código (VS Code, Android Studio).

Un dispositivo o emulador configurado para ejecutar aplicaciones Flutter.

Para la demo de WebSocket y WebRTC:

Un servidor WebSocket funcionando en ws://localhost:8080 (o la dirección que configures).

Un servidor STUN/TURN accesible (o puedes usar los servidores STUN públicos de Google para pruebas, como se muestra en el código, pero un servidor TURN local o propio es recomendado para pruebas completas).

Pasos de Instalación
Clona el repositorio:

git clone https://github.com/tu_usuario/websocket-webrtc.git
cd websocket-webrtc

(Nota: Reemplaza https://github.com/tu_usuario/websocket-webrtc.git con la URL real de tu repositorio.)

Instala las dependencias de Flutter:

flutter pub get

Configuración Específica de Plataforma (si aplica):

Android: Asegúrate de que android/app/build.gradle tenga las dependencias de flutter_webrtc y que los permisos necesarios para cámara y micrófono estén en AndroidManifest.xml.

iOS: Configura Info.plist para los permisos de cámara y micrófono.

Web: La conexión localhost podría requerir configuraciones de seguridad del navegador.

Cómo Ejecutar la Aplicación
Inicia tu servidor WebSocket/Señalización:
Asegúrate de tener un servidor WebSocket (por ejemplo, simple Node.js, Python, etc.) ejecutándose en ws://localhost:8080 que pueda reenviar mensajes entre clientes. Para WebRTC, este servidor también actuará como un servidor de señalización para el intercambio de SDP y candidatos ICE.
(Este servidor no está incluido en este repositorio. Debes tener uno propio o usar una solución existente.)

Inicia tu servidor STUN/TURN (Opcional, pero recomendado):
Si no usas los STUN públicos de Google y necesitas una solución TURN para redes NAT complejas, inicia tu propio servidor TURN (ej. coturn).
(Este servidor no está incluido en este repositorio.)

Ejecuta la aplicación Flutter:

flutter run

La aplicación se lanzará en el dispositivo o emulador que tengas configurado.

📈 Cómo Usar la Aplicación
Al iniciar la aplicación, serás presentado con dos opciones principales:

✉️ Demo de WebSocket (Chat de Texto)
Haz clic en el botón "Conectar a WebSocket".

Serás redirigido a una pantalla de chat simple.

Escribe un mensaje en el campo de texto y haz clic en "Enviar".

Si tu servidor WebSocket está funcionando correctamente y hay otros clientes conectados, verás cómo los mensajes se envían y reciben en tiempo real.

🎥 Demo de WebRTC (Video Chat y Chat de Datos)
Haz clic en el botón "Iniciar WebRTC".

La aplicación intentará establecer una conexión Peer-to-Peer.

Para que la comunicación funcione, necesitarás un segundo dispositivo (o pestaña del navegador si es en web) ejecutando esta misma aplicación o una compatible, y un servidor de señalización que les ayude a "encontrarse" e intercambiar la información inicial (Oferta/Respuesta SDP y Candidatos ICE).

Si la conexión se establece correctamente, verás tu video local y el video de tu par en las respectivas vistas.

Puedes enviar mensajes de texto a través del canal de datos WebRTC utilizando el campo de texto en la parte inferior.
