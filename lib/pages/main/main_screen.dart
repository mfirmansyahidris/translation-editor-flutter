import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _keySearch = GlobalKey<MaterialDataTableState>();

  @override
  void initState() {
    super.initState();

    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(600, 450);
      win.size = const Size(980, 640);
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
      toolbarColor: Palette.primary,
      toolbarTextColor: Palette.onPrimary,
      windowTitle: Strings.appName,
      body: Column(
        children: [
          HeaderSection(
            onSearch: (value){
              _keySearch.currentState?.setKeys(search: value);
            },
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spaceDefault
              ),
              child: MaterialDataTable(key: _keySearch,)
            ),
          ),
          const FooterSection()
        ],
      ),
    );
  }
}
