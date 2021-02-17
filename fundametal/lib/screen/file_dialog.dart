import 'dart:io';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileDialog extends StatelessWidget {
  final List<FileSystemEntity> files;

  FileDialog({this.files});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Choose your file'),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final file = files[index];
          return Material(
            child: ListTile(
              title: Text(file.toString()),
              onTap: () {
                Navigator.pop(context, file);
              },
            ),
          );
        },
        itemCount: files.length,
      ),
    );
  }
}
