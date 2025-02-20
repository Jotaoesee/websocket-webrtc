import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selecciona una opción")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebSocketScreen()));
              },
              child: Text("Conectar a WebSocket",
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebRTCChat()));
              },
              child:
                  Text("Iniciar WebRTC", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class WebSocketScreen extends StatefulWidget {
  @override
  _WebSocketScreenState createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      setState(() {
        _messages.add("Recibido: $message");
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      channel.sink.add(_messageController.text);
      setState(() {
        _messages.add("Enviado: ${_messageController.text}");
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebSocket")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _messageController,
              decoration: InputDecoration(
                  labelText: "Escribe un mensaje",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text("Enviar", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(_messages[index],
                        style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------ VIDEO CHAT CON WEBRTC ------------------------
class WebRTCChat extends StatefulWidget {
  const WebRTCChat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WebRTCChatState createState() => _WebRTCChatState();
}

class _WebRTCChatState extends State<WebRTCChat> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  RTCDataChannel? _dataChannel;
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _setupWebRTC();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _setupWebRTC() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {
          'urls': 'turn:localhost:3478',
          'username': 'user',
          'credential': 'supersecretkey'
        },
      ]
    };

    _peerConnection = await createPeerConnection(configuration);
    _peerConnection!.onIceCandidate = (candidate) {
      print("Nuevo ICE Candidate: ${candidate.toMap()}");
    };

    _dataChannel =
        await _peerConnection!.createDataChannel("chat", RTCDataChannelInit());

    _dataChannel!.onMessage = (RTCDataChannelMessage message) {
      setState(() {
        messages.add("Otro: ${message.text}");
      });
    };

    final localStream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});
    _localRenderer.srcObject = localStream;
    _peerConnection!.addStream(localStream);
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _dataChannel!.send(RTCDataChannelMessage(_messageController.text));
      setState(() {
        messages.add("Tú: ${_messageController.text}");
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Chat con WebRTC")),
      body: Column(
        children: [
          Expanded(child: RTCVideoView(_localRenderer)),
          Expanded(child: RTCVideoView(_remoteRenderer)),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(messages[index]));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Escribe un mensaje",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
