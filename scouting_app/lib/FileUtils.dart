import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    print(path);
    return File('$path/MasterData.json');
  }

  static Future<File> get getFilePit async {
    final path = await getFilePath;
    print(path);
    return File('$path/PitMasterData.json');
  }

  static Future<File> get pickFile async {
    Future<File> file = FilePicker.getFile(type: FileType.any);
    return file;
  }

  static Future<String> readFile(Future<File> file) async {
    final schedule = await file;
    print("test");
    return schedule.readAsString();
  }

  static Future<File> saveToFileJSON(String data, String title) async {
    final path = await getFilePath;
    var file = new File('$path/$title.json');
    print(file.path);
    file.create();
    return file.writeAsString(data);
  }

  static Future<File> saveSchedule(String data) async {
    final path = await getFilePath;
    var file = new File('$path/schedule.txt');
    file.create();
    return file.writeAsString(data);
  }

  static Future<String> readSchedule() async {
    try {
      final path = await getFilePath;
      var file = File('$path/schedule.txt');
      String fileContents = await file.readAsString();
      print(fileContents);
      return fileContents;
    } catch (Exception) {
      return "";
    }
  }

  static Future<File> saveForm(String data) async {
    final path = await getFilePath;
    var file = new File('$path/form.txt');
    file.create();
    return file.writeAsString(data);
  }

  static Future<String> readForm() async {
    try {
      final path = await getFilePath;
      var file = File('$path/form.txt');
      String fileContents = await file.readAsString();
      print(fileContents);
      return fileContents;
    } catch (Exception) {
      return "";
    }
  }

  static Future<File> savePitForm(String data) async {
    final path = await getFilePath;
    var file = new File('$path/PitForm.txt');
    file.create();
    return file.writeAsString(data);
  }

  static Future<String> readPitForm() async {
    try {
      final path = await getFilePath;
      var file = File('$path/PitForm.txt');
      String fileContents = await file.readAsString();
      print(fileContents);
      return fileContents;
    } catch (Exception) {
      return "";
    }
  }

  static Future<String> readAndWriteFromFile(String data) async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      data = data.replaceAll("[]", "[\"\"]");
      print(data);
      String fileContents2 =
          fileContents.substring(0, fileContents.lastIndexOf("}") + 1) +
              "," +
              data +
              "]";
      file.writeAsString(fileContents2);
      return fileContents2;
    } catch (e) {
      print("error");
      data = data.replaceAll("[]", "[\"\"]");
      data = "[" + data + "]";
      saveToFileJSON(data, "MasterData");
      return (data);
    }
  }

  static Future<String> readAndWriteFromFilePit(String data) async {
    try {
      final file = await getFilePit;
      String fileContents = await file.readAsString();
      print(data);
      String fileContents2 =
          fileContents.substring(0, fileContents.lastIndexOf("}") + 1) +
              "," +
              data +
              "]";
      //final jsonResponse = json.decode(fileContents);
      file.writeAsString(fileContents2);
      return fileContents2;
    } catch (e) {
      print("error");
      data = "[" + data + "]";
      saveToFileJSON(data, "PitMasterData");
      return (data);
    }
  }
}
