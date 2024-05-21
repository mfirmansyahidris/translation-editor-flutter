import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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

  bool _isTranslating = false;
  bool _translatingError = false;

  final _formkey = GlobalKey<FormBuilderState>();
  

  Future<void> _translate() async {
    setState(() {
      _translatingError = false;
    });

    _formkey.currentState?.save();
    final defaults = _getDefaultLanguage();
    String defaultLanguage = defaults[0];
    String defaultText = defaults[1];
    final values = _formkey.currentState?.value;

    if(defaultText.isEmpty){
      setState(() {
        _translatingError = true;
      });
      return;  
    }
  
    setState(() {
      _isTranslating = true;
    });

    final translator = GoogleTranslator();
    for(final String key in (values?.keys ?? [])){
      if(key == Strings.key) continue;
      if((values?[key] ?? '').isNotEmpty) continue;
      final translate = await translator.translate(defaultText, from: defaultLanguage, to: key.split('-').first);
      _formkey.currentState?.fields[key]?.didChange(translate.text);
    }

    setState(() {
      _isTranslating = false;
    });
  }

  List<String> _getDefaultLanguage(){
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
    return [defaultLanguage, defaultText];
  }

  void _add(){
    setState(() {
      _translatingError = false;
    });

    if(_formkey.currentState?.saveAndValidate() ?? false){
      final defaults = _getDefaultLanguage();
      if(defaults[1].isEmpty){
        setState(() {
          _translatingError = true;
        });
        return;
      }

      final values = _formkey.currentState?.value;

      final keywords = values?[Strings.key];
      for(final String key in (values?.keys ?? [])){
        if(key == Strings.key) continue;
        Di.translation.languages[key]?.addAll({
          keywords: values?[key]
        });
      }

      AppNavigator.pop(true);
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
                  validator: FormBuilderValidators.required(
                    errorText: Strings.fieldIsRequired(Strings.key.tr())
                  ),
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
                if(_translatingError) SpacerV.M,
                if(_translatingError) Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Palette.errorContainer,
                    border: Border.all(color: Palette.error),
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusS)
                  ),
                  padding: const EdgeInsets.all(Dimens.spaceXS),
                  child: Text(
                    Strings.pleaseFillAtleastOneLangage,
                    style: TextStyle(
                      color: Palette.onErrorContainer
                    ),
                  ).tr(),
                ),
                SpacerV.M,
                const Divider(),
                SpacerV.M,
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: _isTranslating,
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          child: const SizedBox(
                            height: Dimens.iconL,
                            width: Dimens.iconL,
                            child: CircularProgressIndicator(),
                          )
                        ),
                        Visibility(
                          visible: !_isTranslating,
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          child: TextButton(
                            onPressed: _translate, 
                            child: const Text(Strings.autoGenerate,).tr()
                          ),
                        ),
                      ],
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
                      onPressed: _add, 
                      child: Text(widget.isEdit ? Strings.edit : Strings.add,).tr()
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