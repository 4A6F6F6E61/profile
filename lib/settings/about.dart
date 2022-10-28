import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          m.Card(
            color: const Color.fromARGB(0, 0, 0, 0),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Browser Profile Manager",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Simple Browser Profile Manager build with Flutter by Joona Brückner"),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
