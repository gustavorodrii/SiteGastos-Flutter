// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sitegastos/login/my_button.dart';
import 'package:sitegastos/login/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onPressed;

  const RegisterPage({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage('As senhas não coincidem!');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ocorreu um erro ao criar a conta.';

      if (e.code == 'email-already-in-use') {
        errorMessage = 'O e-mail fornecido já está em uso por outra conta.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'E-mail inválido. Verifique o formato do e-mail.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'A senha fornecida é fraca. Tente uma senha mais forte.';
      }

      showErrorMessage(errorMessage);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.auto_graph_outlined, size: 130),
              const SizedBox(height: 20),
              const Text(
                'Planeje, Economize e Realize!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              MyTextField(
                controller: usernameController,
                hintText: 'E-mail',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                hintText: 'Senha',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirmar senha',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                text: 'Registrar',
                onPressed: signUp,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Possui cadastro ?',
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: widget.onPressed,
                    child: Text('Entre agora'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
