import 'dart:convert';
import 'dart:io';

class SocketUtil {
  Socket _socket;
  static const String SERVER_IP = 'http://localhost';
  static const int SERVER_PORT = 3000;

  Future<bool> sendMessage(String message, Function connectionListener) async {
    try {
      print('$SERVER_IP:$SERVER_PORT');
      _socket = await Socket.connect(SERVER_IP , SERVER_PORT);
      print('$SERVER_IP:$SERVER_PORT');

      connectionListener(true);
      _socket.listen((List<int> event) {
        String message = utf8.decode(event);
        print('Message: $message');
      });
      _socket.add(utf8.encode(message));
      _socket.close();
    } catch (e) {
      connectionListener(false);
      return false;
    }
    return true;
  }

  void cleanUp() {
    if (null != _socket) {
      _socket.destroy();
    }
  }

}