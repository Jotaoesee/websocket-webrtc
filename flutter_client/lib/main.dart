import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080'),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Flutter Client'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  channel.sink.add(text);
                },
                decoration: InputDecoration(labelText: 'Enviar mensaje'),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
