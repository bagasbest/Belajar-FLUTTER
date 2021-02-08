import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundametal/common/navigation.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Coming soon!'),
          content: Text('This feature will be soon'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigation.back(),
            ),
          ],
        );
      },
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Coming soon!'),
          content: Text('This feature will be soon'),
          actions: [
            FlatButton(
              onPressed: () => Navigation.back(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
