import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitegastos/data/user_data.dart';
import 'package:sitegastos/pages/gastos/item_page.dart';
import 'package:uuid/uuid.dart';

import '../../themes/themes.dart';
import 'list_tile_home_page.dart';

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
  final _controllerSearch = TextEditingController();
  bool isSearchVisible = false;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLength: 15,
              style: const TextStyle(color: Colors.black),
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Nome da Lista',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              'Selecione o Mês',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            ValueListenableBuilder<String>(
              valueListenable: _selectedMonthNotifier,
              builder: (context, selectedMonth, child) {
                return DropdownButton<String>(
                  value: selectedMonth,
                  style: const TextStyle(
                    color: Colors.black,
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
                      int uniqueId = DateTime.now().millisecondsSinceEpoch;

                      final newItem = UserData(
                        mainItemName: _textController.text,
                        monthName: _selectedMonthNotifier.value,
                        listName: listName,
                        id: uniqueId,
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
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _navigateToItemPage(
    BuildContext context,
    String itemName,
    String listName,
    int uniqueId,
  ) {
    final itemId = uniqueId.toString(); // Converta para String

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ItemPage(
        itemId: itemId,
        itemName: itemName,
      ),
    ));
  }

  List<UserData> getFilteredItems() {
    final searchQuery = _controllerSearch.text.toLowerCase();
    return items.where((list) {
      final itemName = list.listName.toLowerCase();
      return itemName.contains(searchQuery);
    }).toList();
  }

  void updateSearchQuery(String query) {
    setState(() {
      _controllerSearch.text = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchVisible = !isSearchVisible;
                if (!isSearchVisible) {
                  _controllerSearch.clear();
                }
              });
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                isSearchVisible ? Icons.close : Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money_outlined,
                      size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Crie uma nova lista para\nadicionar os seus gastos',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                if (isSearchVisible)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: _controllerSearch,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar por nome...',
                      ),
                      onChanged: (query) {
                        setState(() {});
                      },
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: isSearchVisible
                        ? getFilteredItems().length
                        : items.length,
                    itemBuilder: (context, index) {
                      final customItem = isSearchVisible
                          ? getFilteredItems()[index]
                          : items[index];
                      return GestureDetector(
                        onTap: () {
                          _navigateToItemPage(
                            context,
                            customItem.mainItemName,
                            customItem.listName,
                            customItem.id,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
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
