import 'dart:convert';
import 'dart:io';

import 'package:msq_translation_editor/msq_translation_editor.dart';

import 'package:dart_eval/dart_eval.dart';

class FileManager{
  static List<File> openLanguageFile({required String directoryPath, required ScriptType type}){
    final dir = Directory(directoryPath);
    final files = dir.listSync();
    List<File> result = [];
    for (final file in files) {
      bool isFile = file.absolute.toString().split(":")[0] == "File";
      if(!isFile) continue;

      final references = Di.languages.map((e) => e.twoLetter).toList();
      bool isLanguageFile = references.contains(getFileName(File(file.path)).replaceAll("_", "-"));
      
      if(!isLanguageFile){
        final shortReferences = references.map((e) => e.split("-").first);
        isLanguageFile = shortReferences.contains(getFileName(File(file.path)));
      }

      final fileExtention = getFileName(File(file.path), withExtention: true).split('.').last;

      bool isSelectedExtention = false;
      if(fileExtention.toLowerCase() == type.name){
        isSelectedExtention = true;
      }

      if(isLanguageFile && isSelectedExtention){
        result.add(File(file.path));
      }
    }
    return result;
  }

  static String getFileName(File file, {bool withExtention = false}){
    String pathSeparator = "/";
    if(Platform.isWindows) pathSeparator = "\\";
    if(withExtention){
      return file.path.split(pathSeparator).last;
    }
    return file.path.split(pathSeparator).last.split(".").first;
  }
  Map<String, Map<String, String>> languages = {};

  static Future<Translation> getLanguages(List<File> files) async {
    final Map<String, Map<String, String>> lang = {};
    final Map<String, String> filesName = {};
    for(final file in files){
      final fileName = getFileName(file, withExtention: true).split(".");
      final jsonString = await file.readAsString();

      dynamic jsonData;
      if(fileName.last.toUpperCase() == "JSON"){
        jsonData = jsonDecode(jsonString);
      }else if(fileName.last.toUpperCase() == "DART"){
        jsonData = jsonDecode(_dartEncode(jsonString, fileName.first));
      }

      if(jsonData is Map<String, dynamic>){
        String key = fileName.first.replaceAll(RegExp(r'[-_]'), "-");
        filesName[key] = fileName.first;
        lang[key] = jsonData.map((key, value) => MapEntry(key, value.toString()));
      }
    }
    return Translation(
      languages: lang, 
      path: '',
      filesName: filesName
    );
  }

  static dynamic _dartEncode(String script, String lang){
    final langKey = lang.replaceAll(RegExp(r'[-_]'), "");
    String? variableName;
    if(script.contains(" _$langKey")){
      variableName = "_$langKey";
    }else if(script.contains(" $langKey")){
      variableName = langKey;
    }

    if(variableName == null) return;

    List<String> lines = script.split('\n');
    List<String> modifiedLines = [];

    for (final line in lines) {
      if (!line.contains("part of ")) {
        modifiedLines.add(line);
      }
    }

    String modifiedScript = modifiedLines.join('\n');
    
    final program = '''
      import 'dart:convert';
      String main() {
        return jsonEncode($variableName);
      }

      $modifiedScript

    ''';

    return eval(program, function: 'main');
  }


  static Future<void> saveFiles(Translation translation) async {
    String separator = "/";
    if(Platform.isWindows) separator = "\\";

    translation.languages.forEach((key, value) async { 
      final output = File("${translation.path}$separator${translation.filesName?[key] ?? key}.${translation.scriptType?.name}");
      await output.create();
      if(translation.scriptType == ScriptType.json){
        await output.writeAsString(_getPrettyJSONString(value));
      }else if(translation.scriptType == ScriptType.dart){
        String content = await output.readAsString();
        final isScriptExisted = content.contains(RegExp(r'\{[^}]*\}'));
        if(isScriptExisted){
          content = content.replaceAll(RegExp(r'\{[^}]*\}'), _getPrettyJSONString(value));
        }else{
          final variableName = key.replaceAll(RegExp(r'[-_]'), "");
          content = '''const Map<String, String> _$variableName = ${_getPrettyJSONString(value)};''';
        }
        await output.writeAsString(content);
      }
    });
  }

  static String _getPrettyJSONString(jsonObject){
    var encoder = const JsonEncoder.withIndent("    ");
    return encoder.convert(jsonObject);
  }
}