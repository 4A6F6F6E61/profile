import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'interface_brightness.dart';
import 'window_title_bar.dart';
import 'browser_item.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InterfaceBrightness brightness =
      Platform.isMacOS ? InterfaceBrightness.auto : InterfaceBrightness.dark;

  @override
  void initState() {
    super.initState();
    appWindow.size = const Size(600, 170);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBar(
          brightness: brightness,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BrowserItem(
              icon: const Icon(
                FluentIcons.cat,
                size: 80,
                color: Colors.white,
              ),
              onPressed: () => openFirefox(
                "C:/Program Files/Mozilla Firefox/firefox.exe",
                ["-p", "Entertainment"],
              ),
              text: "Entertainment",
              fontSize: 16,
              textColor: Colors.white,
            ),
            BrowserItem(
              icon: const Icon(
                FluentIcons.authenticator_app,
                size: 80,
                color: Colors.white,
              ),
              onPressed: () => openFirefox(
                "C:/Program Files/Mozilla Firefox/firefox.exe",
                ["-p", "Homework"],
              ),
              text: "Homework",
              fontSize: 16,
              textColor: Colors.white,
            ),
            BrowserItem(
              icon: const Icon(
                FluentIcons.developer_tools,
                size: 80,
                color: Colors.white,
              ),
              onPressed: () => openFirefox(
                "C:/Program Files/Firefox Developer Edition/firefox.exe",
                ["-p", "dev-edition-default"],
              ),
              text: "Dev",
              fontSize: 16,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  void openFirefox(String exe, List<String> args) async {
    await Process.start(exe, args);
    exit(0);
  }
}
