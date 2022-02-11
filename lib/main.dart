import 'package:fluent_ui/fluent_ui.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'home.dart';
import 'settings.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.aero,
    color: const Color(0xCC222222),
  );
  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }
  runApp(const MyApp());
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      appWindow
        ..size = const Size(600, 170)
        ..alignment = Alignment.bottomCenter
        ..show();
    });
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
        accentColor: Colors.red,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/settings': (context) => const SettingsNav(),
      },
    );
  }
}
