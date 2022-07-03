// ignore_for_file: no_logic_in_create_state

import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart' as m;

class SettingsGeneral extends StatefulWidget {
  final bool darkMode;
  const SettingsGeneral({Key? key, required this.darkMode}) : super(key: key);

  @override
  State<SettingsGeneral> createState() =>
      _SettingsGeneralState(darkMode: darkMode);
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

  List<String> themeList = const ["Light", "Dark"];
  String? themeValue;
  String? settingsTheme = '...';

  final bool darkMode;

  @override
  _SettingsGeneralState({required this.darkMode});

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      colorListValue = prefs.getString('color');
      switch (prefs.getStringList('position')![1]) {
        case "-1.0":
          positionYValue = "top";
          break;
        case "0.0":
          positionYValue = "center";
          break;
        case "1.0":
          positionYValue = "bottom";
          break;
      }
      switch (prefs.getStringList('position')![0]) {
        case "-1.0":
          positionXValue = "left";
          break;
        case "0.0":
          positionXValue = "center";
          break;
        case "1.0":
          positionXValue = "right";
          break;
      }
      if (prefs.getBool('darkMode')!) {
        themeValue = "Dark";
      } else {
        themeValue = "Light";
      }
      if (prefs.getInt('orientation')! == m.Orientation.VERTICAL) {
        orientationValue = "Vertical";
      } else {
        orientationValue = "Horizontal";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 32, 32, 32),
      child: ScaffoldPage.scrollable(
        children: [
          Card(
            backgroundColor: darkMode
                ? const Color.fromARGB(255, 27, 27, 27)
                : const Color.fromARGB(255, 245, 245, 245),
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
            backgroundColor: darkMode
                ? const Color.fromARGB(255, 27, 27, 27)
                : const Color.fromARGB(255, 245, 245, 245),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Change the position"),
                ),
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
                const SizedBox(width: 10),
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
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Card(
            backgroundColor: darkMode
                ? const Color.fromARGB(255, 27, 27, 27)
                : const Color.fromARGB(255, 245, 245, 245),
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
          const SizedBox(height: 15.0),
          Card(
            backgroundColor: darkMode
                ? const Color.fromARGB(255, 27, 27, 27)
                : const Color.fromARGB(255, 245, 245, 245),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Change the theme"),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      placeholder: Text(settingsTheme ?? 'Loading...'),
                      items: themeList
                          .map((e) => ComboboxItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: themeValue,
                      onChanged: (value) async {
                        // print(value);
                        if (value != null) {
                          setState(() => themeValue = value);
                          final prefs = await SharedPreferences.getInstance();
                          if (value == "Dark") {
                            prefs.setBool('darkMode', true);
                          } else {
                            prefs.setBool('darkMode', false);
                          }
                          setState(() => settingsTheme = value);
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
