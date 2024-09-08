// ignore_for_file: no_logic_in_create_state

import 'dart:developer';

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
  const MyHomePage({Key? key, required this.orientation, required this.darkMode}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState(orientation: orientation, darkMode: darkMode);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({required this.orientation, required this.darkMode});
  final int orientation;
  final bool darkMode;
  InterfaceBrightness brightness =
      Platform.isMacOS ? InterfaceBrightness.auto : InterfaceBrightness.dark;
  List<String>? dimensions;

  Map<String, BrowserItem> items = {};

  List<Widget> widgetItems = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final browserProfiles = prefs.getStringList('browserProfiles') ?? [];

    if (browserProfiles.isNotEmpty) {
      for (String browserProfile in browserProfiles) {
        var profileStringList = prefs.getStringList(browserProfile)!;

        items[browserProfile] = BrowserItem.fromStringList(profileStringList);
      }
    }

    if (items.isNotEmpty) {
      items.forEach((id, item) {
        widgetItems.add(generateBrowserItem(id, item));
      });
    }
    await setDimensions();
  }

  BrowserItemWidget generateBrowserItem(String id, BrowserItem item) {
    IconData icon = FluentIcons.cat;
    switch (item.iconString) {
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
    return BrowserItemWidget(
      key: Key(id),
      icon: Icon(
        icon,
        size: double.parse(item.iconSize),
        color: Colors.white,
      ),
      onPressed: () => openBrowser(
        item.browserBinLoc,
        [item.arg1, item.arg2],
      ),
      onRemove: () => removeItem(id),
      text: item.profileName,
      fontSize: 16,
      textColor: Colors.white,
    );
  }

  Future<void> removeItem(String id) async {
    final delete = await showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Are you sure you want to remove this profile?"),
        content: const Text(
          "This action cannot be undone. You will have to re-add the profile manually.",
        ),
        actions: [
          Button(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          Button(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (delete == null || !delete) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final browserProfiles = prefs.getStringList('browserProfiles') ?? [];
    browserProfiles.remove(id);
    prefs.setStringList('browserProfiles', browserProfiles);

    prefs.remove(id);
    items.remove(id);

    widgetItems.removeWhere((element) => element.key == Key(id));
    await setDimensions();
  }

  Future<void> setDimensions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dimensions = prefs.getStringList('dimensions');
    });
    if (orientation == main.Orientation.VERTICAL) {
      appWindow.size = await main.getDimensionsV();
    } else {
      appWindow.size = await main.getDimensionsH();
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
            children: widgetItems,
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
            children: widgetItems,
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
