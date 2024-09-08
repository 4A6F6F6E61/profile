import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';

class BrowserItemStruct {
  // The name of the icon
  final String iconString;
  // The size of the icon
  final String iconSize;
  // The location of the browser binary
  final String browserBinLoc;
  // This is usually the arguemnt which indicated that we want to open a specific profile
  final String arg1;
  // This is only used for the Firefox browser, it is the argument which indicates the profile name
  final String arg2;
  // The Name Displayed in the App
  final String profileName;

  BrowserItemStruct({
    required this.iconString,
    required this.iconSize,
    required this.browserBinLoc,
    required this.arg1,
    required this.arg2,
    required this.profileName,
  });

  factory BrowserItemStruct.fromStringList(List<String> list) {
    return BrowserItemStruct(
      iconString: list[0],
      iconSize: list[1],
      browserBinLoc: list[2],
      arg1: list[3],
      arg2: list[4],
      profileName: list[5],
    );
  }
}

class BrowserItemWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onRemove;
  final Icon icon;
  final String text;
  final double? fontSize;
  final Color? textColor;

  const BrowserItemWidget({
    Key? key,
    required this.onPressed,
    required this.onRemove,
    required this.icon,
    required this.text,
    this.fontSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: 150,
          child: Column(
            children: [
              IconButton(
                icon: icon,
                onPressed: onPressed,
              ),
              Text(
                text,
                style: TextStyle(fontSize: fontSize, color: textColor),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(FluentIcons.delete),
            onPressed: onRemove,
          ),
        ),
      ],
    );
  }
}
