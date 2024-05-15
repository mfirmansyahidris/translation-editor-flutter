import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryContainer,
      body: Center(
        child: Text(
          Strings.appName,
          style: TextStyles.titleLarge?.copyWith(
            color: Palette.onPrimaryContainer
          ),
        ),
      ),
    );
  }
}