import 'dart:convert';

import 'package:flutter/services.dart';

class Language{
  late String country;
  late String language;
  late String twoLetter;
  late String threeLetter;
  late int lcid;

  Language({
    required this.country,
    required this.language,
    required this.twoLetter,
    required this.threeLetter,
    required this.lcid
  });

  Language.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    language = json['language'];
    twoLetter = json['two_letter'];
    threeLetter = json['three_letter'];
    lcid = json['lcid'];
  }
}

Future<List<Language>> getLanguages() async {
  String data = await rootBundle.loadString('assets/countries/languages.json');
  final jsonResult = json.decode(data);

  final List<Language> languages = [];
  jsonResult.forEach((lang){
    languages.add(Language.fromJson(lang));
  });
  return languages;
}