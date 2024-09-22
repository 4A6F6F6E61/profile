import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:win32/win32.dart';

Future<bool?> showMessageBox(BuildContext context, String caption, String text) async {
  if (Platform.isWindows) {
    return compute(_showMessageBox, '$caption\n$text');
  }
  return showDialog<bool>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(caption),
      content: Text(text),
      actions: [
        Button(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),
        Button(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Remove'),
        ),
      ],
    ),
  );
}

bool _showMessageBox(String string) {
  final lpCaption = string.split("\n").first.toNativeUtf16();
  final lpText = string.split("\n").last.toNativeUtf16();

  final result = MessageBox(
    NULL,
    lpText,
    lpCaption,
    MESSAGEBOX_STYLE.MB_ICONWARNING | // Warning icon
        MESSAGEBOX_STYLE.MB_YESNO | // Action button
        MESSAGEBOX_STYLE.MB_DEFBUTTON2, // Second button is the default
  );

  free(lpText);
  free(lpCaption);

  if (result == MESSAGEBOX_RESULT.IDYES) {
    return true;
  }
  return false;
}
