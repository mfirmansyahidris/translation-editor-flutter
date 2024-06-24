enum ScriptType {
  dart,
  json,
}

class Translation {
  Map<String, Map<String, String>> languages;
  String path;
  ScriptType? scriptType;
  Map<String, String>? filesName;

  Translation({
    required this.languages,
    required this.path,
    this.scriptType,
    this.filesName
  });

  Translation copyWith({
    Map<String, Map<String, String>>? languages,
    String? path,
    ScriptType? scriptType,
    Map<String, String>? filesName
  }){
    return Translation(
      languages: languages ?? this.languages, 
      path: path ?? this.path,
      scriptType: scriptType ?? this.scriptType,
      filesName: filesName ?? this.filesName
    );
  }
}