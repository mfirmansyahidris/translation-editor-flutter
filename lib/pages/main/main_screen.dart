import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class MainScreen extends StatefulWidget {
  final String path;
  final ScriptType type;
  const MainScreen({super.key, required this.path, required this.type});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _keySearch = GlobalKey<MaterialDataTableState>();
  String searchKey = "";

  late TranslationBloc _translationBloc;

  @override
  void initState() {
    super.initState();

    _translationBloc = context.read();

    final languageFiles = FileManager.openLanguageFile(directoryPath: widget.path, type: widget.type);
    FileManager.getLanguages(languageFiles).then((value){
      _translationBloc.init(Translation(languages: value, path: widget.path, scriptType: widget.type));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowedScaffold(
      toolbarColor: Palette.primary,
      toolbarTextColor: Palette.onPrimary,
      windowTitle: Strings.appName,
      drawer: const Drawer(
        child: Setup(),
      ),
      body: BlocBuilder<TranslationBloc, Translation>(
        builder: (context, state) {
          return Column(
            children: [
              HeaderSection(
                onSearch: (value){
                  searchKey = value;
                  _keySearch.currentState?.setKeys(search: searchKey);
                },
                onAdd: () async {
                  final Map<String, String> translation = {};
                  for(final lang in state.languages.keys.toList()){
                    translation[lang] = "";
                  }
                  final res = await  showDialog(
                    context: context, 
                    builder: (context) => DetailDialog(
                      keyword: "",
                      translation: translation,
                    )
                  );
                  if(res != null && res is bool){
                    _keySearch.currentState?.setKeys(search: searchKey);
                  }
                },
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spaceDefault
                  ),
                  child: Visibility(
                    visible: state.languages.isNotEmpty,
                    child: MaterialDataTable(
                      key: _keySearch,
                      languages: state.languages,
                    ),
                  )
                ),
              ),
              FooterSection(
                path: widget.path,
              )
            ],
          );
        }
      ),
    );
  }
}
