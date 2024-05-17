import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/resources/localization/languages.dart';
import 'package:msq_translation_editor/resources/resources.dart';

class DetailDialog extends StatefulWidget {
  const DetailDialog({super.key});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  
  final _languagesSource = Languages();

  List<String> get _languages => _languagesSource.keys.keys.toList();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: Dimens.widthInPercent(50),
        child: FormBuilder(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpacerV.M,
                FormBuilderTextField(
                  name: Strings.key,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(Strings.key.tr()),
                  ),
                ),
                ... _languages.map((e) => Padding(
                  padding: const EdgeInsets.only(top: Dimens.spaceDefault),
                  child: FormBuilderTextField(
                    name: e,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text(e),
                    ),
                  ),
                )).toList(),
                SpacerV.M,
                const Divider(),
                SpacerV.M,
                Row(
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: const Text(Strings.autoGenerate,).tr()
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: (){}, 
                      style: FilledButton.styleFrom(
                        backgroundColor: Palette.surfaceVariant,
                        foregroundColor: Palette.onSurfaceVariant
                      ),
                      child: const Text(Strings.close,).tr()
                    ),
                    SpacerH.XS,
                    FilledButton(
                      onPressed: (){}, 
                      child: const Text(Strings.add,).tr()
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}