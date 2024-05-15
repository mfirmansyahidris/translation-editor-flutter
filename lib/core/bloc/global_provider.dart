import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class GlobalProvider extends MultiBlocProvider{
  GlobalProvider({super.key, required super.child}) : super(
    providers: [
      BlocProvider(create: (context) => ThemeBloc())
    ],
  );
}