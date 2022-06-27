import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interface_brightness.dart';
import 'window_title_bar.dart';
import 'browser_item.dart';
import 'dart:io';

class MyHomePageV extends StatefulWidget {
  const MyHomePageV({Key? key}) : super(key: key);

  @override
  State<MyHomePageV> createState() => _MyHomePageStateV();
}

class _MyHomePageStateV extends State<MyHomePageV> {
  InterfaceBrightness brightness =
      Platform.isMacOS ? InterfaceBrightness.auto : InterfaceBrightness.dark;
  List<String>? dimensions;
  List<String> browserProfiles = [];
  List<List<String>> browserItemStrings = [];
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await getBrowserStrings();
    await getBrowserItemStrings();
    if (browserItemStrings.isNotEmpty) {
      for (List<String> bis in browserItemStrings) {
        items.add(generateBrowserItem(
            bis[0], bis[1], bis[2], bis[3], bis[4], bis[5]));
      }
    }
    await setDimensions();
  }

  Future<void> getBrowserItemStrings() async {
    final prefs = await SharedPreferences.getInstance();
    if (browserProfiles.isNotEmpty) {
      for (String browserProfile in browserProfiles) {
        var profile = prefs.getStringList(browserProfile)!;
        setState(() {
          browserItemStrings.add(profile);
        });
      }
    }
  }

  BrowserItem generateBrowserItem(String iconName, String iconSize,
      String browserBinLoc, String arg1, String arg2, String text) {
    IconData icon = FluentIcons.cat;
    switch (iconName) {
      case "Cat":
        icon = FluentIcons.cat;
        break;
      case "Authenticator":
        icon = FluentIcons.authenticator_app;
        break;
      case "Dev tools":
        icon = FluentIcons.developer_tools;
        break;
      default:
        icon = FluentIcons.cat;
        break;
    }
    return BrowserItem(
      icon: Icon(
        icon,
        size: double.parse(iconSize),
        color: Colors.white,
      ),
      onPressed: () => openBrowser(
        browserBinLoc,
        [arg1, arg2],
      ),
      text: text,
      fontSize: 16,
      textColor: Colors.white,
    );
  }

  Future<void> getBrowserStrings() async {
    final prefs = await SharedPreferences.getInstance();
    browserProfiles = prefs.getStringList('browserProfiles') ?? [];
  }

  Future<void> setDimensions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dimensions = prefs.getStringList('dimensions');
    });
    appWindow.size = Size(double.parse(dimensions!.first),
        (double.parse(dimensions!.last) - 32) / 3 * 1 + 32);
    if (items.isNotEmpty) {
      appWindow.size = Size(double.parse(dimensions!.first),
          (double.parse(dimensions!.last) - 32) / 3 * items.length + 32);
    }
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
          children: items,
        ),
      ],
    );
  }

  void openBrowser(String exe, List<String> args) async {
    await Process.start(exe, args);
    exit(0);
  }
}

class MyHomePageH extends StatefulWidget {
  const MyHomePageH({Key? key}) : super(key: key);

  @override
  State<MyHomePageH> createState() => _MyHomePageStateH();
}

class _MyHomePageStateH extends State<MyHomePageH> {
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
    appWindow.size = Size(
      double.parse(dimensions!.last) * 1.2,
      double.parse(dimensions!.first) * 1.2,
    );
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
