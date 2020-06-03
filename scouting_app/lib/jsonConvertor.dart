import 'dart:convert';

class JSONConverter {
  static String convertToJSON(String data) {
    List<String> splitData = data.split(",");
    List<List<String>> finalData = [];
    for (String i in splitData) {
      finalData.add(i.split(":"));
    }

    for (List<String> i in finalData) {
      for (String j in i) {
        j.trim();
      }
    }
  }
}
