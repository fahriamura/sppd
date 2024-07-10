import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sppd/Backend/AlterFunction.dart';

class Provinsi {
  final String Id;
  final String Kode;
  final String Nama;

  Provinsi({
    required this.Id,
    required this.Kode,
    required this.Nama,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {

    return Provinsi(
      Id: json['id'],
      Nama: json['nama'] ?? '',
      Kode: json['kode'],
    );
  }
}