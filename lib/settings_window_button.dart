import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class SettingsWindowButton extends WindowButton {
  SettingsWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? false,
          iconBuilder: (buttonContext) => Icon(
            FluentIcons.settings,
            color: buttonContext.iconColor,
            size: 13,
          ),
          onPressed: onPressed ?? settingsButtonOnPressed,
        );
}

void settingsButtonOnPressed() {
  //appWindow.maximizeOrRestore();
  if (appWindow.size == const Size(600, 170)) {
    appWindow.size = const Size(700, 500);
  } else {
    appWindow.size = const Size(600, 170);
  }
}
