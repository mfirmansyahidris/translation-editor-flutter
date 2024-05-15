// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

export 'locales.dart';
export 'strings.dart';
export 'themes.dart';

final TextStyles = Theme.of(AppNavigator.navigatorKey.currentContext!).textTheme;
final Palette = Theme.of(AppNavigator.navigatorKey.currentContext!).colorScheme;