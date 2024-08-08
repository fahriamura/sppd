import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Backend/AlterFunction.dart';
import '../../Database/Harga.dart';

class SppdCostDetail extends StatefulWidget {
  const SppdCostDetail({Key? key, required this.harga}) : super(key: key);
  final List<Harga> harga;

  @override
  _SppdCostDetailState createState() => _SppdCostDetailState();
}

class _SppdCostDetailState extends State<SppdCostDetail> {
  List<Harga> _combinedHarga = [];

  @override
  void initState() {
    super.initState();
    _combineSimilarItems(widget.harga);
  }

  void _combineSimilarItems(List<Harga> hargaList) {
    final Map<String, Harga> map = {};

    for (var item in hargaList) {
      // Ensure proper formatting and conversion
      final int jumlah = int.tryParse(
          item.jumlahBarang.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      final int harga = int.tryParse(
          item.HargaTotal.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

      if (map.containsKey(item.namaBarang)) {
        map[item.namaBarang]!.update(jumlah, harga);
      } else {
        map[item.namaBarang] = Harga(
          namaBarang: item.namaBarang,
          jumlahBarang: jumlah.toString(),
          HargaTotal: harga.toString(),
        );
      }
    }

    setState(() {
      _combinedHarga = map.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Biaya SPPD'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderRow(),
            Divider(),
            ..._combinedHarga.map((item) => _buildDataRow(item)).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Nama',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Harga',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Jumlah',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(Harga item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(item.namaBarang),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                formatCurrency(double.parse(item.HargaTotal) / 100),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(item.jumlahBarang),
            ),
          ),
        ],
      ),
    );
  }

}

