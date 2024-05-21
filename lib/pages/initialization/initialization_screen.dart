import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {

  void _createNew() { 
    FilePicker.platform.getDirectoryPath().then((path) => {
      if(path != null){
        showDialog(
          context: context, 
          barrierDismissible: false,
          builder: (context) => NewDialog(
            initialPath: path
          )
        )
      }
    });
  }

  void _open(){
    FilePicker.platform.getDirectoryPath().then((path){
      if(path != null){
        final files = Di.translation.openLanguageFile(path);
        if(files.isEmpty){
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              icon: Icon(Icons.error, color: Palette.error,),
              title: const Text(Strings.cannotFindLanguageFile).tr(),
              content: const Text(Strings.pleaseSelectLanguageDirectory).tr(),
              actions: [
                FilledButton(
                  onPressed: AppNavigator.pop, 
                  child: const Text(Strings.ok).tr()
                )
              ],
            )
          );
        }else{
          AppNavigator.goToPageReplace(AppRoutes.main, arguments: {
            'path': path
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(600, 450);
      win.size = const Size(980, 640);
      win.alignment = Alignment.center;
      win.title = Strings.appName;
      win.show();
      setState(() {
        
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WindowedScaffold(
      toolbarColor: Palette.primary,
      toolbarTextColor: Palette.onPrimary,
      windowTitle: Strings.appName,
      body: Row(
        children: [
          Container(
            width: 200,
            color: Palette.primaryContainer,
            height: double.infinity,
            padding: const EdgeInsets.all(Dimens.spaceDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: _createNew, 
                  child: const Text(
                    Strings.new1,
                  ).tr()
                ),
                SpacerV.S,
                OutlinedButton(
                  onPressed: _open, 
                  child: const Text(
                    Strings.open,
                  ).tr()
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpacerV.M,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spaceDefault),
                  child: Text(
                    Strings.recent,
                    style: TextStyles.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ).tr(),
                ),
                SpacerV.XS,
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimens.spaceDefault),
                  child: Column(
                    children: [
                      Text(
                        "E:\\OFFICE\\Project\\Nandroid\\Mufin\\MSQ_Translation_Editor\\assets\\translations",
                        style: TextStyles.bodyMedium?.copyWith(
                          color: Palette.outline
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}