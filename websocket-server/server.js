const WebSocket = require('ws');

// Crear servidor WebSocket
const wss = new WebSocket.Server({ port: 8080 });

// Cuando un cliente se conecta
wss.on('connection', ws => {
    console.log('Nuevo cliente conectado');

    // Recibir mensaje del cliente
    ws.on('message', message => {
        console.log(`Mensaje recibido: ${message}`);

        // Enviar mensaje de vuelta al cliente
        ws.send('Mensaje recibido');
    });
});

console.log('Servidor WebSocket corriendo en puerto 8080');
