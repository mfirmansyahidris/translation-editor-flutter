import 'package:flutter_bloc/flutter_bloc.dart';

class TranslationBloc extends Cubit<Map<String, Map<String, String>>>{
  TranslationBloc(): super({});

  Map<String, Map<String, String>> languages = {};  

  Future<void> init(Map<String, Map<String, String>> languages) async{
    this.languages = languages;
    emit(languages);
  }

  void addAll(Map<String, Map<String, String>> newWords){
    newWords.forEach((key, value) {
      languages[key]?.addAll(value);
    });
    emit(languages);
  }

}