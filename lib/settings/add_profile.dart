import 'package:fluent_ui/fluent_ui.dart';

class SettingsAddProfile extends StatefulWidget {
  const SettingsAddProfile({Key? key}) : super(key: key);

  @override
  State<SettingsAddProfile> createState() => _SettingsAddProfileState();
}

class _SettingsAddProfileState extends State<SettingsAddProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [
          Text('SettingsAddProfile'),
        ],
      ),
    );
  }
}
