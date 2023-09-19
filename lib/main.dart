import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitegastos/carousel/carousel_page.dart';
// import 'package:sitegastos/login/auth.dart';
import 'package:sitegastos/store.dart';
import 'package:sitegastos/themes/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            home: CarouselPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
