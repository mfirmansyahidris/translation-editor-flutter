import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/widgets/windowed_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  @override
  void initState() {
    super.initState();

    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(600, 450);
      win.size = const Size(1024, 768);
      win.alignment = Alignment.center;
      win.title = Strings.appName;
      win.show();
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowedScaffold(
      toolbarColor: Palette.primaryContainer,
      windowTitle: Strings.appName,
    );
  }
}
