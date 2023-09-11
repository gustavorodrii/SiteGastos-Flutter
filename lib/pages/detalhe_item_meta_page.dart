import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sitegastos/data/meta_data_page.dart';

class DetalheItemMetaPage extends StatefulWidget {
  final MetaDataPage item;
  const DetalheItemMetaPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DetalheItemMetaPage> createState() => _DetalheItemMetaPageState();
}

class _DetalheItemMetaPageState extends State<DetalheItemMetaPage> {
  List<double> valores = [];
  List<bool> isChecked = [];
  double valorGuardado = 0.0;
  int totalCheckboxes = 0;

  @override
  void initState() {
    super.initState();
    calcularValores();
    _carregarDados(); // Carrega os dados ao iniciar a página
  }

  void calcularValores() {
    double meta = widget.item.valueMeta;
    int prazo = widget.item.prazoMeta;
    double valorCalculado = meta / prazo;

    for (int i = 0; i < prazo; i++) {
      valores.add(valorCalculado);
      isChecked.add(false);
    }
  }

  Future<void> _salvarDados() async {
    // salvar dados
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Use o ID da meta como chave para salvar os dados
    String metaKey = 'meta_${widget.item.id}';

    // Salve os dados usando a chave específica da meta
    await prefs.setDouble('$metaKey.valorGuardado', valorGuardado);

    // Salve os estados das caixas de seleção como uma lista de strings 'true' ou 'false'
    List<String> isCheckedStringList =
        isChecked.map((value) => value.toString()).toList();
    await prefs.setStringList('$metaKey.isChecked', isCheckedStringList);
  }

  Future<void> _carregarDados() async {
    // carregar dados
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Use o ID da meta como chave para carregar os dados
    String metaKey = 'meta_${widget.item.id}';

    // Carregue o valor guardado
    double loadedValorGuardado =
        prefs.getDouble('$metaKey.valorGuardado') ?? 0.0;

    // Carregue os estados das caixas de seleção
    List<String>? isCheckedStringList =
        prefs.getStringList('$metaKey.isChecked');

    if (isCheckedStringList != null) {
      // Converte as strings de 'true' ou 'false' de volta para boolean
      List<bool> loadedIsChecked =
          isCheckedStringList.map((value) => value == 'true').toList();

      setState(() {
        valorGuardado = loadedValorGuardado;
        isChecked = loadedIsChecked;
      });
    }
  }

  void _atualizarValorGuardado() {
    double novoValorGuardado = 0.0;

    for (int i = 0; i < isChecked.length; i++) {
      if (isChecked[i]) {
        novoValorGuardado += valores[i];
      }
    }

    setState(() {
      valorGuardado = novoValorGuardado;
    });

    _salvarDados();
  }

  @override
  Widget build(BuildContext context) {
    int checkboxesSelecionados =
        isChecked.where((value) => value == true).length;
    bool todosSelecionados = checkboxesSelecionados == valores.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.nomeMeta),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        const Text(
                          'Guardado',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'pt_BR',
                            decimalDigits: 2,
                            symbol: 'R\$',
                          ).format(valorGuardado),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                if (todosSelecionados)
                  const Icon(Icons.done, color: Colors.green, size: 30)
                else
                  Text('$checkboxesSelecionados / ${valores.length}'),
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        const Text(
                          'Meta',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'pt_BR',
                            decimalDigits: 2,
                            symbol: 'R\$',
                          ).format(widget.item.valueMeta),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: valores.length,
              itemBuilder: (context, index) {
                bool isSelecionado = isChecked[index];
                return CheckboxListTile(
                  title: Text('Mês ${index + 1}'),
                  subtitle: Text(
                    NumberFormat.currency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                      symbol: 'R\$',
                    ).format(valores[index]),
                    style: TextStyle(
                        decoration:
                            isSelecionado ? TextDecoration.lineThrough : null,
                        color: isSelecionado ? Colors.green : null),
                  ),
                  value: isChecked[index],
                  onChanged: (bool? newValue) {
                    setState(() {
                      isChecked[index] = newValue ?? false;
                    });

                    if (newValue == true) {
                      valorGuardado += valores[index];
                    } else {
                      valorGuardado -= valores[index];
                    }
                    _atualizarValorGuardado();
                    _salvarDados();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
