import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class TranslationBloc extends Cubit<Translation>{
  TranslationBloc(): super(Translation(languages: {}, path: ''));

  Translation _translation = Translation(languages: {}, path: '');

  Translation get translation => _translation;

  void setScriptType(ScriptType type){
    _translation.scriptType = type;
    emit(_translation);
  }

  void setPath(String path){
    _translation.path = path;
    emit(_translation);
  }

  Future<void> init(Translation translation) async{
    _translation = translation;
    emit(translation);
  }

  void addAll(Map<String, Map<String, String>> newWords){
    newWords.forEach((key, value) {
      _translation.languages[key]?.addAll(value);
    });
    emit(_translation);
  }

}