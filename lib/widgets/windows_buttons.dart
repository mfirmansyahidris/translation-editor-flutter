import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

enum WindowActionButton{
  minimize, maximize, close
}

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key, this.buttons}) : super(key: key);

  final List<WindowActionButton>? buttons;

  final buttonColors = WindowButtonColors(
      iconNormal: Palette.outline,
      mouseOver: Palette.primary.withOpacity(0.5),
      mouseDown: Palette.primary
  );

  final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Palette.outline,
      iconMouseOver: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> windowButton = [];
    if(buttons != null){
      if(buttons!.contains(WindowActionButton.minimize)){
        windowButton.add(MinimizeWindowButton(colors: buttonColors));
      }
      if(buttons!.contains(WindowActionButton.maximize)){
        windowButton.add(MaximizeWindowButton(colors: buttonColors));
      }
      if(buttons!.contains(WindowActionButton.close)){
        windowButton.add(CloseWindowButton(colors: closeButtonColors));
      }
    }else{
      windowButton.addAll([
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors)
      ]);
    }
    return Row(
      children: windowButton,
    );
  }
}