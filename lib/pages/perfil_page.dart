import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Provider.of<AppStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Column(
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
            Spacer(),
            ElevatedButton.icon(
              onPressed: signOut,
              icon: Icon(Icons.logout),
              label: Text('Sair da conta'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
