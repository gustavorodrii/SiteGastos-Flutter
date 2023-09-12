import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitegastos/firebase_options.dart';
import 'package:sitegastos/login/auth.dart';
import 'package:sitegastos/store.dart';
import 'package:sitegastos/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppStore(),
      child: Consumer<AppStore>(
        builder: (context, value, child) {
          return MaterialApp(
            themeMode: value.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: AuthPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
