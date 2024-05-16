import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spaceDefault),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text(Strings.add).tr(),
          ),
          const Spacer(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Palette.outlineVariant)),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spaceDefault,
                  vertical: Dimens.spaceXXS + 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: Dimens.iconL,
                    color: Palette.outline,
                  ),
                  SpacerH.XS,
                  Expanded(
                    child: FormBuilderTextField(
                      name: Strings.search,
                      style: TextStyles.bodyMedium,
                      decoration: InputDecoration.collapsed(
                        hintText: Strings.search.tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
