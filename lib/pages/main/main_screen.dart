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

  @override
  void initState() {
    super.initState();
    final languageFiles = Di.translation.openLanguageFile(widget.path);
    Di.translation.setLanguages(languageFiles).then((value){
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
            onAdd: (){
              final Map<String, String> translation = {};
              for(final lang in Di.translation.languages.keys.toList()){
                translation[lang] = "";
              }
              showDialog(
                context: context, 
                builder: (context) => DetailDialog(
                  keyword: "",
                  translation: translation,
                )
              );
            },
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spaceDefault
              ),
              child: Visibility(
                visible: Di.translation.languages.isNotEmpty,
                child: MaterialDataTable(
                  key: _keySearch,
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
