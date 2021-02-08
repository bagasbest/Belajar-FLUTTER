import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/ngetes.dart';
import 'package:websocket/socket_util.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Web Socket Demo'),
        ),
        body: Menus(),
      ),
    );
  }
}

class Menus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (context) => WebSocketDemo(),
              );
              Navigator.push(context, route);
            },
            child: Text('WebSocket echo'),
          ),
          RaisedButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (context) => WebSocketDemo2(),
              );
              Navigator.push(context, route);
            },
            child: Text('WebSocket ke-2'),
          ),
        ],
      ),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('wss://echo.websocket.org/');

  @override
  _WebSocketDemoState createState() => _WebSocketDemoState(channel: channel);
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final WebSocketChannel channel;
  final _inputController = TextEditingController();
  List<String> messageList = [];

  _WebSocketDemoState({this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ke1'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        labelText: 'Send message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: () {
                        if (_inputController.text.isNotEmpty) {
                          channel.sink.add(_inputController.text);
                          _inputController.text = '';
                        }
                      },
                      child: Text('Send'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: getMessageList(),
            ),
          ],
        ),
      ),
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in messageList) {
      listWidget.add(
        ListTile(
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            color: Colors.tealAccent,
            height: 60,
          ),
        ),
      );
    }
    return ListView(
      children: listWidget,
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    channel.sink.close();
    super.dispose();
  }
}

class WebSocketDemo2 extends StatefulWidget {
  @override
  _WebSocketDemo2State createState() => _WebSocketDemo2State();
}

class _WebSocketDemo2State extends State<WebSocketDemo2> {
  TextEditingController _inputController;
  WebSocketChannel _channel;
  String _status;
  SocketUtil _socketUtil;
  List<String> _messages;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    // _connectSocketChannel();
    _status = '';
    _socketUtil = SocketUtil();
    _messages = List<String>();
  }

  _connectSocketChannel() {
    _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  void sendMessage() {
    _channel.sink.add(_inputController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ke2'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                filled: true,
                fillColor: Colors.white60,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Message',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              onPressed: () {
                if (_inputController.text.isEmpty) {
                  return;
                }
                // sendMessage();
                _socketUtil.sendMessage(
                    _inputController.text, connectionListener);
                //_inputController.text = '';
              },
              child: Text('Click'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(_status),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     return Padding(
            //       padding: EdgeInsets.symmetric(vertical: 24),
            //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
  void connectionListener(bool connected) {
    setState(() {
      _status = 'Status: ' + (connected ? 'Connected' : 'Failed to connect');
      print(_status);
    });
  }
}
