// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:sitegastos/themes/themes.dart';

class ListTileMetasPage extends StatefulWidget {
  final String metasName;
  final double valueMeta;
  final int prazoMeta;
  final int id;
  const ListTileMetasPage({
    Key? key,
    required this.metasName,
    required this.valueMeta,
    required this.prazoMeta,
    required this.id,
  }) : super(key: key);

  @override
  State<ListTileMetasPage> createState() => _ListTileMetasPageState();
}

class _ListTileMetasPageState extends State<ListTileMetasPage> {
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: LinearPercentIndicator(
              lineHeight: 10,
              percent: 0.2,
              progressColor: Colors.green,
              animation: true,
            ),
          ),
        ],
      ),
    );
  }
}
