import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class MainScreen extends StatefulWidget {
  final String path;
  const MainScreen({super.key, required this.path});

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

    final languageFiles = FileManager.openLanguageFile(widget.path);
    FileManager.getLanguages(languageFiles).then((value){
      _translationBloc.init(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowedScaffold(
      toolbarColor: Palette.primary,
      toolbarTextColor: Palette.onPrimary,
      windowTitle: Strings.appName,
      body: BlocBuilder<TranslationBloc, Map<String, Map<String, String>>>(
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
                  for(final lang in state.keys.toList()){
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
                    visible: state.isNotEmpty,
                    child: MaterialDataTable(
                      key: _keySearch,
                      languages: state,
                    ),
                  )
                ),
              ),
              const FooterSection()
            ],
          );
        }
      ),
    );
  }
}
