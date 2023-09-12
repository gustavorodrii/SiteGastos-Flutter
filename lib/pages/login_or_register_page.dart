import 'package:flutter/material.dart';
import 'package:sitegastos/login/login_page.dart';
import 'package:sitegastos/register/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onPressed: togglePage,
      );
    } else {
      return RegisterPage(
        onPressed: togglePage,
      );
    }
  }
}
