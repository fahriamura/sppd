import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sppd/Backend/AlterFunction.dart';

class Pesawat {
  final String Asal;
  final String Tujuan;
  final String Harga;


  Pesawat({
    required this.Asal,
    required this.Tujuan,
    required this.Harga,
  });

  factory Pesawat.fromJson(Map<String, dynamic> json) {

    return Pesawat(
      Asal: json['Asal'],
      Tujuan: json['Tujuan'] ?? '',
      Harga: json['harga'],
    );
  }
}