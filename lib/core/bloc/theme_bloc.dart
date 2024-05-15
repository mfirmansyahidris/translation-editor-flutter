import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class ThemeBloc extends Cubit<ThemeData>{
  ThemeBloc(): super(ThemeData.light());

  Future<void> set(BuildContext context, {
    Brightness? brightness,
    bool save = false
  }) async {
    Brightness? newBrightness;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    AppThemes theme = AppThemes(textTheme);
    final systemBrightness = View.of(context).platformDispatcher.platformBrightness;

    if(brightness == null){
      final savedBrightness = await Di.localStorage.getTheme();
      if(savedBrightness == null){
        newBrightness = systemBrightness;
      }else{
        newBrightness = savedBrightness;
      }
    }else{
      newBrightness = brightness;
    }

    if(newBrightness == Brightness.dark){
      emit(theme.dark());
    }else{
      emit(theme.light());
    }

    if(save){
      Di.localStorage.setTheme(newBrightness);
    }
  }
}