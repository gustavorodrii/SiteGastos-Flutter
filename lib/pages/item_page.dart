// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sitegastos/data/expense_data.dart';

class ItemPage extends StatefulWidget {
  final String itemName;
  final String itemId;
  final String listName;
  const ItemPage({
    Key? key,
    required this.itemName,
    required this.itemId,
    required this.listName,
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  TextEditingController gastoController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  final _valorFocus = FocusNode();

  List<ExpenseData> expenses = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> saveItems(List<ExpenseData> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((item) => item.toJson()).toList();
    final itemsJsonString = itemsJson.map((json) => jsonEncode(json)).toList();
    await prefs.setStringList('${widget.listName}/items', itemsJsonString);
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJsonString = prefs.getStringList('${widget.listName}/items');

    if (itemsJsonString != null) {
      final loadedItems = itemsJsonString
          .map((jsonString) => ExpenseData.fromJson(jsonDecode(jsonString)))
          .toList();
      setState(() {
        expenses = loadedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Text('Valor total Gasto'),
              ),
              Card(
                child: Text('Valor salário Mensal'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  leading: Checkbox(
                    value: expense.isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        expense.isChecked = value ?? false;
                        saveItems(
                            expenses); // Salva o estado do CheckBox ao marcá-lo ou desmarcá-lo
                      });
                    },
                  ),
                  title: Text(expense.name),
                  trailing: Text(
                    'R\$ ${expense.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: gastoController,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(_valorFocus);
            },
            maxLength: 30,
            decoration: InputDecoration(
              labelText: 'Nome do Gasto',
              prefixIcon: const Icon(Icons.text_snippet_outlined),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          TextField(
            controller: valorController,
            focusNode: _valorFocus,
            decoration: InputDecoration(
              labelText: 'Valor do Gasto',
              prefixIcon: const Icon(Icons.attach_money_outlined),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final double value = double.tryParse(valorController.text) ?? 0.0;
              if (value > 0) {
                final ExpenseData newExpense = ExpenseData(
                  name: gastoController.text,
                  value: value,
                  isChecked: false,
                );
                setState(() {
                  expenses.add(newExpense);
                  gastoController.clear();
                  valorController.clear();
                });
                saveItems(expenses);
              }
            },
            child: const Text('Salvar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
