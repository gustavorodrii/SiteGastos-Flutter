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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: TextField(
              maxLength: 25,
              controller: nomeMetaController,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(valorMeta);
              },
              decoration: InputDecoration(
                labelText: 'Nome',
                isDense: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                hintText: 'Nome da Meta',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: valorMetaController,
              focusNode: valorMeta,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(prazoMeta);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor',
                isDense: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                hintText: 'Valor da Meta',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              controller: prazoMetaController,
              focusNode: prazoMeta,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                labelText: 'Prazo',
                hintText: 'Quantidade de meses para alcançar a meta. Ex: 12',
                hintStyle: TextStyle(fontSize: 12),
              ),
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
