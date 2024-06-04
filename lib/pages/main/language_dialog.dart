import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  final Set<Language> _currentLanguage = {};

  late TranslationBloc _translationBloc;

  @override
  void initState() {
    super.initState();
    _translationBloc = context.read();
    
    for(final key in _translationBloc.translation.languages.keys){
      try{
        final language = Di.languages.firstWhere((e) => e.twoLetter == key);
        _currentLanguage.add(language);
      }catch(e){
        debugPrint(e.toString());
      }
    }
  }

  void _applyChanges(){
    _translationBloc.syncLanguageSet(_currentLanguage.map((e) => e.twoLetter).toSet());
    AppNavigator.pop();
  }

  void _removeConfirmation(Language e){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text(
          Strings.thisActionCannotUndone
        ).tr(),
        content: const Text(
          Strings.thisActionCannotUndoneDesc
        ).tr(),
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
            onPressed: (){
              setState(() {
                _currentLanguage.remove(e);
              });
              _formKey.currentState?.fields[Strings.languages]?.didChange(_currentLanguage.toList());
              AppNavigator.pop();
            }, 
            child: const Text(Strings.delete,).tr()
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.languages).tr(),
      content: SizedBox(
        width: Dimens.widthInPercent(50),
        child: FormBuilder(
          key: _formKey,
          onChanged: (){
            _currentLanguage.clear();
            setState(() {
              _currentLanguage.addAll(_formKey.currentState?.fields[Strings.languages]?.value);
            });
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusS),
                    border: Border.all(color: Palette.outlineVariant)
                  ),
                  height: 200,
                  child: FormBuilderCheckboxGroup<Language>(
                    name: Strings.languages,
                    validator: (languages){
                      if((languages ?? []).isEmpty){
                        return Strings.fieldIsRequired(Strings.languages.tr());
                      }
                      return null;
                    },
                    initialValue: _currentLanguage.toList(),
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
                if(_currentLanguage.isNotEmpty) SpacerV.XXS,
                if(_currentLanguage.isNotEmpty) Wrap(
                  spacing: Dimens.spaceDefault,
                  children: [
                    ... _currentLanguage.map((e) => TextButton(
                      onPressed: (){
                        _removeConfirmation(e);
                      },
                      child: Text(
                        "${e.language}(${e.twoLetter})",
                        style: TextStyles.bodyMedium?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )).toList()
                  ],
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
          onPressed: _applyChanges, 
          child: const Text(Strings.ok,).tr()
        )
      ],
    );
  }
}