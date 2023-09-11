import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitegastos/themes/themes.dart';

class ListTileMetasPage extends StatefulWidget {
  final String metasName;
  final double valueMeta;
  final int prazoMeta;
  const ListTileMetasPage({
    super.key,
    required this.metasName,
    required this.valueMeta,
    required this.prazoMeta,
  });

  @override
  State<ListTileMetasPage> createState() => _ListTileMetasPageState();
}

class _ListTileMetasPageState extends State<ListTileMetasPage> {
  double progresso = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: darkTheme.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(widget.metasName),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  NumberFormat.currency(
                    locale: 'pt_BR',
                    decimalDigits: 2,
                    symbol: 'R\$',
                  ).format(widget.valueMeta),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
