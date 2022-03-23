import 'package:fluent_ui/fluent_ui.dart';
import 'package:profile/interface_brightness.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'window_title_bar.dart';
import 'settings/general.dart';
import 'settings/add_profile.dart';

class SettingsNav extends StatefulWidget {
  const SettingsNav({Key? key}) : super(key: key);

  @override
  State<SettingsNav> createState() => _SettingsNavState();
}

class _SettingsNavState extends State<SettingsNav> {
  List<String> values = const ['Blue', 'Green', 'Yellow', 'Red'];
  String? comboBoxValue;
  bool value = false;
  int index = 0;

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
    return NavigationView(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Spacer(),
              TitleBarButtons(brightness: InterfaceBrightness.dark)
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
            icon: const Icon(FluentIcons.checkbox_composite),
            title: const Text('General'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.checkbox_composite),
            title: const Text('Add Browser Profile'),
          ),
        ],
      ),
      content: NavigationBody(index: index, children: const [
        SettingsGeneral(),
        SettingsAddProfile(),
      ]),
    );
  }
}
