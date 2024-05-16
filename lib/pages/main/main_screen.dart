import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/resources/localization/languages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _languagesSource = Languages();

  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();

  List<String> get _languages => _languagesSource.keys.keys.toList();

  List<String> get _keys {
    final keys = <String>{};
    for (var language in _languages) { 
      keys.addAll(_languagesSource.keys[language]?.keys.toList() ?? []);
    }
    final listKey = keys.toList();
    listKey.sort((a, b) => a.compareTo(b));
    return listKey;
  }
  
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
          const HeaderSection(),
          const Divider(),
          Expanded(
            child: Scrollbar(
              controller: _vertical,
              child: Scrollbar(
                controller: _horizontal,
                notificationPredicate: (notif) => notif.depth == 1,
                child: SingleChildScrollView(
                  controller: _vertical,
                  child: SingleChildScrollView(
                    controller: _horizontal,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.spaceDefault),
                      child: DataTable(
                        columns: [
                          const DataColumn(label: Text("#"),),
                          const DataColumn(label: Text("key")),
                          ... _languages.map((e) => DataColumn(label: Text(e)))
                        ],
                        rows: List<DataRow>.generate(
                          _keys.length, (index) => DataRow(
                            cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(_keys[index])),
                              ... _languages.map((e) => DataCell(Text(_languagesSource.keys[e]?[_keys[index]] ?? ""), )),
                            ]
                          )
                        ),
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
          const FooterSection()
        ],
      ),
    );
  }
}
