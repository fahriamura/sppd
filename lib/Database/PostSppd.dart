import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Sppd {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final String index;
  final String noSppd;
  final DateTime? tanggalDikeluarkan;
  final DateTime? tanggalPermohonan;
  final DateTime? tanggalMulai;
  final DateTime? tanggalAkhir;
  final String tipeOrganisasi;
  final String transportasi;
  final String status;
  final String organisasi;
  final String berangkat;
  final String tujuan;
  final String maksud;

  Sppd({
    required this.index,
    required this.noSppd,
    required this.tanggalDikeluarkan,
    required this.tanggalPermohonan,
    required this.tanggalMulai,
    required this.tanggalAkhir,
    required this.tipeOrganisasi,
    required this.transportasi,
    required this.status,
    required this.organisasi,
    required this.berangkat,
    required this.tujuan,
    required this.maksud,
  });

  factory Sppd.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr != null) {
        try {
          return DateTime.parse(dateStr);
        } catch (e) {
          print('Error parsing date: $dateStr, $e');
        }
      }
      return null;
    }

    return Sppd(
      index: json['SPPD_MST_SEQ'],
      noSppd: json['SPPD_DOC_NO'] ?? '',
      tanggalDikeluarkan: parseDate(json['SPPD_ISSU_DT']),
      tanggalPermohonan: parseDate(json['RQEST_DT']),
      tanggalMulai: parseDate(json['SPPD_STR_DT']),
      tanggalAkhir: parseDate(json['SPPD_END_DT']),
      tipeOrganisasi: json['ORG_CD'] ?? '',
      transportasi: json['TRSPT_CD'] ?? '',
      status: json['STAT_CD'] ?? '',
      organisasi: json['ORG_NM'] ?? '',
      berangkat: json['SPPD_ORG_MEMO'] ?? '',
      tujuan: json['SPPD_DEST_MEMO'] ?? '',
      maksud: json['PURPS_CNTT'] ?? '',
    );
  }


  void submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('http://172.30.6.153/add_sppd.php'),
        body: {
          'SPPD_DOC_NO': noSppd,
          'SPPD_ISSU_DT': tanggalDikeluarkan != null
              ? _dateFormat.format(tanggalDikeluarkan!)
              : '',
          'RQEST_DT': tanggalPermohonan != null
              ? _dateFormat.format(tanggalPermohonan!)
              : '',
          'SPPD_STR_DT': tanggalMulai != null
              ? _dateFormat.format(tanggalMulai!)
              : '',
          'SPPD_END_DT': tanggalAkhir != null
              ? _dateFormat.format(tanggalAkhir!)
              : '',
          'ORG_CD': tipeOrganisasi,
          'TRSPT_CD': transportasi,
          'STAT_CD': status,
          'ORG_NM': organisasi,
          'SPPD_ORG_MEMO': berangkat,
          'SPPD_DEST_MEMO': tujuan,
          'PURPS_CNTT': maksud,
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan data SPPD')),
        );
      }
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
}
