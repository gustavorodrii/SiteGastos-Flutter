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
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: darkTheme.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.text_snippet_outlined, size: 25),
                const SizedBox(width: 10),
                Text(mainItemName),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.date_range, size: 25),
                const SizedBox(width: 10),
                Text(monthName),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFB3261E),
                    ),
                  ),
                  onPressed: onDelete,
                  child: const Text(
                    'Deletar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
