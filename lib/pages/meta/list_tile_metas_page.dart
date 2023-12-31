// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Icon(Icons.auto_graph_outlined),
                    SizedBox(width: 10),
                    Text(
                      widget.metasName,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
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
        ),
      ),
    );
  }
}
