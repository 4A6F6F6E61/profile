// ignore_for_file: constant_identifier_names

import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'settings.dart';
import 'dart:io';

AccentColor? accentColor;
int pos = Orientation.HORIZONTAL;

class Orientation {
  static const int VERTICAL = 0;
  static const int HORIZONTAL = 1;
}

Future<void> main() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? dimensions;
  WidgetsFlutterBinding.ensureInitialized();
  accentColor = await getColor();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: const Color(0xCC222222),
  );
  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }
  if (prefs.containsKey('dimensions')) {
    dimensions = prefs.getStringList('dimensions');
  } else {
    dimensions = ["140", "450"];
    prefs.setStringList('dimensions', dimensions);
  }
  if (!prefs.containsKey('orientation')) {
    prefs.setInt('orientation', Orientation.VERTICAL);
  } else {
    pos = prefs.getInt('orientation')!;
  }
  if (!prefs.containsKey('browserProfiles')) {
    prefs.setStringList('browserProfiles', <String>[]);
  }

  runApp(const MyApp());
  if (Platform.isWindows && pos == Orientation.VERTICAL) {
    var s = await getDimensionsV();
    doWhenWindowReady(() {
      appWindow
        ..minSize = s
        ..alignment = Alignment.topRight
        ..show();
    });
  } else if (Platform.isWindows && pos == Orientation.HORIZONTAL) {
    var s = await getDimensionsH();
    doWhenWindowReady(() {
      appWindow
        ..minSize = s
        ..size = Size(
          double.parse(dimensions!.last) * 1.2,
          double.parse(dimensions.first) * 1.2,
        )
        ..alignment = Alignment.bottomCenter
        ..show();
    });
  }
  //prefs.setString('color', "Choose a color");
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
  tempSize = Size(double.parse(dimensions!.first),
      (double.parse(dimensions.last) - 32) / 3 * 1 + 32);
  if (prefs.containsKey("browserProfiles")) {
    tempSize = Size(
        double.parse(dimensions.first),
        (double.parse(dimensions.last) - 32) /
                3 *
                prefs.getStringList("browserProfiles")!.length +
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
        double.parse(dimensions.last) *
            1.2 /
            3 *
            prefs.getStringList("browserProfiles")!.length,
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
      theme: ThemeData(
        accentColor: accentColor,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => MyHomePage(orientation: pos),
        '/settings': (context) => const SettingsNav(),
      },
    );
  }
}
