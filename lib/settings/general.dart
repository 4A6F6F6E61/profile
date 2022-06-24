import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({Key? key}) : super(key: key);

  @override
  State<SettingsGeneral> createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  List<String> values = const [
    "red",
    "orange",
    "yellow",
    "green",
    "teal",
    "blue",
    "purple"
  ];
  String? comboBoxValue;
  String? settingsColor = '';
  bool value = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('color')) {
      prefs.setString('color', "Blue");
    }
    setState(() => settingsColor = prefs.getString('color'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Change the accent color:"),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 200,
              child: Combobox<String>(
                placeholder: Text(settingsColor ?? 'Loading...'),
                items: values
                    .map((e) => ComboboxItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                value: comboBoxValue,
                onChanged: (value) async {
                  // print(value);
                  if (value != null) {
                    setState(() => comboBoxValue = value);
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('color', value);
                    setState(() => settingsColor = prefs.getString('color'));
                  }
                },
              ),
            ),
          ),
          const Text("(requires restart)", style: TextStyle(fontSize: 10.0)),
        ],
      ),
    );
  }
}
