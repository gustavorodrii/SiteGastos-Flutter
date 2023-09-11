import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitegastos/data/meta_data_page.dart';

class CriarNovaMeta extends StatefulWidget {
  const CriarNovaMeta({super.key});

  @override
  State<CriarNovaMeta> createState() => _CriarNovaMetaState();
}

class _CriarNovaMetaState extends State<CriarNovaMeta> {
  TextEditingController nomeMetaController = TextEditingController();
  TextEditingController valorMetaController = TextEditingController();
  TextEditingController prazoMetaController = TextEditingController();

  FocusNode valorMeta = FocusNode();
  FocusNode prazoMeta = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar nova Meta'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLength: 25,
            controller: nomeMetaController,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(valorMeta);
            },
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'Nome da Meta',
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
          TextField(
            controller: valorMetaController,
            focusNode: valorMeta,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(prazoMeta);
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Valor',
              hintText: 'Valor da Meta',
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
          TextField(
            controller: prazoMetaController,
            focusNode: prazoMeta,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Prazo',
              hintText: 'Quantidade de meses para alcançar a meta. Ex: 12',
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String nomeMeta = nomeMetaController.text;
                int prazoMeta = int.parse(prazoMetaController.text);
                double valorMeta = double.parse(valorMetaController.text);

                int uniqueId = DateTime.now().millisecondsSinceEpoch;

                MetaDataPage novaMeta = MetaDataPage(
                  nomeMeta: nomeMeta,
                  valueMeta: valorMeta,
                  prazoMeta: prazoMeta,
                  id: uniqueId,
                );

                // Salvar os dados no SharedPreferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> metaItemsJson =
                    prefs.getStringList('metaItems') ?? [];
                metaItemsJson.add(jsonEncode(novaMeta.toJson()));
                prefs.setStringList('metaItems', metaItemsJson);

                Navigator.pop(
                  context,
                  novaMeta,
                );
              },
              child: Text('Salvar'),
            ),
          ),
        ],
      ),
    );
  }
}
