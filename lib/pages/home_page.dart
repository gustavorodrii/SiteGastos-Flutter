import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitegastos/data/user_data.dart';
import 'package:sitegastos/pages/item_page.dart';
import 'package:uuid/uuid.dart';

import '../themes/themes.dart';
import 'list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> saveItems(List<UserData> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((item) => item.toJson()).toList();
    final itemsJsonString = itemsJson.map((json) => jsonEncode(json)).toList();
    await prefs.setStringList('items', itemsJsonString);
  }

  Future<List<UserData>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJsonString = prefs.getStringList('items');

    if (itemsJsonString == null) {
      return [];
    }

    // Converta a lista de strings em uma lista de mapas
    final itemsJson =
        itemsJsonString.map((jsonString) => jsonDecode(jsonString)).toList();

    // Converta a lista de mapas em uma lista de objetos UserData
    final loadedItems =
        itemsJson.map((json) => UserData.fromJson(json)).toList();

    return loadedItems;
  }

  @override
  void initState() {
    super.initState();
    loadItems().then((loadedItems) {
      setState(() {
        items = loadedItems;
      });
    });
  }

  final TextEditingController _textController = TextEditingController();
  final uuid = Uuid();
  Map<String, String> itemIds = {};

  List<UserData> items = [];
  bool isItemDeleted = false;
  int deletedItemIndex = -1;
  ValueNotifier<String> _selectedMonthNotifier =
      ValueNotifier<String>('Janeiro');

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 100,
        backgroundColor: lightTheme.indicatorColor,
        behavior: SnackBarBehavior.floating,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 10,
                    style: const TextStyle(color: Colors.black),
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Lista',
                      labelStyle: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedMonthNotifier,
                  builder: (context, selectedMonth, child) {
                    return DropdownButton<String>(
                      value: selectedMonth,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (newValue) {
                        _selectedMonthNotifier.value = newValue!;
                      },
                      items: [
                        'Janeiro',
                        'Fevereiro',
                        'Março',
                        'Abril',
                        'Maio',
                        'Junho',
                        'Julho',
                        'Agosto',
                        'Setembro',
                        'Outubro',
                        'Novembro',
                        'Dezembro',
                      ].map((month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      final listName = _textController.text;
                      final newItem = UserData(
                        mainItemName: _textController.text,
                        monthName: _selectedMonthNotifier.value,
                        listName: listName,
                      );
                      items.add(newItem);
                      _textController.clear();
                    });

                    saveItems(items);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: const Text(
                    'Adicionar nova Lista',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        duration: const Duration(seconds: 1000),
      ),
    );
  }

  void deleteItem(int index) {
    setState(() {
      isItemDeleted = true;
      deletedItemIndex = index;
      final deletedList = items.removeAt(index);
      saveItems(items);

      SharedPreferences.getInstance().then((prefs) {
        prefs.remove(deletedList.mainItemName);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Você excluiu a lista ${deletedList.mainItemName}',
            style: const TextStyle(fontSize: 14),
          ),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              setState(() {
                items.insert(deletedItemIndex, deletedList);
                isItemDeleted = false;
              });
              saveItems(items);
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  void _navigateToItemPage(
      BuildContext context, String itemName, String listName) {
    final itemId = itemIds['$listName/$itemName'] ?? uuid.v4();
    itemIds['$listName/$itemName'] = itemId;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ItemPage(
        itemId: itemId,
        itemName: itemName,
        listName: listName,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final customItem = items[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToItemPage(
                      context,
                      customItem.mainItemName,
                      customItem.listName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: ListTilePage(
                      mainItemName: customItem.mainItemName,
                      monthName: customItem.monthName,
                      onDelete: () {
                        deleteItem(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showSnackBar(context);
        },
        label: const Icon(Icons.add),
      ),
    );
  }
}
