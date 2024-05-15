import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';
import 'package:msq_translation_editor/widgets/windowed_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      AppNavigator.goToPageReplace(AppRoutes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowedScaffold(
      backgroundColor: Palette.primaryContainer,
      windowActionButtons: const [
        WindowActionButton.close
      ],
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