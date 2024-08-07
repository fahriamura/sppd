import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sppd/Backend/AlterFunction.dart';

import '../../Database/Employee.dart';
import '../../Database/Pengikut.dart';
import '../../Database/PostSppd.dart';

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
  Employee? selectedEmployee;
  List<Employee> employee =[];
  List<String> provinsiList = [];
  List<String> kotaList =[];
  List<String> kodeProvinsi= [];
  List<String> kodeKota=[];
  late String noKtp = '';
  late String jabatan = '';
  late String status = '';
  late String golongan='';
  List<String> wilayah = ['Domestik'];
  List<String> TipeSPPD = ['SPPD Pegawai OB Tupoksi'];
  List<String> JenisSPPD = ['Otorita Batam'];
  late List<Pengikut> pengikutList;
  late List<Pengikut> filteredPengikutList;
  late List<Sppd> sppdList;
  late List<Sppd> filteredSppdList;
  late List<Pengikut> pengikutValidate;
  Future<void> fetchSppdList() async {
    final response = await http.get(
      Uri.parse('http://$api/get_sppd.php'),
    );

    if (response.statusCode == 200) {
      List<Sppd> loadedSppd = [];
      List<dynamic> data = json.decode(response.body);

      data.forEach((item) {
        Sppd news = Sppd.fromJson(item);
        loadedSppd.add(news);
      });

      setState(() {
        sppdList = loadedSppd;
        print('aas $sppdList');
        filteredSppdList = sppdList;
      });
    } else {
      throw Exception('Failed to load SPPD');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchProvinsiList();
    fetchPengikutList(widget.sppd.index);
    fetchEmployee();
    pengikutList = [];
    filteredPengikutList = [];
    sppdList = [];
    filteredSppdList = []; // Initialize filteredSppdList
    fetchSppdList();
  }
  void fetchEmployee() async {
    String url = 'http://$api/get_employee.php';
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Employee> tempList = [];
        jsonResponse.forEach((employeeJson) {
          Employee employee = Employee.fromJson(employeeJson);
          tempList.add(employee);
        });
        employee = tempList; // Assign parsed employees to the employee list
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching employee data: $e');
    }
  }
  Future<void> fetchPengikutList(String index) async {
    final response = await http.get(
      Uri.parse('http://$api/get_pengikut.php?sppd_mst_seq=$index'),
    );

    if (response.statusCode == 200) {
      List<Pengikut> loadedSppd = [];
      List<dynamic> data = json.decode(response.body);

      data.forEach((item) {
        Pengikut news = Pengikut.fromJson(item);
        loadedSppd.add(news);
      });

      setState(() {
        pengikutList = loadedSppd;
        filteredPengikutList = pengikutList;
      });
    } else {
      throw Exception('Failed to load SPPD');
    }
  }


  void fetchProvinsiList() async {
    String url = 'http://$api/get_kota.php';
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
  void _showJenis(TextEditingController controller) async {
    String? selectedTransportasi = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String initialValue = controller.text;
        String? selectedValue = initialValue;
        String displayValue = initialValue;


        // Filtered list based on search query
        List<String> filteredTransportasiList = List.from(JenisSPPD);

        return AlertDialog(
          title: Text('Jenis SPPD :'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
  void _showWilayah(TextEditingController controller) async {
    String? selectedTransportasi = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String initialValue = controller.text;
        String? selectedValue = initialValue;
        String displayValue = initialValue;


        // Filtered list based on search query
        List<String> filteredTransportasiList = List.from(wilayah);

        return AlertDialog(
          title: Text('Pilih Wilayah'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
  void _showTipe(TextEditingController controller) async {
    String? selectedTransportasi = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String initialValue = controller.text;
        String? selectedValue = initialValue;
        String displayValue = initialValue;


        // Filtered list based on search query
        List<String> filteredTransportasiList = List.from(TipeSPPD);

        return AlertDialog(
          title: Text('Tipe SPPD :'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
  void _selectEmployeeDialog(TextEditingController controller) async {
    String? selectedEmployee = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? initialValue = controller.text;
        String? selectedValue = initialValue;

        // Filtered list based on search query
        List<Employee> filteredEmployeeList = List.from(employee);

        return AlertDialog(
          title: Text('Pilih Employee'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Nama...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredEmployeeList = employee
                            .where((emp) => emp.Nama.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 300,
                    width: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: filteredEmployeeList.map((emp) {
                          return ListTile(
                            title: Text(emp.Nama),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Golongan: ${getLastTwoDigits(emp.golongan)}'),
                                Text('Jabatan: ${convertPostToDisplay(emp.jabatan)}'),
                                Text('Status: ${convertPostToDisplay(emp.statusPegawai)}'),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedValue = emp.Nama;
                                noKtp = emp.Id;
                                golongan = emp.golongan;
                                jabatan = emp.jabatan;
                                status = emp.statusPegawai;
                              });
                              Navigator.of(context).pop(selectedValue);
                            },
                            selected: emp.Nama == initialValue,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    // Update text controller if an employee is selected
    if (selectedEmployee != null) {
      controller.text = selectedEmployee;
    }
  }


  @override
  Widget build(BuildContext context) {

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
    return  SingleChildScrollView(
      child : Container(
        width: double.infinity,
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
                        TextFormField(
                          controller: _namaController,
                          readOnly: true,
                          decoration: InputDecoration(labelText: 'Nama'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          onTap:(){ _selectEmployeeDialog(_namaController);},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            if (pengikutList.any((pengikut) => pengikut.Nama == value)) {
                              return 'Nama tersebut sudah terdaftar';
                            }

                            for (var sppd in filteredSppdList) {
                              List<Pengikut> pengikuts = [];
                              Future<void> fetchPengikut(String index) async {
                                List<Pengikut> loadedSppd = [];
                                final response = await http.get(
                                  Uri.parse('http://$api/get_pengikut.php?sppd_mst_seq=$index'),
                                );

                                if (response.statusCode == 200) {
                                  List<dynamic> data = json.decode(response.body);
                                  data.forEach((item) {
                                    Pengikut news = Pengikut.fromJson(item);
                                    loadedSppd.add(news);
                                  });
                                  setState(() {
                                    pengikuts = loadedSppd;

                                  });
                                } else {
                                  throw Exception('Failed to load Pengikut');
                                }
                              }

                              for (var pengikut in pengikuts) {
                                if (pengikut.Nama == value) {
                                  if (pengikut.periodeAkhir != null &&
                                      sppd.tanggalMulai != null &&
                                      sppd.tanggalAkhir != null &&
                                      pengikut.periodeAkhir!.isAfter(sppd.tanggalMulai!)) {
                                    return 'Nama tersebut sedang dalam perjalanan';
                                  }
                                }
                              }
                            }
                            return null;
                          },
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
                        TextFormField(
                          controller: _jenisPengikutController,
                          readOnly: true,
                          onTap: (){
                            _showJenis(_jenisPengikutController);
                          },
                          decoration: InputDecoration(labelText: 'Jenis Pengikut'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _wilayahController,
                          readOnly: true,
                          decoration: InputDecoration(labelText: 'Wilayah'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          onTap:(){ _showWilayah(_wilayahController);},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;

                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          controller: _tipeSppdController,
                          decoration: InputDecoration(labelText: 'Tipe Sppd'),
                          onTap: (){
                            _showTipe(_tipeSppdController);
                          },
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;

                          },
                        )
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
                        TextFormField(
                          controller: _tanggalBerangkatController,
                          decoration: InputDecoration(labelText: 'Tanggal Berangkat'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;

                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _tanggalKembaliController,
                          decoration: InputDecoration(labelText: 'Tanggal Kembali'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _keteranganLainController,
                          decoration: InputDecoration(
                            labelText: 'Tujuan Bisnis',
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),

                          ),

                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: null,
                          minLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi data dengan benar';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                submitForm(context);
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),

        ),
      )
    );

  }

  void submitForm(BuildContext context) async {
    // Extracting and formatting data
    final String Jenis = _jenisPengikutController.text;
    final String Nama = _namaController.text;
    final String tipe = _tipeSppdController.text;
    final String tujuanBisnis = _keteranganLainController.text;
    final String wilayah = _wilayahController.text;
    final String jenisTujuan = _jenisTujuanController.text;

    // Prepare the request body
    final Map<String, dynamic> body = {
      'PTCPNT_ID': noKtp,
      'SPPD_MST_SEQ': widget.sppd.index,
      'PTCPNT_TP_CD': convertTransportasiDisplayToPost(Jenis),
      'PTCPNT_NM': Nama,
      'GVRMT_ORG_NM': widget.sppd.organisasi,
      'SPPD_TP_CD': convertTransportasiDisplayToPost(tipe),
      'ORG_MGMT_NO': widget.sppd.kodeBerangkat,
      'SPPD_ORG_MEMO': widget.sppd.berangkat,
      'DEST_MGMT_NO': widget.sppd.kodeTujuan,
      'SPPD_DEST_MEMO': widget.sppd.tujuan,
      'SPPD_STR_DT': _tanggalBerangkatController.text,
      'SPPD_END_DT': _tanggalKembaliController.text,
      'SPPD_OBJ_MEMO': tujuanBisnis,
      'REGN_TP_CD': convertTransportasiDisplayToPost(wilayah),
      'SPPD_STAT_CD': status,
      'GRD_CD': golongan,
      'SPPD_CLS_CD': jabatan,
      'DEST_TP_CD': convertPostToDisplay("Dalam Kota"),
    };

    try {
      final response = await http.post(
        Uri.parse('http://$api/add_pengikut.php'),
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