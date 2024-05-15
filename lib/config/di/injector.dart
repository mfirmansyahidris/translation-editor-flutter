import 'package:get_it/get_it.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

GetIt _sl = GetIt.instance;

class Injector{
  static Future<void> initialization() async{
    _sl.registerLazySingleton<LocalStorage>(() => LocalStorage());
  }
}

class Di{
  static LocalStorage localStorage = _sl<LocalStorage>();
}