import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<File> writeFile(String path, String content) async {
    final file = File(path);

    ///menuliskan kontent kedalam berkas
    print('saved to $path');
    return file.writeAsString('$content');
  }

  static Future<String> readFile(String filePath) async {
    try {
      final file = File(filePath);

      /// membaca berkas debagai sebuah string
      String contents = await file.readAsString();
      return contents;
    } catch (err) {
      print(err);
      return '';
    }
  }

  static Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final prefix = directory.path;
    final absolutePath = '$prefix/$fileName.text';
    return absolutePath;
  }
}
