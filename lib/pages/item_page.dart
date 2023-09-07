// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TextEditingController salarioController = TextEditingController();
  double? salario;

  final _valorFocus = FocusNode();

  List<ExpenseData> expenses = [];
  bool isCheckBoxSelected = false;

  @override
  void initState() {
    super.initState();
    loadItems();
    loadSalario();
  }

  Future<void> loadSalario() async {
    // salario
    final prefs = await SharedPreferences.getInstance();
    final salarioSalvo = prefs.getDouble('salario');
    if (salarioSalvo != null) {
      setState(() {
        salario = salarioSalvo;
      });
    }
  }

  Future<void> saveItems(List<ExpenseData> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((item) => item.toJson()).toList();
    final itemsJsonString = itemsJson.map((json) => jsonEncode(json)).toList();
    await prefs.setStringList('${widget.itemName}/items', itemsJsonString);
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJsonString = prefs.getStringList('${widget.itemName}/items');

    if (itemsJsonString != null) {
      final loadedItems = itemsJsonString
          .map((jsonString) => ExpenseData.fromJson(jsonDecode(jsonString)))
          .toList();
      setState(() {
        expenses = loadedItems;
      });
    }
  }

  String calculateTotalExpense() {
    double total = 0.0;
    for (var expense in expenses) {
      if (expense.isChecked) {
        total += expense.value;
      }
    }

    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormat.format(total);
  }

  Future<double> calculateRemainingValue() async {
    if (salario == null) {
      return 0.0;
    }

    double totalGasto = 0.0;
    for (var expense in expenses) {
      if (expense.isChecked) {
        totalGasto += expense.value;
      }
    }

    return salario! - totalGasto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.itemName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Informe seu novo salário'),
                    content: TextField(
                      controller: salarioController,
                      keyboardType: TextInputType.number,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Validar e atualizar o valor do salário
                          final valorSalario =
                              double.tryParse(salarioController.text);
                          if (valorSalario != null && valorSalario > 0) {
                            setState(() {
                              salario = valorSalario;
                            });

                            // Salvar o valor do salário usando SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setDouble('salario', salario!);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        const Text(
                          'Valor Gasto',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          calculateTotalExpense(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        const Text(
                          'Valor Salário',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        salario != null
                            ? Text(
                                NumberFormat.currency(
                                  locale: 'pt_BR',
                                  symbol: 'R\$',
                                ).format(salario!),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Informe seu salário'),
                                        content: TextField(
                                          controller: salarioController,
                                          keyboardType: TextInputType.number,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Validar e atualizar o valor do salário
                                              final valorSalario =
                                                  double.tryParse(
                                                      salarioController.text);
                                              if (valorSalario != null &&
                                                  valorSalario > 0) {
                                                setState(() {
                                                  salario = valorSalario;
                                                });

                                                // Salvar o valor do salário usando SharedPreferences
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setDouble(
                                                    'salario', salario!);
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Salvar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.add),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        const Text(
                          'Valor Restante',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<double>(
                          // Calcula o valor restante
                          future: calculateRemainingValue(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text(
                                'Erro ao calcular',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              final remainingValue = snapshot.data!;
                              final formattedValue = NumberFormat.currency(
                                locale: 'pt_BR',
                                decimalDigits: 2,
                                symbol: 'R\$',
                              ).format(remainingValue);

                              // Defina a cor com base no valor restante
                              final color = remainingValue >= 0
                                  ? Colors.green
                                  : Colors.red;

                              return Text(
                                formattedValue,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      expenses.removeAt(index);
                    });
                    saveItems(expenses);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  key: UniqueKey(),
                  child: ListTile(
                    leading: Checkbox(
                      value: expense.isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          expense.isChecked = value ?? false;
                          saveItems(expenses);
                        });
                      },
                    ),
                    title: Text(
                      expense.name,
                      style: TextStyle(
                        decoration: expense.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Text(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                        symbol: 'R\$',
                      ).format(expense.value),
                      style: TextStyle(
                        decoration: expense.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextField(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: valorController,
              focusNode: _valorFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor do Gasto',
                prefixIcon: const Icon(Icons.attach_money_outlined),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final double value = double.tryParse(valorController.text) ?? 0.0;
              final String gastoText = gastoController.text.trim();

              if (value > 0 && gastoText.isNotEmpty) {
                final ExpenseData newExpense = ExpenseData(
                  name: gastoText,
                  value: value,
                  isChecked: false,
                );
                setState(() {
                  expenses.add(newExpense);
                  gastoController.clear();
                  valorController.clear();
                });

                // Chame saveItems após adicionar o novo item
                saveItems(expenses);
              } else {
                // Exibir um SnackBar informando que o campo é obrigatório.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(
                      child: Text(
                          'Por favor, preencha todos os campos obrigatórios.'),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text(
              'Salvar',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
