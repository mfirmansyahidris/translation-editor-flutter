import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/utils/transitions.dart' as tr;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Injector.initialization();
  runApp(
    EasyLocalization(
      supportedLocales: Locales.supportedLocales,
      path: Locales.translations,
      fallbackLocale: Locales.supportedLocales.first,
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: GlobalProvider(
          child: const App(),
        ),
      )
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = Strings.appName;
    win.show();
  });

}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read();
    Di.localStorage.getTheme().then((brigtness){
      if(brigtness == null){
        _themeBloc.set(context, brightness: Brightness.light);
      }else{
        _themeBloc.set(context, brightness: brigtness);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: AppRoutes.splash,
          theme: theme,
          onGenerateRoute: (RouteSettings settings) {
            final routes = AppRoutes.getRoutes(routeSettings: settings);
            final WidgetBuilder? builder = routes[settings.name];
        
            final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
            if(arguments != null){
              final PageTransition? transition = arguments["pageTransition"];
              if(transition == PageTransition.slide){
                return tr.Transition.slide(builder!, settings);
              }
            }
        
            return tr.Transition.stack(builder!, settings);
          },
          navigatorKey: AppNavigator.navigatorKey,
        );
      }
    );
  }
}