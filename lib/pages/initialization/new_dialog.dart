import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class NewDialog extends StatefulWidget {
  final String initialPath;

  const NewDialog({super.key, required this.initialPath});

  @override
  State<NewDialog> createState() => _NewDialogState();
}

class _NewDialogState extends State<NewDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  final Set<Language> _selectedLanguages = {};

  void _reselectDirectory(){
    FilePicker.platform.getDirectoryPath().then((path){
      if(path != null){
        _formKey.currentState?.fields[Strings.directory]?.didChange(path);
      }
    });
  }

  Future<void> _create() async {
    if(_formKey.currentState?.saveAndValidate() ?? false){
      final path = _formKey.currentState?.value[Strings.directory];
      await Future.forEach(_selectedLanguages, (language) async {
        final file = File("$path/${language.twoLetter}.json");
        await file.create();
        file.writeAsStringSync("{}");
      }).then((value){
        final type = _formKey.currentState?.value[Strings.scriptType];
        AppNavigator.goToPageReplace(AppRoutes.main, arguments: {
          'path': path,
          'type': type
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.new1).tr(),
      content: SizedBox(
        width: Dimens.widthInPercent(50),
        child: FormBuilder(
          key: _formKey,
          onChanged: (){
            _selectedLanguages.clear();
            setState(() {
              _selectedLanguages.addAll(_formKey.currentState?.fields[Strings.languages]?.value);
            });
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: Strings.directory,
                  initialValue: widget.initialPath,
                  readOnly: true,
                  onTap: _reselectDirectory,
                  validator: FormBuilderValidators.required(
                    errorText: Strings.fieldIsRequired(Strings.directory.tr())
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(Strings.directory.tr()),
                  ),
                ),
                SpacerV.M,
                Text(
                  Strings.languages,
                  style: TextStyles.titleMedium,
                ).tr(),
                SpacerV.XXS,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusS),
                    border: Border.all(color: Palette.outlineVariant)
                  ),
                  height: 200,
                  child: FormBuilderCheckboxGroup(
                    name: Strings.languages,
                    validator: (languages){
                      if((languages ?? []).isEmpty){
                        return Strings.fieldIsRequired(Strings.languages.tr());
                      }
                      return null;
                    },
                    orientation: OptionsOrientation.vertical,
                    options: List.generate(Di.languages.length, (index){
                      final lang = Di.languages[index];
                      return FormBuilderFieldOption(
                        value: lang,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.spaceXXXS),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${lang.language}(${lang.twoLetter})"
                              ),
                              Text(
                                lang.country,
                                style: TextStyles.bodySmall?.copyWith(
                                  color: Palette.outline
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                if(_selectedLanguages.isNotEmpty) SpacerV.XXS,
                if(_selectedLanguages.isNotEmpty) Wrap(
                  spacing: Dimens.spaceDefault,
                  children: _selectedLanguages.map((e) => TextButton(
                    child: Text(
                      "${e.language}(${e.twoLetter})",
                      style: TextStyles.bodyMedium?.copyWith(
                        color: Palette.primary,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        _selectedLanguages.remove(e);
                      });
                      _formKey.currentState?.fields[Strings.languages]?.didChange(_selectedLanguages.toList());
                    },
                  )).toList(),
                ),
                SpacerV.M,
                FormBuilderRadioGroup<ScriptType>(
                  name: Strings.scriptType, 
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text(Strings.scriptType).tr()
                  ),
                  validator: FormBuilderValidators.required(),
                  options: [
                    FormBuilderFieldOption(
                      value: ScriptType.json,
                      child: Text(ScriptType.json.name),
                    ),
                    FormBuilderFieldOption(
                      value: ScriptType.dart,
                      child: Text(ScriptType.dart.name),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Palette.surfaceVariant,
            foregroundColor: Palette.onSurfaceVariant
          ),
          onPressed: AppNavigator.pop,
          child: const Text(Strings.cancel).tr()
        ),
        FilledButton(
          onPressed: _create, 
          child: const Text(Strings.create,).tr()
        )
      ],
    );
  }
}