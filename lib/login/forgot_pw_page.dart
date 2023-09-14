import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Link para resetar sua senha foi enviado para o seu e-mail! '),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text('OK'),
                ),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ocorreu um erro ao redefinir a senha.';

      if (e.code == 'user-not-found') {
        errorMessage = 'Usuário não encontrado.\nVerifique o e-mail fornecido.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'E-mail inválido.\nVerifique o formato do e-mail.';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              errorMessage,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text('OK'),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Insira o seu e-mail e nós iremos enviar um link\npara você resetar sua senha',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                filled: true,
                hintText: 'E-mail',
              ),
            ),
          ),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: passwordReset,
            child: Text('Resetar senha'),
            color: Colors.purple.shade300,
          ),
        ],
      ),
    );
  }
}
