import 'package:flutter/material.dart';

class ExplixitAnimation extends StatefulWidget {
  @override
  _ExplixitAnimationState createState() => _ExplixitAnimationState();
}

class _ExplixitAnimationState extends State<ExplixitAnimation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _iconController;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _iconController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
    );
  }

  void dispose() {
    _controller.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
            IconButton(
              iconSize: 36,
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _iconController,
              ),
              onPressed: () {
                if (_isRotating) {
                  _controller.stop();
                  _iconController.reverse();
                } else {
                  _controller.repeat();
                  _iconController.forward();
                }

                _isRotating = !_isRotating;
              },
            ),
          ],
        ),
      ),
    );
  }
}
