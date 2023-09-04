import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitegastos/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Provider.of<AppStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: appStore.themeMode,
              onChanged: (ThemeMode? value) {
                appStore.switchTheme(value);
              },
            ),
            RadioListTile(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: appStore.themeMode,
              onChanged: appStore.switchTheme,
            ),
            RadioListTile(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: appStore.themeMode,
              onChanged: appStore.switchTheme,
            ),
          ],
        ),
      ),
    );
  }
}
