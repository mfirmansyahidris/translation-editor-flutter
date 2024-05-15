import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  late FlutterSecureStorage storage;

  LocalStorage(){
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  static const _keyTheme = "theme";

  Future<Brightness?> getTheme() async {
    final data = await storage.read(key: _keyTheme);
    if(data == "dark"){
      return Brightness.dark;
    }else if(data == "light"){
      return Brightness.light;
    }
    return null;
  }

  Future<void> setTheme(Brightness brightness) async {
    String data = "";
    if(brightness == Brightness.dark){
      data = "dark";
    }else{
      data = "light";
    }
    await storage.write(key: _keyTheme, value: data);
  } 
}
