import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAddProfile extends StatefulWidget {
  const SettingsAddProfile({Key? key}) : super(key: key);

  @override
  State<SettingsAddProfile> createState() => _SettingsAddProfileState();
}

class _SettingsAddProfileState extends State<SettingsAddProfile> {
  List<String> iconValues = const [
    'Cat', //'FluentIcons.cat',
    'Authenticator', //'FluentIcons.authenticator_app',
    'Dev tools', //'FluentIcons.developer_tools'
  ];
  String? iconComboBoxValue;
  String? iconChoose;

  List<String> browserValues = const [
    'Firefox',
    'Chrome',
    'Opera',
    'Edge',
  ];
  String? browserComboBoxValue;
  String? browserChoose;

  String? binloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a new profile',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              m.Card(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 40.0, child: Text("Icon:")),
                          Expanded(
                            child: Combobox<String>(
                              placeholder:
                                  Text(iconChoose ?? 'Choose an icon...'),
                              items: iconValues
                                  .map((e) => ComboboxItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              value: iconComboBoxValue,
                              onChanged: (value) async {
                                // print(value);
                                if (value != null) {
                                  setState(() => iconComboBoxValue = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Expanded(
                            child: Form(
                              child: TextBox(placeholder: "Profile name"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 40.0, child: Text("Type:")),
                          Expanded(
                            child: Combobox<String>(
                              placeholder:
                                  Text(browserChoose ?? 'Choose a browser...'),
                              items: browserValues
                                  .map((e) => ComboboxItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              value: browserComboBoxValue,
                              onChanged: (value) async {
                                // print(value);
                                if (value != null) {
                                  setState(() => browserComboBoxValue = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Form(
                              child: TextBox(
                                placeholder: "Browser binary location",
                                suffix: IconButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['exe'],
                                    );
                                    if (result != null) {
                                      binloc = result.files.single.path;
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  icon: const Icon(FluentIcons.open_file),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Button(
                              child: const Text('Save'), onPressed: () => {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preview:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              m.Card(
                color: const Color.fromARGB(0, 0, 0, 0),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text("WIP"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// String iconName, String iconSize,
// String browserBinLoc, String arg1, String arg2, String text