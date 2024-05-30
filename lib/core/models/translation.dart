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
}