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
      Id: json['EMP_ID'],
      Nama: json['EMP_NM'] ?? '',
      statusPegawai: json['OFFCR_TP_CD'],
      golongan: json['GRD_CD'],
      jabatan: json['WORK_TP_CD'],
    );
  }
}