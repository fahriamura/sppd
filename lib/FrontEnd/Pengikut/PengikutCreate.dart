import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sppd/Backend/AlterFunction.dart';

import '../../Database/PostSppd.dart';
import '../../Database/Provinsi.dart';
import '../TickerProvider/PengikutAdapter.dart';
import '../TickerProvider/SPPD.dart';
class PengikutCreate extends StatefulWidget {
  final Sppd sppd;

  PengikutCreate({required this.sppd});
  @override
  _PengikutCreateState createState() => _PengikutCreateState();
}

class _PengikutCreateState extends State<PengikutCreate> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('yyyyMMdd');
  final _jenisPengikutController = TextEditingController();
  final _wilayahController = TextEditingController();
  final _namaController = TextEditingController();
  final _noKtpNipController = TextEditingController();
  final _statusPegawaiController = TextEditingController();
  final _tipeOrganisasiController = TextEditingController();
  final _organisasiPengikutController = TextEditingController();
  final _golonganController = TextEditingController();
  final _jabatanController = TextEditingController();
  final _tipeSppdController = TextEditingController();
  final _jenisTujuanController = TextEditingController();
  final _berangkatController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _tanggalBerangkatController = TextEditingController();
  final _tanggalKembaliController = TextEditingController();
  final _berangkatPengikutController = TextEditingController();
  final _transportasiPengikutController = TextEditingController();
  final _keteranganLainController = TextEditingController();
  final _asalPengikutController = TextEditingController();
  final _tujuanPengikutController = TextEditingController();
  final _statusController = TextEditingController();

  DateTime? _tanggalDikeluarkan;
  DateTime? _tanggalPermohonan;
  DateTime? _tanggalBerangkat;
  DateTime? _tanggalKembali;


  List<String> provinsiList = [];
  List<String> kotaList =[];
  List<String> kodeProvinsi= [];
  List<String> kodeKota=[];
  late String kodeBerangkat = '';
  late String kodeTujuan = '';
  @override
  void initState() {
    super.initState();
    fetchProvinsiList();
  }

  void fetchProvinsiList() async {
    String url = 'http://172.30.1.68/get_kota.php';
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        provinsiList = jsonResponse.map((e) => e['namaProv'].toString()).toList();
        kodeProvinsi = jsonResponse.map((e) => e['kodeProv'].toString()).toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching provinsi data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> transportasiList = ['Pesawat'];









    Future<void> selectDate(
        BuildContext context,
        DateTime? initialDate,
        void Function(DateTime) onDateSelected,
        ) async {
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (selectedDate != null) {
        onDateSelected(selectedDate);
      }
    }
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Jenis Pengikut', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _jenisPengikutController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Wilayah', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _wilayahController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tipe Organisasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tipeOrganisasiController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Nama', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _namaController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('No.KTP/NIP', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _noKtpNipController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Status Pegawai', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _statusPegawaiController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Organisasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _organisasiPengikutController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Golongan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _golonganController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Jabatan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _jabatanController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tipe SPPD', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tipeSppdController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Jenis Tujuan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _jenisTujuanController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Berangkat', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _berangkatPengikutController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tujuan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tujuanPengikutController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Berangkat', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tanggalBerangkatController, // Ganti dengan controller yang sesuai
                          readOnly: true,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalBerangkat,
                                  (date) {
                                setState(() {
                                  _tanggalBerangkat = date;
                                  _tanggalBerangkatController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Kembali', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tanggalKembaliController, // Ganti dengan controller yang sesuai
                          readOnly: true,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalKembali,
                                  (date) {
                                setState(() {
                                  _tanggalKembali = date;
                                  _tanggalKembaliController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Transportasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _transportasiPengikutController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Keterangan Lain', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _keteranganLainController, // Ganti dengan controller yang sesuai
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitForm(context);
                    print('aa $kodeTujuan');
                    print('bb $kodeBerangkat');
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),

      ),
    );
  }

  void submitForm(BuildContext context) async {
    // Extracting and formatting data
    final String Id = _noKtpNipController.text;
    final String Jenis = _jenisPengikutController.text;
    final String Nama = _namaController.text;
    final String Organisasi = _organisasiPengikutController.text;
    final String tipe = _tipeSppdController.text;
    final String berangkat = _berangkatPengikutController.text;
    final String tujuan = _tujuanPengikutController.text;
    final String tujuanBisnis = _keteranganLainController.text;
    final String wilayah = _wilayahController.text;
    final String status = _statusController.text;
    final String golongan = _golonganController.text;
    final String jabatan = _jabatanController.text;
    final String jenisTujuan = _jenisTujuanController.text;

    // Prepare the request body
    final Map<String, dynamic> body = {
      'PTCPNT_ID': Id,
      'SPPD_MST_SEQ': widget.sppd.index,
      'PTCPNT_TP_CD': Jenis,
      'PTCPNT_NM': Nama,
      'GVRMT_ORG_NM': Organisasi,
      'SPPD_TP_CD': tipe,
      'ORG_MGMT_NO': widget.sppd.kodeBerangkat,
      'SPPD_ORG_MEMO': widget.sppd.berangkat,
      'DEST_MGMT_NO': widget.sppd.kodeTujuan,
      'SPPD_DEST_MEMO': widget.sppd.tujuan,
      'SPPD_STR_DT': _tanggalBerangkatController.text,
      'SPPD_END_DT': _tanggalKembaliController.text,
      'SPPD_OBJ_MEMO': tujuanBisnis,
      'REGN_TP_CD': wilayah,
      'SPPD_STAT_CD': status,
      'GRD_CD': golongan,
      'SPPD_CLS_CD': jabatan,
      'DEST_TP_CD': jenisTujuan,
    };

    try {
      final response = await http.post(
        Uri.parse('http://172.30.1.68/add_pengikut.php'),
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil disimpan'),
          ),
        );

        // Clear form fields after successful submission
        _jenisPengikutController.clear();
        _wilayahController.clear();
        _namaController.clear();
        _noKtpNipController.clear();
        _statusPegawaiController.clear();
        _tipeOrganisasiController.clear();
        _organisasiPengikutController.clear();
        _golonganController.clear();
        _jabatanController.clear();
        _tipeSppdController.clear();
        _jenisTujuanController.clear();
        _berangkatController.clear();
        _tujuanController.clear();
        _tanggalBerangkatController.clear();
        _tanggalKembaliController.clear();
        _berangkatPengikutController.clear();
        _transportasiPengikutController.clear();
        _keteranganLainController.clear();
        _asalPengikutController.clear();
        _tujuanPengikutController.clear();
        _statusController.clear();

        // Navigate to another screen after successful submission
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PengikutAdapter(sppd: widget.sppd)),
        );
      } else {
        // Show error message if the request fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data'),
          ),
        );
      }
    } catch (e) {
      // Handle exceptions from the http request
      print('Error posting data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat menyimpan data'),
        ),
      );
    }
  }
}