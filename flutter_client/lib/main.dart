import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080'),
  );

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple[50],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Flutter Client'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller, // Controlador para el campo de texto
                decoration: InputDecoration(
                  labelText: 'Enviar mensaje',
                  hintText: 'Escribe algo...',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    // Enviar mensaje al servidor cuando se presiona el botón
                    channel.sink.add(_controller.text);
                    _controller
                        .clear(); // Limpiar el campo de texto después de enviar
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Enviar mensaje',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Filtrar mensajes no deseados
                    String message = snapshot.data.toString();
                    if (message.contains('Mensaje cada 5 segundos')) {
                      return SizedBox.shrink(); // No mostrar este mensaje
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Si no hay datos, no mostrar nada
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
