import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:webview/common_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SettingsList(
        darkTheme: const SettingsThemeData(
          tileHighlightColor: Colors.black26,
        ),
        sections: [
          SettingsSection(
            title: const Text('General'),
            tiles: [
              SettingsTile(
                title: const Text('Notifications'),
                leading: const Icon(Icons.notifications),
                onPressed: (BuildContext context) {
                  // Handle notification tile press
                },
              ),
              SettingsTile(
                title: const Text('Privacy'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {
                  // Handle privacy tile press
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account'),
            tiles: [
              SettingsTile(
                title: const Text('Profile'),
                leading: const Icon(Icons.person),
                onPressed: (BuildContext context) {
                  // Handle profile tile press
                },
              ),
              SettingsTile(
                title: const Text('Sign Out'),
                leading: const Icon(Icons.exit_to_app),
                onPressed: (BuildContext context) {
                  // Handle sign out tile press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
