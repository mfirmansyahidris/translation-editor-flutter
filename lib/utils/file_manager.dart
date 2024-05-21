import 'dart:convert';
import 'dart:io';

import 'package:msq_translation_editor/msq_translation_editor.dart';

class FileManager{
  static List<File> openLanguageFile(String directoryPath){
    final dir = Directory(directoryPath);
    final files = dir.listSync();
    List<File> result = [];
    for (final file in files) {
      bool isFile = file.absolute.toString().split(":")[0] == "File";
      final references = Di.languages.map((e) => e.twoLetter).toList();
      bool isLanguageFile = references.contains(getFileName(File(file.path)).split(".").first) && isFile;

      if(isLanguageFile){
        result.add(File(file.path));
      }
    }
    return result;
  }

  static String getFileName(File file){
    String pathSeparator = "/";
    if(Platform.isWindows) pathSeparator = "\\";
    return file.path.split(pathSeparator).last.split(".").first;
  }

  static Future<Map<String, Map<String, String>>> toLanguageMap(List<File> files) async {
    final Map<String, Map<String, String>> lang = {};
    for(final file in files){
      final fileName = getFileName(file).split(".").first;
      final jsonString = await file.readAsString();
      final jsonData = jsonDecode(jsonString);
      if(jsonData is Map<String, dynamic>){
        lang[fileName] = jsonData.map((key, value) => MapEntry(key, value.toString()));
      }
    }
    return lang;
  }
}