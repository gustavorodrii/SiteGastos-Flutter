import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  TextStyle defaultStyle() => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'Gerenciamento de Gastos',
            style: defaultStyle(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
