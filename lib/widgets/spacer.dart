// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class SpacerV{
  static Widget get XL => const SizedBox(
    height: Dimens.spaceXL,
  );

  static Widget get L => const SizedBox(
    height: Dimens.spaceL,
  );

  static Widget get M => const SizedBox(
    height: Dimens.spaceDefault,
  );

  static Widget get S => const SizedBox(
    height: Dimens.spaceS,
  );

  static Widget get XS => const SizedBox(
    height: Dimens.spaceXS,
  );

  static Widget get XXS => const SizedBox(
    height: Dimens.spaceXXS,
  );

  static Widget get XXXS => const SizedBox(
    height: Dimens.spaceXXXS,
  );
}

class SpacerH{
  static Widget get XL => const SizedBox(
    width: Dimens.spaceXL,
  );

  static Widget get L => const SizedBox(
    width: Dimens.spaceL,
  );

  static Widget get M => const SizedBox(
    width: Dimens.spaceDefault,
  );

  static Widget get S => const SizedBox(
    width: Dimens.spaceS,
  );

  static Widget get XS => const SizedBox(
    width: Dimens.spaceXS,
  );

  static Widget get XXS => const SizedBox(
    width: Dimens.spaceXXS,
  );

  static Widget get XXXS => const SizedBox(
    width: Dimens.spaceXXXS,
  );
}
