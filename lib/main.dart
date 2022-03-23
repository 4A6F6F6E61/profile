import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'settings.dart';
import 'dart:io';

AccentColor? accentColor;

Future<void> main() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? dimensions;
  WidgetsFlutterBinding.ensureInitialized();
  accentColor = await getColor();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.aero,
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

  runApp(const MyApp());
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      appWindow
        ..size =
            Size(double.parse(dimensions!.first), double.parse(dimensions.last))
        ..alignment = Alignment.centerRight
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Profile Switcher',
      theme: ThemeData(
        accentColor: accentColor,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/settings': (context) => const SettingsNav(),
      },
    );
  }
}
