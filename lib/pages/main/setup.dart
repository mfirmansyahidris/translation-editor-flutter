import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  Locale? _selectedLanguage;
  late ThemeBloc _themeBloc;
  late TranslationBloc _translationBloc;
  final _directoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _selectedLanguage = context.locale;
      });
    });
    _themeBloc = context.read();
    _translationBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SpacerV.L,
        ListTile(
          leading: const Text(Strings.generalSetup).tr(),
        ),
        ListTile(
          title: Row(
            children: [
              Expanded(child: const Text(Strings.language).tr()),
              Expanded(
                child: DropdownButtonFormField<Locale>(
                  items: Locales.supportedLocales
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(e.toLanguageTag())))
                      .toList(),
                  value: _selectedLanguage,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    isDense: true
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      context.setLocale(value);
                      setState(() {
                        _selectedLanguage = value;
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
        BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, state){
            return ListTile(
              title: const Text(Strings.darkTheme).tr(),
              trailing: Switch(
                value: state.brightness == Brightness.dark,
                onChanged: (value) {
                  if(value){
                    _themeBloc.set(context, brightness: Brightness.dark, save: true);
                  }else{
                    _themeBloc.set(context, brightness: Brightness.light, save: true);
                  }
                },
              ),
            );
          }
        ),
        const Divider(),
        SpacerV.L,
        ListTile(
          leading: const Text(Strings.outputSetup).tr(),
        ),
        BlocBuilder<TranslationBloc, Translation>(
          builder: (context, state) {
            return ListTile(
              title: Row(
                children: [
                  Expanded(child: const Text(Strings.scriptType).tr()),
                  Expanded(
                    child: DropdownButtonFormField<ScriptType>(
                      items: [
                        DropdownMenuItem(
                          value: ScriptType.json, 
                          child: Text(ScriptType.json.name)
                        ),
                        DropdownMenuItem(
                          value: ScriptType.dart, 
                          child: Text(ScriptType.dart.name)
                        ),
                      ],
                      value: state.scriptType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), 
                        isDense: true
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          _translationBloc.setScriptType(value);
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          }
        ),
        BlocBuilder<TranslationBloc, Translation>(
          builder: (context, state) {
            _directoryController.text = state.path;
            return ListTile(
              title: Row(
                children: [
                  Expanded(child: const Text(Strings.directory).tr()),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        final dir = await FilePicker.platform.getDirectoryPath();
                        if(dir != null){
                          _translationBloc.setPath(dir);
                          setState(() {
                            
                          });
                        }
                      },
                      controller: _directoryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), 
                        isDense: true,
                      ),
                    )
                  ),
                ],
              ),
            );
          }
        ),
      ],
    );
  }
}
