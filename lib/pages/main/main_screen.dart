import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/widgets/windowed_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();
  
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
                          DataColumn(label: const Text("#"),),
                          DataColumn(label: const Text("key")),
                          DataColumn(label: const Text("en-US")),
                          DataColumn(label: const Text("ko-KR")),
                          DataColumn(label: const Text("ja-JP")),
                          DataColumn(label: const Text("zn-CH")),
                        ],
                        rows: List<DataRow>.generate(
                          10, (index) => DataRow(
                            cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text("hello")),
                              DataCell(Text("Nulla viverra pretium quam, a feugiat orci"), ),
                              DataCell(Text("Nulla pulvinar rutrum pulvinar")),
                              DataCell(Text("Aliquam erat volutpat")),
                              DataCell(Text("ut pellentesque mi porttitor")),
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

  Widget _textHeader(String text){
    return Padding(
      padding: const EdgeInsets.all(Dimens.spaceXXS),
      child: Text(
        text,
        style: TextStyles.titleSmall?.copyWith(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
