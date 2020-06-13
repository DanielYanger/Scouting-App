import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    print(path);
    return File('$path/myfile.txt');
  }

  static Future<File> saveToFile(String data, String title) async {
    final path = await getFilePath;
    var directory = new Directory('$path/matchdata');
    directory.create();
    var file = new File('$path/matchdata/$title.txt');
    print(file.path);
    file.create();
    return file.writeAsString(data);
  }

  static Future<File> saveToFileJSON(String data, String title) async {
    final path = await getFilePath;
    var directory = new Directory('$path/matchData');
    directory.create();
    var file = new File('$path/matchData/$title.json');
    print(file.path);
    file.create();
    return file.writeAsString(data);
  }

  static Future<File> pitSaveToFileJSON(String data, String title) async {
    final path = await getFilePath;
    var directory = new Directory('$path/pitData');
    directory.create();
    var file = new File('$path/pitData/$title.json');
    print(file.path);
    file.create();
    return file.writeAsString(data);
  }

  static Future<String> createFile(String fileName) async {
    final path = await getFilePath;
    var directory = new Directory('$path/matchdata');
    directory.create();
    var file = new File('$path/matchdata/$fileName.txt');
    print(file.path);
    file.create();
    return "Success";
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }
}
