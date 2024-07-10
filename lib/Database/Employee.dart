import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sppd/Backend/AlterFunction.dart';

class Employee {
  final String Id;
  final String Nama;
  final String statusPegawai;
  final String golongan;
  final String jabatan;

  Employee({
    required this.Id,
    required this.Nama,
    required this.statusPegawai,
    required this.golongan,
    required this.jabatan,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {

    return Employee(
      Id: json['SPPD_MST_SEQ'],
      Nama: json['SPPD_DOC_NO'] ?? '',
      statusPegawai: json['SPPD_ISSU_DT'],
      golongan: json['RQEST_DT'],
      jabatan: json['SPPD_STR_DT'],
    );
  }
}