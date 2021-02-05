import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'main.dart';

class Ngetes extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  void goToMainPage(String nickname, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AnnouncementPage(nickname)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}


class AnnouncementPage extends StatelessWidget {
  AnnouncementPage(this.nickname);

  final String nickname;

  final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(URL));
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
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return snapshot.hasData ?
                  Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.headline4
                  )
                      :
                  CircularProgressIndicator();
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Enter your message here"
                ),
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            channel.sink.add("$nickname: ${controller.text}");
          }
      ),
    );
  }
}
