import 'package:flutter/material.dart';
import 'package:sitegastos/pages/criar_nova_meta.dart';
import 'package:sitegastos/pages/detalhe_item_meta_page.dart';

import '../data/meta_data_page.dart';
import 'list_tile_metas_page.dart';

class MetasPage extends StatefulWidget {
  MetasPage({super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  List<MetaDataPage> metaItems = [];
  double progresso = 0.0;

  void _navigateToDetalheItemMetaPage(MetaDataPage item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetalheItemMetaPage(item: item)));
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
          }
        },
        label: const Text('Criar Meta'),
      ),
    );
  }
}
