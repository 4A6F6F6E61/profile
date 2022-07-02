import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart' as m;

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({Key? key}) : super(key: key);

  @override
  State<SettingsGeneral> createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  List<String> colorList = const [
    "red",
    "orange",
    "yellow",
    "green",
    "teal",
    "blue",
    "purple"
  ];
  String? colorListValue;
  String? settingsColor = '...';

  List<String> positionXList = const ["left", "center", "right"];
  String? positionXValue;
  String? settingsPositionX = 'X...';

  List<String> positionYList = const ["top", "center", "bottom"];
  String? positionYValue;
  String? settingsPositionY = 'Y...';

  List<String> orientationList = const ["Vertical", "Horizontal"];
  String? orientationValue;
  String? settingsOriantation = '...';

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      settingsColor = prefs.getString('color');
      settingsPositionX = prefs.getString('position')![0];
      settingsPositionY = prefs.getString('position')![1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 32, 32, 32),
      child: ScaffoldPage.scrollable(
        children: [
          Card(
            backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Change the accent color"),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      placeholder: Text(settingsColor ?? 'Loading...'),
                      items: colorList
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: colorListValue,
                      onChanged: (value) async {
                        // print(value);
                        if (value != null) {
                          setState(() => colorListValue = value);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('color', value);
                          setState(
                              () => settingsColor = prefs.getString('color'));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Card(
            backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Change the position"),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      placeholder: Text(settingsPositionX ?? 'Loading...'),
                      items: positionXList
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: positionXValue,
                      onChanged: (value) async {
                        // print(value);
                        if (value != null) {
                          setState(() => positionXValue = value);
                          final prefs = await SharedPreferences.getInstance();
                          var pos = prefs.getStringList('position');
                          switch (value) {
                            case "left":
                              pos![0] = "-1.0";
                              break;
                            case "center":
                              pos![0] = "0.0";
                              break;
                            case "right":
                              pos![0] = "1.0";
                              break;
                          }
                          prefs.setStringList('position', pos!);
                          setState(() => settingsPositionX = value);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      placeholder: Text(settingsPositionY ?? 'Loading...'),
                      items: positionYList
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: positionYValue,
                      onChanged: (value) async {
                        // print(value);
                        if (value != null) {
                          setState(() => positionYValue = value);
                          final prefs = await SharedPreferences.getInstance();
                          var pos = prefs.getStringList('position');
                          switch (value) {
                            case "top":
                              pos![1] = "-1.0";
                              break;
                            case "center":
                              pos![1] = "0.0";
                              break;
                            case "bottom":
                              pos![1] = "1.0";
                              break;
                          }
                          prefs.setStringList('position', pos!);
                          setState(() => settingsPositionY = value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Card(
            backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Change the orientation"),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      placeholder: Text(settingsOriantation ?? 'Loading...'),
                      items: orientationList
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: orientationValue,
                      onChanged: (value) async {
                        // print(value);
                        if (value != null) {
                          setState(() => orientationValue = value);
                          final prefs = await SharedPreferences.getInstance();
                          switch (value) {
                            case "Vertical":
                              prefs.setInt(
                                  'orientation', m.Orientation.VERTICAL);
                              break;
                            case "Horizontal":
                              prefs.setInt(
                                  'orientation', m.Orientation.HORIZONTAL);
                              break;
                          }
                          setState(() => settingsOriantation = value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
