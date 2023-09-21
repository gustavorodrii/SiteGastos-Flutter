import 'package:flutter/material.dart';
import 'package:sitegastos/themes/themes.dart';

class ListTilePage extends StatelessWidget {
  final String mainItemName;
  final String monthName;
  final VoidCallback onDelete;
  const ListTilePage({
    super.key,
    required this.mainItemName,
    required this.monthName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        side: BorderSide(color: darkTheme.primaryColor),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Nome da Lista :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(mainItemName),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Mês :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(monthName),
                  ],
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.disabled_by_default_rounded),
                  iconSize: 40,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
