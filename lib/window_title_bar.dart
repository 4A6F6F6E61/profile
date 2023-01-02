import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'interface_brightness.dart';
import 'settings_window_button.dart';
import 'dart:io';

class WindowTitleBar extends StatelessWidget {
  final InterfaceBrightness brightness;
  final bool darkMode;
  const WindowTitleBar(
      {Key? key, required this.brightness, required this.darkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Platform.isWindows ?
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 32.0,
      color: Colors.transparent,
      child: MoveWindow(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            MinimizeWindowButton(
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.transparent,
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.white.withOpacity(0.04),
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
            SettingsWindowButton(
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.transparent,
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.white.withOpacity(0.04),
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) {
                  if (route.settings.name == "/") {
                    Navigator.of(context).pushNamed("/settings");
                  } else if (route.settings.name == "/settings") {
                    Navigator.of(context).pushNamed("/");
                  }
                  return true;
                });
              },
            ),
            CloseWindowButton(
              onPressed: () {
                exit(0);
              },
              colors: WindowButtonColors(
                iconNormal: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                iconMouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black
                    : Colors.white,
                normal: Colors.transparent,
                mouseOver: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.04)
                    : Colors.white.withOpacity(0.04),
                mouseDown: brightness == InterfaceBrightness.light
                    ? Colors.black.withOpacity(0.08)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
          ],
        ),
      ),
    );
//        : Container();
  }
}

class TitleBarButtons extends StatelessWidget {
  final InterfaceBrightness brightness;
  const TitleBarButtons({Key? key, required this.brightness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Platform.isWindows ?
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseDown: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseOver: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            normal: Colors.transparent,
            mouseOver: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.04)
                : Colors.white.withOpacity(0.04),
            mouseDown: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.08)
                : Colors.white.withOpacity(0.08),
          ),
        ),
        SettingsWindowButton(
          colors: WindowButtonColors(
            iconNormal: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseDown: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseOver: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            normal: Colors.transparent,
            mouseOver: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.04)
                : Colors.white.withOpacity(0.04),
            mouseDown: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.08)
                : Colors.white.withOpacity(0.08),
          ),
          onPressed: () {
            Navigator.popUntil(context, (route) {
              if (route.settings.name == "/") {
                Navigator.of(context).pushNamed("/settings");
              } else if (route.settings.name == "/settings") {
                Navigator.of(context).pushNamed("/");
              }
              return true;
            });
          },
        ),
        CloseWindowButton(
          onPressed: () {
            exit(0);
          },
          colors: WindowButtonColors(
            iconNormal: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseDown: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            iconMouseOver: brightness == InterfaceBrightness.light
                ? Colors.black
                : Colors.white,
            normal: Colors.transparent,
            mouseOver: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.04)
                : Colors.white.withOpacity(0.04),
            mouseDown: brightness == InterfaceBrightness.light
                ? Colors.black.withOpacity(0.08)
                : Colors.white.withOpacity(0.08),
          ),
        ),
      ],
    );
//        : Container();
  }
}
