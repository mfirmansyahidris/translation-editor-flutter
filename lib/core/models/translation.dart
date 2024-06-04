enum ScriptType {
  dart,
  json,
}

class Translation {
  Map<String, Map<String, String>> languages;
  String path;
  ScriptType? scriptType;

  Translation({
    required this.languages,
    required this.path,
    this.scriptType
  });

  Translation copyWith({
    Map<String, Map<String, String>>? languages,
    String? path,
    ScriptType? scriptType
  }){
    return Translation(
      languages: languages ?? this.languages, 
      path: path ?? this.path,
      scriptType: scriptType ?? this.scriptType
    );
  }
}