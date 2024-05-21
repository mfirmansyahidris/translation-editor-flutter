import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:translator_plus/translator_plus.dart';

class DetailDialog extends StatefulWidget {
  final bool isEdit;
  final String? keyword;
  final Map<String, String>? translation; 
  const DetailDialog({super.key, this.keyword, this.translation, this.isEdit = false});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {

  final _formkey = GlobalKey<FormBuilderState>();

  Future<void> _translate() async {
    _formkey.currentState?.save();
    String defaultLanguage = "";
    String defaultText = "";
    final values = _formkey.currentState?.value;
    if((values?['en-US'] ?? '').isNotEmpty){
      defaultText = values?['en-US'];
      defaultLanguage = 'en';
    }else{
      for(final String key in (values?.keys ?? [])){
        if(key == Strings.key) continue;
        if((values?[key] ?? '').isNotEmpty){
          defaultText = values?[key];
          defaultLanguage = key;
          break;
        }
      }
    }

    final translator = GoogleTranslator();
    for(final String key in (values?.keys ?? [])){
      if(key == Strings.key) continue;
      if((values?[key] ?? '').isNotEmpty) continue;
      final translate = await translator.translate(defaultText, from: defaultLanguage, to: key.split('-').first);
      _formkey.currentState?.fields[key]?.didChange(translate.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: Dimens.widthInPercent(50),
        child: FormBuilder(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpacerV.M,
                FormBuilderTextField(
                  name: Strings.key,
                  readOnly: widget.isEdit,
                  initialValue: widget.keyword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(Strings.key.tr()),
                  ),
                ),
                if((widget.translation ?? {}).isNotEmpty)... widget.translation!.keys.map((e) => Padding(
                  padding: const EdgeInsets.only(top: Dimens.spaceDefault),
                  child: FormBuilderTextField(
                    name: e,
                    initialValue: widget.translation![e],
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text(e),
                    ),
                  ),
                )).toList(),
                SpacerV.M,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Palette.errorContainer,
                    border: Border.all(color: Palette.error),
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusS)
                  ),
                  padding: const EdgeInsets.all(Dimens.spaceXS),
                  child: Text(
                    "Please fill at least one language to start to generate the translation",
                    style: TextStyle(
                      color: Palette.onErrorContainer
                    ),
                  ),
                ),
                SpacerV.M,
                const Divider(),
                SpacerV.M,
                Row(
                  children: [
                    TextButton(
                      onPressed: _translate, 
                      child: const Text(Strings.autoGenerate,).tr()
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: AppNavigator.pop, 
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