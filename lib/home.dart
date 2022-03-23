import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<String>? dimensions;

  @override
  void initState() {
    super.initState();
    setDimensions();
  }

  Future<void> setDimensions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dimensions = prefs.getStringList('dimensions');
    });
    appWindow.size =
        Size(double.parse(dimensions!.first), double.parse(dimensions!.last));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBar(
          brightness: brightness,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BrowserItem(
              icon: const Icon(
                FluentIcons.cat,
                size: 80,
                color: Colors.white,
              ),
              onPressed: () => openBrowser(
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
              onPressed: () => openBrowser(
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
              onPressed: () => openBrowser(
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

  void openBrowser(String exe, List<String> args) async {
    await Process.start(exe, args);
    exit(0);
  }
}
