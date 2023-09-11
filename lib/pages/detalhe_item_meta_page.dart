// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    calcularValores();
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
                        Text(
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
                  Icon(Icons.done, color: Colors.green, size: 30)
                else
                  Text('$checkboxesSelecionados / ${valores.length}'),
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text(
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
                      isChecked[index] =
                          newValue ?? false; // Atualiza o estado do checkbox
                    });

                    // Realize ações com base na seleção ou desseleção do checkbox
                    if (newValue == true) {
                      valorGuardado += valores[index];
                    } else {
                      valorGuardado -= valores[index];
                    }
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
