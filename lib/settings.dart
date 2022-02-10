import 'package:flutter/cupertino.dart';
import 'package:profile/interface_brightness.dart';
import 'window_title_bar.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    change();
    print("test");
  }

  void change() {
    appWindow.size = const Size(700, 500);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        WindowTitleBar(
          brightness: InterfaceBrightness.auto,
        ),
        Text("Settings")
      ],
    );
  }
}
