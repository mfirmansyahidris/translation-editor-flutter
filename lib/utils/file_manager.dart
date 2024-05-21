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
      bool isLanguageFile = references.contains(_getFileName(File(file.path)).split(".").first) && isFile;

      if(isLanguageFile){
        result.add(File(file.path));
      }
    }
    return result;
  }

  static String _getFileName(File file){
    String pathSeparator = "/";
    if(Platform.isWindows) pathSeparator = "\\";
    return file.path.split(pathSeparator).last.split(".").first;
  }
  Map<String, Map<String, String>> languages = {};

  static Future<Map<String, Map<String, String>>> getLanguages(List<File> files) async {
    final Map<String, Map<String, String>> lang = {};
    for(final file in files){
      final fileName = _getFileName(file).split(".").first;
      final jsonString = await file.readAsString();
      final jsonData = jsonDecode(jsonString);
      if(jsonData is Map<String, dynamic>){
        lang[fileName] = jsonData.map((key, value) => MapEntry(key, value.toString()));
      }
    }
    return lang;
  }

  static Future<void> saveFiles({
    required Map<String, Map<String, String>> languages,
    required String path
  }) async {
    String separator = "/";
    if(Platform.isWindows) separator = "\\";

    languages.forEach((key, value) async { 
      final output = File("$path$separator$key.json");
      await output.create();
      await output.writeAsString(_getPrettyJSONString(value));
    });
  }

  static String _getPrettyJSONString(jsonObject){
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }
}