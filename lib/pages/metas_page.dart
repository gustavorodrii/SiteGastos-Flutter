import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitegastos/pages/criar_nova_meta.dart';
import 'package:sitegastos/pages/detalhe_item_meta_page.dart';

import '../data/meta_data_page.dart';
import 'list_tile_metas_page.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  List<MetaDataPage> metaItems = [];

  @override
  void initState() {
    super.initState();
    _carregarMetasSalvas();
  }

  Future<void> _carregarMetasSalvas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? metaItemsJson = prefs.getStringList('metaItems');
    if (metaItemsJson != null) {
      List<MetaDataPage> loadedMetaItems = metaItemsJson
          .map((json) => MetaDataPage.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        metaItems = loadedMetaItems;
      });
    }
  }

  void _navigateToDetalheItemMetaPage(MetaDataPage item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetalheItemMetaPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: metaItems.length,
              itemBuilder: (context, index) {
                final customItem = metaItems[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToDetalheItemMetaPage(customItem);
                  },
                  child: ListTileMetasPage(
                    metasName: customItem.nomeMeta,
                    valueMeta: customItem.valueMeta,
                    prazoMeta: customItem.prazoMeta,
                    id: customItem.id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => CriarNovaMeta()));

          if (result != null) {
            setState(() {
              metaItems.add(result);
            });

            // Salve os dados no SharedPreferences após adicionar um novo item
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String> metaItemsJson =
                metaItems.map((meta) => jsonEncode(meta.toJson())).toList();
            prefs.setStringList('metaItems', metaItemsJson);
          }
        },
        label: const Text('Criar Meta'),
      ),
    );
  }
}
