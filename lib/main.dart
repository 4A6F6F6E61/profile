// ignore_for_file: constant_identifier_names

import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'settings.dart';
import 'dart:io';

AccentColor? accentColor;
bool? darkMode;
List<String>? dimensions;
Alignment? position;
int pos = Orientation.HORIZONTAL;

class Orientation {
  static const int VERTICAL = 0;
  static const int HORIZONTAL = 1;
}

Future<void> main() async {
  await loadPreferences();
  WidgetsFlutterBinding.ensureInitialized();
  accentColor = await getColor();
  await Window.initialize();
  WindowEffect windowEffect = Platform.isWindows ? WindowEffect.mica : WindowEffect.transparent;
  Color windowColor = darkMode!
      ? Platform.isWindows
          ? const Color(0x00000000)
          : const Color(0xCC222222)
      : const Color(0xCCDDDDDD);
  await Window.setEffect(
    effect: windowEffect,
    color: windowColor,
  );
  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }
  runApp(const MyApp());
  if (pos == Orientation.VERTICAL) {
    var s = await getDimensionsV();
    doWhenWindowReady(() {
      appWindow
        ..minSize = s
        ..alignment = position
        ..show();
    });
  } else if (pos == Orientation.HORIZONTAL) {
    var s = await getDimensionsH();
    doWhenWindowReady(() {
      appWindow
        ..minSize = s
        ..size = Size(
          double.parse(dimensions!.last) * 1.2,
          double.parse(dimensions!.first) * 1.2,
        )
        ..alignment = position
        ..show();
    });
  }
}

Future<void> loadPreferences() async {
  /* 
   *  Load Preferences Instance
   */
  final prefs = await SharedPreferences.getInstance();
  /* 
   *  Get Dimensions
   */
  if (!prefs.containsKey('dimensions')) {
    dimensions = ["140", "450"];
    prefs.setStringList('dimensions', dimensions!);
  } else {
    dimensions = prefs.getStringList('dimensions');
  }
  /* 
   *  Get Orientation
   */
  if (!prefs.containsKey('orientation')) {
    prefs.setInt('orientation', Orientation.VERTICAL);
  } else {
    pos = prefs.getInt('orientation')!;
  }

  /* 
   *  Get Position
   */
  if (!prefs.containsKey('position')) {
    prefs.setStringList('position', ["0.0", "1.0"]);
  } else {
    var p = prefs.getStringList('position');
    position = Alignment(double.parse(p![0]), double.parse(p[1]));
  }
  /*
   *  Set Accent Color
   */
  if (!prefs.containsKey('color')) {
    prefs.setString('color', "Blue");
  }
  /* 
   *  Set Dark Mode
   */
  if (!prefs.containsKey('darkMode')) {
    prefs.setBool('darkMode', true);
    darkMode = true;
  } else {
    darkMode = prefs.getBool('darkMode')!;
  }
}

Future<AccentColor> getColor() async {
  final prefs = await SharedPreferences.getInstance();
  String color = prefs.getString('color') ?? "Blue";
  switch (color.toLowerCase()) {
    case "red":
      return Colors.red;
    case "orange":
      return Colors.orange;
    case "yellow":
      return Colors.yellow;
    case "green":
      return Colors.green;
    case "teal":
      return Colors.teal;
    case "blue":
      return Colors.blue;
    case "purple":
      return Colors.purple;
    default:
      return Colors.blue;
  }
}

Future<Size> getDimensionsV() async {
  List<String>? dimensions;
  Size tempSize;
  final prefs = await SharedPreferences.getInstance();
  dimensions = prefs.getStringList('dimensions');
  tempSize =
      Size(double.parse(dimensions!.first), (double.parse(dimensions.last) - 32) / 3 * 1 + 32);
  if (prefs.containsKey("browserProfiles")) {
    tempSize = Size(
        double.parse(dimensions.first),
        (double.parse(dimensions.last) - 32) / 3 * prefs.getStringList("browserProfiles")!.length +
            32);
  }
  return tempSize;
}

Future<Size> getDimensionsH() async {
  List<String>? dimensions;
  Size tempSize;
  final prefs = await SharedPreferences.getInstance();
  dimensions = prefs.getStringList('dimensions');
  tempSize = Size(
    double.parse(dimensions!.last) * 1.2,
    double.parse(dimensions.first) * 1.2,
  );
  if (prefs.containsKey("browserProfiles")) {
    tempSize = Size(
        double.parse(dimensions.last) * 1.2 / 3 * prefs.getStringList("browserProfiles")!.length,
        double.parse(dimensions.first) + 32);
  }
  return tempSize;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Profile Switcher',
      theme: FluentThemeData(
        accentColor: accentColor,
        brightness: darkMode! ? Brightness.dark : Brightness.light,
      ),
      routes: {
        '/': (context) => MyHomePage(orientation: pos, darkMode: darkMode!),
        '/settings': (context) => SettingsNav(darkMode: darkMode!),
      },
    );
  }
}
