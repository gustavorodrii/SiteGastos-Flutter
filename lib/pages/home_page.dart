import 'package:flutter/material.dart';
import 'package:sitegastos/pages/total_page.dart';
import 'package:sitegastos/utils/app_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'Meus Gastos',
            style: AppStyles.defaultStyle(),
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
      body: TotalPage(),
    );
  }
}
