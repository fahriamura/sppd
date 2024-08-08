import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sppd/Backend/AlterFunction.dart';

class Harga {
  String HargaTotal;
  String jumlahBarang;
  String namaBarang;

  Harga({
    required this.HargaTotal,
    required this.jumlahBarang,
    required this.namaBarang,
  });

  factory Harga.fromJson(Map<String, dynamic> json) {

    return Harga(
      HargaTotal: json['SPPD_FEE_AMT'],
      jumlahBarang: json['ITEM_QTY'] ?? '',
      namaBarang: json['SPPD_ITEM_NM'],
    );
  }
  void update(int additionalJumlah, int additionalHarga) {
    int updatedJumlah = int.parse(jumlahBarang) + additionalJumlah;
    int updatedHarga = int.parse(HargaTotal) + additionalHarga;

    jumlahBarang = updatedJumlah.toString();
    HargaTotal = updatedHarga.toString();
  }
}