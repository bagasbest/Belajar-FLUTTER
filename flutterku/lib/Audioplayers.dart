import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlayer;
  String durasi = "00:00:00";

  _MyAppState() {
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((duration) {
      setState(() {
        durasi = durasi.toString();
      });
    });

    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  void playSound(String url) async {
    await audioPlayer.seek(Duration(seconds: 30));
    await audioPlayer.play(url);
  }

  void pause() async {
    await audioPlayer.pause();
  }

  void stopSound() async {
    await audioPlayer.stop();
  }

  void resume() async {
    await audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  playSound('play sound');
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      size: 30,
                      color: Colors.blue,
                    ),
                    Text('Play')
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  pause();
                },
                child: Text('Pause'),
              ),
              RaisedButton(
                onPressed: () {
                  stopSound();
                },
                child: Text('Stop'),
              ),
              RaisedButton(
                onPressed: () {
                  resume();
                },
                child: Text(
                  'Resume',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                durasi,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
