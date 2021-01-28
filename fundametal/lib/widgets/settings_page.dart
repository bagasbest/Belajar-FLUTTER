import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/widgets/platform_widget.dart';

class SettingsPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: _buildList(context),
    );
  }
}

Widget _buildList(BuildContext context) {
  return ListView(
    children: [
      Material(
        child: ListTile(
          title: Text('Dark Theme'),
          trailing: Switch.adaptive(
            value: false,
            onChanged: (value) {
              defaultTargetPlatform == (TargetPlatform.android)
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Coming soon'),
                          content: Text('This feature will be developed soon!'),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        );
                      })
                  : showCupertinoDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Coming Soon'),
                          content: Text('This feature will be developed soon!'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      });
            },
          ),
        ),
      ),
    ],
  );
}
