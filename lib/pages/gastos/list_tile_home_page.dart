import 'package:flutter/material.dart';
import 'package:sitegastos/themes/themes.dart';

class ListTilePage extends StatelessWidget {
  final String mainItemName;
  final String monthName;
  final VoidCallback onDelete;

  const ListTilePage({
    Key? key,
    required this.mainItemName,
    required this.monthName,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.deepPurpleAccent,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome da lista de gastos :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(mainItemName),
                    SizedBox(height: 10),
                    Text(
                      "Mês :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(monthName),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.disabled_by_default_rounded,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
