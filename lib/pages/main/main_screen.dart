import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class MainScreen extends StatefulWidget {
  final String path;
  const MainScreen({super.key, required this.path});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _keySearch = GlobalKey<MaterialDataTableState>();

  Map<String, Map<String, String>> _languages = {};

  @override
  void initState() {
    super.initState();
    final languageFiles = FileManager.openLanguageFile(widget.path);
    FileManager.toLanguageMap(languageFiles).then((value){
      setState(() {
        _languages = value;
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
              child: Visibility(
                visible: _languages.isNotEmpty,
                child: MaterialDataTable(
                  key: _keySearch,
                  languages: _languages,
                ),
              )
            ),
          ),
          const FooterSection()
        ],
      ),
    );
  }
}
