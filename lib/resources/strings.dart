import 'package:easy_localization/easy_localization.dart';

class Strings {
  static const String appName = "MSQ Translation Editor";
  static const String add = 'add';
  static const String search = 'search';
  static const String keys = 'keys';
  static const String setup = 'setup';
  static const String apply = 'apply';
  static const String closeConfirmation = 'close_confirmation';
  static const String clear = 'clear';
  static const String key = 'key';
  static String fieldIsRequired(fieldName) => 'field_is_required'.tr(args: [fieldName]);
  static const String cancel = 'cancel';
  static const String close = 'close';
  static const String delete = 'delete';
  static const String view = 'view';
  static const String autoGenerate = "auto_generate";
  static const String recent = 'recent';
  static const String new1 = 'new';
  static const String open = 'Open';
  static const String directory = "directory";
  static const String languages = "languages";
  static const String create = "create";
  static const String cannotFindLanguageFile = "cannot_find_language_files";
  static const String pleaseSelectLanguageDirectory = "please_select_directory_of_language_files";
  static const String ok = "ok";
  static const String edit = "edit";
  static const String pleaseFillAtleastOneLangage = "please_fill_atleast_one_language";
}