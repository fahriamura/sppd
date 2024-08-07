import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sppd/Backend/AlterFunction.dart';

class Provinsi {
  final String Id;
  final String Kode;
  final String Nama;
  final String NamaKota;
  final String kodeKota;


  Provinsi({
    required this.Id,
    required this.Kode,
    required this.Nama,
    required this.NamaKota,
    required this.kodeKota
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {

    return Provinsi(
      Id: json['id'] ?? '',
      Nama: json['namaProv'] ?? '',
      Kode: json['kodeProv'] ?? '',
      NamaKota : json['namaKota'],
      kodeKota : json['kodeKota']
    );
  }
}