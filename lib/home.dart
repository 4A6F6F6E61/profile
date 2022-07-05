// ignore_for_file: no_logic_in_create_state

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interface_brightness.dart';
import 'window_title_bar.dart';
import 'browser_item.dart';
import "main.dart" as main;
import 'dart:io';

class MyHomePage extends StatefulWidget {
  final int orientation;
  final bool darkMode;
  const MyHomePage(
      {Key? key, required this.orientation, required this.darkMode})
      : super(key: key);

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(orientation: orientation, darkMode: darkMode);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({required this.orientation, required this.darkMode});
  final int orientation;
  final bool darkMode;
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
    if (orientation == main.Orientation.VERTICAL) {
      appWindow.size = Size(double.parse(dimensions!.first),
          (double.parse(dimensions!.last) - 32) / 3 * 1 + 32);
      if (items.isNotEmpty) {
        appWindow.size = Size(double.parse(dimensions!.first),
            (double.parse(dimensions!.last) - 32) / 3 * items.length + 32);
      }
    } else {
      appWindow.size = Size((double.parse(dimensions!.last)) / 3 * 1 + 32,
          double.parse(dimensions!.first));
      if (items.isNotEmpty) {
        appWindow.size = Size(
            (double.parse(dimensions!.last)) / 3 * items.length + 32,
            double.parse(dimensions!.first));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orientation == main.Orientation.VERTICAL) {
      return Column(
        children: [
          WindowTitleBar(
            brightness: brightness,
            darkMode: darkMode,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          WindowTitleBar(
            brightness: brightness,
            darkMode: darkMode,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        ],
      );
    }
  }

  void openBrowser(String exe, List<String> args) async {
    await Process.start(exe, args);
    exit(0);
  }
}
