import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class DetailDialog extends StatefulWidget {
  final bool isEdit;
  final String? keyword;
  final Map<String, String>? translation; 
  const DetailDialog({super.key, this.keyword, this.translation, this.isEdit = false});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {

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