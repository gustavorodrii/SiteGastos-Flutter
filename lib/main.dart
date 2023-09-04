import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitegastos/pages/main_page.dart';
import 'package:sitegastos/store.dart';
import 'package:sitegastos/themes/themes.dart';

void main() {
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
            home: const MainPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
