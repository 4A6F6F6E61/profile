// ignore_for_file: no_logic_in_create_state

import 'package:fluent_ui/fluent_ui.dart';
import 'package:browser_manager/interface_brightness.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'window_title_bar.dart';
import 'settings/general.dart';
import 'settings/add_profile.dart';
import 'settings/licenses.dart';
import 'settings/about.dart';

class SettingsNav extends StatefulWidget {
  final bool darkMode;
  const SettingsNav({Key? key, required this.darkMode}) : super(key: key);

  @override
  State<SettingsNav> createState() => _SettingsNavState(darkMode: darkMode);
}

class _SettingsNavState extends State<SettingsNav> {
  List<String> values = const ['Blue', 'Green', 'Yellow', 'Red'];
  String? comboBoxValue;
  bool value = false;
  int index = 0;
  final bool darkMode;

  @override
  _SettingsNavState({required this.darkMode});
  @override
  void initState() {
    super.initState();
    change();
  }

  void change() {
    appWindow.size = const Size(850, 600);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool _) {
        Navigator.popUntil(context, (route) {
          if (route.settings.name == "/settings") {
            Navigator.of(context).pushNamed("/");
          }
          return true;
        });
      },
      child: NavigationView(
        appBar: NavigationAppBar(
          backgroundColor: Colors.transparent,
          // height: !kIsWeb ? appWindow.titleBarHeight : 31.0,
          title: () {
            return MoveWindow(
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Settings"),
              ),
            );
          }(),
          actions: MoveWindow(
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                TitleBarButtons(brightness: InterfaceBrightness.dark),
              ],
            ),
          ),
        ),
        pane: NavigationPane(
          selected: index,
          onChanged: (i) => setState(() => index = i),
          size: const NavigationPaneSize(
            openWidth: 250,
          ),
          header: Container(
            height: kOneLineTileHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 100,
            ),
          ),
          displayMode: PaneDisplayMode.open,
          items: [
            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('General'),
              body: SettingsGeneral(darkMode: darkMode),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.add),
              title: const Text('Add Browser Profile'),
              body: SettingsAddProfile(darkMode: darkMode),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.library),
              title: const Text('Licenses'),
              body: SettingsLicenses(darkMode: darkMode),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.info),
              title: const Text('About'),
              body: const SettingsAbout(),
            ),
          ],
        ),
      ),
    );
  }
}
