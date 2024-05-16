import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';

class BrowserItem extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String text;
  final double? fontSize;
  final Color? textColor;

  const BrowserItem({
    Key? key,
    required this.onPressed,
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
                onPressed: () => onPressed(),
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
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
