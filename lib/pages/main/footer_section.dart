import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.primaryContainer,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.spaceDefault, vertical: Dimens.spaceS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilledButton.icon(
            icon: Icon(
              Icons.settings,
              color: Palette.onSecondary,
            ),
            onPressed: () {},
            label: const Text(
              Strings.setup,
            ).tr(),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Palette.secondary,
              foregroundColor: Palette.onSecondary,
            ),
            icon: const Text(
              Strings.apply,
            ).tr(),
            onPressed: () {},
            label: Icon(
              Icons.fast_forward,
              color: Palette.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
