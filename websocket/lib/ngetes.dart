import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'main.dart';

class Ngetes extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  void goToMainPage(String nickname, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AnnouncementPage(nickname)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Nickname"),
              onSubmitted: (nickname) => goToMainPage(nickname, context),
            ),
            FlatButton(
                onPressed: () => goToMainPage(controller.text, context),
                child: Text("Log In"))
          ],
        ),
      ),
    );
  }
}

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage(this.nickname);

  final String nickname;

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  SocketIO socketIO;
  List<String> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController;

  @override
  void initState() {
    //Initializing the message list
    messages = [];
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
        "http://localhost:3000", "/chat", socketStatusCallback: _socketStatus);

    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      this.setState(() => messages.add(data['message']));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

//
//   Widget buildSingleMessage(int index) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
//         decoration: BoxDecoration(
//           color: Colors.deepPurple,
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Text(
//           messages[index],
//           style: TextStyle(color: Colors.white, fontSize: 15.0),
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildMessageList() {
//     return Container(
//       height: height * 0.8,
//       width: width,
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: messages.length,
//         itemBuilder: (BuildContext context, int index) {
//           return buildSingleMessage(index);
//         },
//       ),
//     );
//   }
//
//
//   Widget buildChatInput() {
//     return Container(
//       width: width * 0.7,
//       padding: const EdgeInsets.all(2.0),
//       margin: const EdgeInsets.only(left: 40.0),
//       child: TextField(
//         decoration: InputDecoration.collapsed(
//           hintText: 'Send a message...',
//         ),
//         controller: textController,
//       ),
//     );
//   }
//
//   Widget buildSendButton() {
//     return FloatingActionButton(
//       backgroundColor: Colors.deepPurple,
//       onPressed: () {
//         //Check if the textfield has text or not
//         if (textController.text.isNotEmpty) {
//           //Send the message as JSON data to send_message event
//           socketIO.sendMessage(
//               'send_message', json.encode({'message': textController.text}));
//           //Add the message to the list
//           this.setState(() => messages.add(textController.text));
//           textController.text = '';
//           //Scrolldown the list to show the latest message
//           scrollController.animateTo(
//             scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 600),
//             curve: Curves.ease,
//           );
//         }
//       },
//       child: Icon(
//         Icons.send,
//         size: 30,
//       ),
//     );
//   }
//
//   Widget buildInputArea() {
//     return Container(
//       height: height * 0.1,
//       width: width,
//       child: Row(
//         children: <Widget>[
//           buildChatInput(),
//           buildSendButton(),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: height * 0.1),
//             buildMessageList(),
//             buildInputArea(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//

  //var channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement Page"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          // StreamBuilder(
          //   stream: channel.stream,
          //   builder: (context, snapshot) {
          //     return snapshot.hasData
          //         ? Text(snapshot.data.toString(),
          //             style: Theme.of(context).textTheme.headline4)
          //         : CircularProgressIndicator();
          //   },
          // ),
          TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter your message here"),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            setState(() {
              if (controller.text.isNotEmpty) {
                //channel.sink.add('${widget.nickname}: ${controller.text}');
                //Send the message as JSON data to send_message event
                socketIO.sendMessage('send_message',
                    json.encode({'message': textController.text}));
              }
            });
          }),
    );
  }
}
