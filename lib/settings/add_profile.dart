import 'dart:io';

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

  TextEditingController _binaryInputController = TextEditingController();

  List<String> browserValues = const [
    'Firefox',
    'Chrome',
    'Opera',
    'Edge',
  ];
  String? browserComboBoxValue;
  String? browserChoose;

  String binloc = "";
  String profileName = "";
  String displayName = "";

  String? resultdialog = "";

  void showContentDialog(BuildContext context, String error,
      {bool iserror = true}) async {
    resultdialog = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(iserror ? "Error" : "Success"),
        content: Text(
          error,
        ),
        actions: [
          Button(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context, 'User okd dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

  Future<void> saveProfile() async {
    if (browserComboBoxValue == null || iconComboBoxValue == null) {
      showContentDialog(context, "Please choose a browser and an icon");
      return;
    }
    if (browserComboBoxValue!.isEmpty ||
        iconComboBoxValue!.isEmpty ||
        profileName.isEmpty ||
        binloc.isEmpty ||
        displayName.isEmpty) {
      if (!(binloc.endsWith(".exe") || binloc.endsWith(".app"))) {
        showContentDialog(
            context, "Browser binary location must end with .exe or .app");
        return;
      }
      showContentDialog(context, "Please fill out all fields");

      return;
    }
    if (!await File(binloc).exists()) {
      showContentDialog(context, "File does not exists");
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(profileName)) {
      showContentDialog(context, "Profile name already exists");
      return;
    }
    var listTemp = prefs.getStringList('browserProfiles') ?? [];
    listTemp.add(profileName);
    prefs.setStringList('browserProfiles', listTemp);
    var par2 = "";
    switch (browserComboBoxValue) {
      case "Chrome":
        par2 = "--profile-directory=$profileName";
        break;
      case "Firefox":
        par2 = "-p";
        break;
      case "Opera":
        par2 = "--profile-directory=$profileName";
        break;
      case "Edge":
        par2 = "--profile-directory=$profileName";
        break;
      default:
        par2 = "-p";
        break;
    }
    prefs.setStringList(profileName, [
      iconComboBoxValue!,
      "80",
      binloc,
      par2,
      browserComboBoxValue == "Firefox" ? profileName : "",
      displayName,
    ]); //add profile to list of profiles

    showContentDialog(context, "Profile saved", iserror: false);
  }

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
                          const SizedBox(
                            width: 100.0,
                            child: Text("Display Name:"),
                          ),
                          Expanded(
                            child: TextBox(
                              controller: TextEditingController(
                                text: displayName,
                              ),
                              onChanged: (value) => displayName = value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
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
                          Expanded(
                            child: TextBox(
                              placeholder: "Profile name",
                              onChanged: (value) {
                                setState(() => profileName = value);
                              },
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
                            child: TextBox(
                              placeholder: "Browser binary location",
                              controller: _binaryInputController,
                              onChanged: (value) {
                                setState(() => binloc = value);
                              },
                              suffix: IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['exe', 'app'],
                                  );
                                  if (result != null) {
                                    binloc = result.files.single.path ?? "";
                                    _binaryInputController.text = binloc;
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                icon: const Icon(FluentIcons.open_file),
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
                            child: const Text('Save'),
                            onPressed: () async => saveProfile(),
                          ),
                        ),
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