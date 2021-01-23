import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PositifkanTubuhmu extends StatefulWidget {
  @override
  _PositifkanTubuhmuState createState() => _PositifkanTubuhmuState();
}

class _PositifkanTubuhmuState extends State<PositifkanTubuhmu> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'NrfdR2tks0I',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positifkan Tubuhmu'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '5 Mindset ini Akan Membangkitkan Semangat Hidupmu',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Sumber video : Salam Inspirasi'),
                    ),
                  ],
                )),
            SizedBox(height: 16,),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
