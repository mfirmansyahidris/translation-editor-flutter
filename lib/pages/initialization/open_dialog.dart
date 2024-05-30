import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class OpenDialog extends StatefulWidget {

  const OpenDialog({super.key});

  @override
  State<OpenDialog> createState() => _OpenDialogState();
}

class _OpenDialogState extends State<OpenDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _open() async {
    if(_formKey.currentState?.saveAndValidate() ?? false){

      final selectedType = _formKey.currentState?.value[Strings.scriptType];
      FilePicker.platform.getDirectoryPath().then((path){
        if(path != null){
          final files = FileManager.openLanguageFile(directoryPath: path, type: selectedType);
          if(files.isEmpty){
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                icon: Icon(Icons.error, color: Palette.error,),
                title: const Text(Strings.cannotFindLanguageFile).tr(),
                content: const Text(Strings.pleaseSelectLanguageDirectory).tr(),
                actions: [
                  FilledButton(
                    onPressed: AppNavigator.pop, 
                    child: const Text(Strings.ok).tr()
                  )
                ],
              )
            );
          }else{
            AppNavigator.goToPageReplace(AppRoutes.main, arguments: {
              'path': path,
              'type': selectedType,
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.open).tr(),
      content: SizedBox(
        width: Dimens.widthInPercent(50),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SpacerV.M,
              Text(
                Strings.scriptType,
                style: TextStyles.titleMedium,
              ).tr(),
              SpacerV.XXS,
              FormBuilderRadioGroup<ScriptType>(
                name: Strings.scriptType, 
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
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
          onPressed: _open, 
          child: const Text(Strings.open,).tr()
        )
      ],
    );
  }
}