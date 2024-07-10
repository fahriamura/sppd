import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sppd/Backend/AlterFunction.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppd.dart';

import '../../Database/Provinsi.dart';
import '../TickerProvider/SPPD.dart';
class SppdCreate extends StatefulWidget {
  @override
  _SppdCreateState createState() => _SppdCreateState();
}

class _SppdCreateState extends State<SppdCreate> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('yyyyMMdd');
  final _noSppdController = TextEditingController();
  final _tanggalDikeluarkanController = TextEditingController();
  final _tanggalPermohonanController = TextEditingController();
  final _tanggalMulaiController = TextEditingController();
  final _tanggalAkhirController = TextEditingController();
  final _tipeOrganisasiController = TextEditingController();
  final _transportasiController = TextEditingController();
  final _statusController = TextEditingController();
  final _organisasiController = TextEditingController();
  final _berangkatController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _maksudController = TextEditingController();

  DateTime? _tanggalDikeluarkan;
  DateTime? _tanggalPermohonan;
  DateTime? _tanggalMulai;
  DateTime? _tanggalAkhir;

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
  void _showProvinsiDialog(TextEditingController controller, String Kode) async {
    String? selectedProvinsi = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String initialValue = controller.text;
        String? selectedValue = initialValue;

        // Filtered list based on search query
        List<String> filteredProvinsiList = List.from(provinsiList);
        return AlertDialog(
          title: Text('Pilih Provinsi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari provinsi...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    filteredProvinsiList = provinsiList
                        .where((provinsi) =>
                        provinsi.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              SizedBox(height: 10),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: filteredProvinsiList.map((provinsi) {
                      int index = provinsiList.indexOf(provinsi);
                      String kodeProvinsiSelected = kodeProvinsi[index];
                      return ListTile(
                        title: Text(provinsi),
                        onTap: () {
                          selectedValue = provinsi;
                          setState(() {
                            Kode = kodeProvinsiSelected; // Update Kode here
                            if (controller == _berangkatController) {
                              kodeBerangkat = kodeProvinsiSelected; // Update kodeBerangkat
                            } else if (controller == _tujuanController) {
                              kodeTujuan = kodeProvinsiSelected; // Update kodeTujuan
                            }
                          });
                          Navigator.of(context).pop(selectedValue);
                        },
                        selected: provinsi == initialValue,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Update text controller if a province is selected
    if (selectedProvinsi != null) {
      controller.text = selectedProvinsi;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> transportasiList = ['Pesawat'];




    void _showTransportasi(TextEditingController controller) async {
      String? selectedTransportasi = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          String initialValue = controller.text;
          String? selectedValue = initialValue;
          String displayValue = initialValue;


          // Filtered list based on search query
          List<String> filteredTransportasiList = List.from(transportasiList);

          return AlertDialog(
            title: Text('Pilih Transportasi'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari transportasi...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredTransportasiList = transportasiList
                          .where((transportasi) =>
                          transportasi.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                SizedBox(height: 10),
                Container(
                  height: 300, // Adjust height as needed
                  child: SingleChildScrollView(
                    child: Column(
                      children: filteredTransportasiList.map((transportasi) {
                        return ListTile(
                          title: Text(transportasi),
                          onTap: () {
                            selectedValue = transportasi;
                            Navigator.of(context).pop(selectedValue);
                          },
                          selected: transportasi == initialValue,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (selectedTransportasi != null) {
        String displayText = selectedTransportasi.replaceAll('C8001', 'Pesawat');
        controller.text = displayText;
        String postValue = displayText.replaceAll('Pesawat', 'C8001');

      }
    }





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
                      Text('No. SPPD', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _noSppdController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan No. SPPD';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Dikeluarkan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          readOnly: true,
                          controller: _tanggalDikeluarkanController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalDikeluarkan,
                                  (date) {
                                setState(() {
                                  _tanggalDikeluarkan = date;
                                  _tanggalDikeluarkanController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Tanggal Dikeluarkan';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Permohonan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          readOnly: true,
                          controller: _tanggalPermohonanController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalPermohonan,
                                  (date) {
                                setState(() {
                                  _tanggalPermohonan = date;
                                  _tanggalPermohonanController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Tanggal Permohonan';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Mulai', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          readOnly: true,
                          controller: _tanggalMulaiController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalMulai,
                                  (date) {
                                setState(() {
                                  _tanggalMulai = date;
                                  _tanggalMulaiController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Tanggal Mulai';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Akhir', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          readOnly: true,
                          controller: _tanggalAkhirController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: () async {
                            final selectedDate = await selectDate(
                              context,
                              _tanggalAkhir,
                                  (date) {
                                setState(() {
                                  _tanggalAkhir = date;
                                  _tanggalAkhirController.text =
                                      _dateFormat.format(date);
                                });
                              },
                            );
                            print(_tanggalAkhir);
                          },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Tanggal Akhir';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tipe Organisasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _tipeOrganisasiController,
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
                      Text('Transportasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _transportasiController,
                          readOnly: true,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Transportasi';
                            }
                            return null;
                          },
                          onTap: (){
                            _showTransportasi(_transportasiController);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Status', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _statusController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Status';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          controller: _organisasiController,
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          controller: _berangkatController,
                          readOnly: true,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: (){
                            _showProvinsiDialog(_berangkatController,kodeBerangkat);

                          },
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
                          controller: _tujuanController,
                          readOnly: true,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          onTap: (){
                            _showProvinsiDialog(_tujuanController,kodeTujuan);

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Maksud', style: TextStyle(color: Colors.black)),
                      Container(
                        width: double.infinity,
                        height: 100,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: TextFormField(
                          controller: _maksudController,
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 10),
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
    final noSppd = _noSppdController.text;
    final tanggalDikeluarkan = _tanggalDikeluarkanController.text;
    final tanggalPermohonan = _tanggalPermohonanController.text;
    final tanggalMulai = _tanggalMulaiController.text;
    final tanggalAkhir = _tanggalAkhirController.text;
    final tipeOrganisasi = _tipeOrganisasiController.text;
    final transportasi = convertTransportasiDisplayToPost(_transportasiController.text);;
    final status = _statusController.text;
    final organisasi = _organisasiController.text;
    final berangkat = _berangkatController.text;
    final tujuan = _tujuanController.text;
    final maksud = _maksudController.text;



    final response = await http.post(
      Uri.parse('http://172.30.1.68/add_sppd.php'),
      body: {
        'SPPD_DOC_NO': noSppd,
        'SPPD_ISSU_DT': tanggalDikeluarkan,
        'RQEST_DT': tanggalPermohonan,
        'SPPD_STR_DT': tanggalMulai,
        'SPPD_END_DT': tanggalAkhir,
        'ORG_CD': tipeOrganisasi,
        'TRSPT_CD': transportasi,
        'STAT_CD': status,
        'ORG_NM': organisasi,
        'ORG_MGMT_NO' : kodeBerangkat,
        'SPPD_ORG_MEMO': berangkat,
        'DEST_MGMT_NO' : kodeTujuan,
        'SPPD_DEST_MEMO': tujuan,
        'PURPS_CNTT': maksud,
      },
    );
    print(kodeBerangkat);
    print(kodeTujuan);
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil disimpan'),
        ),
      );

      // Clear form fields after submission
      _noSppdController.clear();
      _tanggalDikeluarkanController.clear();
      _tanggalPermohonanController.clear();
      _tanggalMulaiController.clear();
      _tanggalAkhirController.clear();
      _tipeOrganisasiController.clear();
      _transportasiController.clear();
      _statusController.clear();
      _organisasiController.clear();
      _berangkatController.clear();
      _tujuanController.clear();
      _maksudController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SppdAdapter()),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data'),
        ),
      );
    }
  }
}