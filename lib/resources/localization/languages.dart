part 'en_US.dart';
part 'ja_JP.dart';
part 'ko_KR.dart';
part 'zh_CH.dart';

class Languages {
  Map<String, Map<String, String>> get keys => {
        'en_US': _enUS,
        'ja_JP': _jaJP,
        'ko_KR': _koKR,
        'zh_CH': _zhCH,
  };
}
