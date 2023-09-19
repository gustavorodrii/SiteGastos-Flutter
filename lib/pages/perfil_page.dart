// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  // final user = FirebaseAuth.instance.currentUser!;

  // void signOut() {
  //   FirebaseAuth.instance.signOut();
  // }

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tema do Aplicativo',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    RadioListTile<ThemeMode>(
                      title: const Text('Automático'),
                      value: ThemeMode.system,
                      groupValue: appStore.themeMode,
                      onChanged: (ThemeMode? value) {
                        appStore.switchTheme(value);
                      },
                    ),
                    RadioListTile(
                      title: const Text('Claro'),
                      value: ThemeMode.light,
                      groupValue: appStore.themeMode,
                      onChanged: appStore.switchTheme,
                    ),
                    RadioListTile(
                      title: const Text('Escuro'),
                      value: ThemeMode.dark,
                      groupValue: appStore.themeMode,
                      onChanged: appStore.switchTheme,
                    ),
                  ],
                ),
              ),
              // Spacer(),
              // ElevatedButton.icon(
              //   onPressed: signOut,
              //   icon: Icon(Icons.logout),
              //   label: Text('Sair da conta'),
              // ),
              // SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
