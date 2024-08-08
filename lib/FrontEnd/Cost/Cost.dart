import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Backend/AlterFunction.dart';
import '../../Database/PostSppd.dart';
import '../TickerProvider/PengikutAdapter.dart';

class SppdCostDialog extends StatefulWidget {
  const SppdCostDialog({Key? key, required this.sppd}) : super(key: key);
  final Sppd sppd;

  @override
  _SppdCostDialogState createState() => _SppdCostDialogState();
}

class _SppdCostDialogState extends State<SppdCostDialog> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  Future<void> _submitData() async {
    try {
      // Parse and validate the input values
      int? qty = int.tryParse(_qtyController.text);
      int? total = int.tryParse(_totalController.text);
      String nama = _namaController.text;

      if (qty == null || total == null || nama.isEmpty) {
        print('Invalid input data');
        return;
      }


      Map<String, String> data = {
        'SPPD_MST_SEQ':widget.sppd.index,
        'SPPD_FEE_AMT': (total * qty).toString(),
        'ITEM_QTY': qty.toString(),
        'SPPD_ITEM_NM': nama,
      };

      // Define the URL for the POST request
      final String url = 'http://$api/add_harga.php'; // Replace with your actual API endpoint

      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: data,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Data submitted successfully');
      } else {
        // Handle failure
        print('Failed to submit data: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle error
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Biaya SPPD'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _qtyController,
            decoration: InputDecoration(
              labelText: 'Jumlah Pengeluaran',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _namaController,
            decoration: InputDecoration(
              labelText: 'Nama Pengeluaran',
            ),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: _totalController,
            decoration: InputDecoration(
              labelText: 'Harga per Pengeluaran',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _submitData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PengikutAdapter(sppd: widget.sppd)),
            );
          },
          child: Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
