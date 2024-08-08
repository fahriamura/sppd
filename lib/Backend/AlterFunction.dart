
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const String api = "172.30.2.193";

String convertTransportasiDisplayToPost(String displayValue) {
  switch (displayValue) {
    case 'Pesawat':
      return 'C8001';
    case 'Domestik':
      return 'D0001';
    case 'Sppd Pegawai OB Tupoksi':
      return 'SPPD1';
    case 'Otorita Batam':
      return 'JP1';
    case 'Dalam Kota':
      return 'DKM11';
    case 'Pusat Data dan Sistem Informasi':
      return 'PDSI';
    case 'Internal':
      return 'INTR';
    case 'External':
      return 'EXTR';
    case 'Complete':
      return '0001';
    case 'Menunggu':
      return '0000';

    default:
      return displayValue;
  }
}

String getLastTwoDigits(String input) {
  if (input.length >= 2) {
    return input.substring(input.length - 2);
  } else {
    return input;
  }
}

String convertPostToDisplay(String displayValue) {
  switch (displayValue) {
    case 'C8001':
      return 'Pesawat';
    case 'C1901':
      return 'Staff';
    case 'C3802' || 'C3801':
      return 'P2K Pelaksana';
    case 'D0001':
      return 'Domestik';
    case 'SPPD1':
      return 'Sppd Pegawai OB Tupoksi';
    case 'JP1':
      return 'Otorita Batam';
    case 'DKM11':
      return 'Dalam Kota';
    case 'PDSI':
      return 'Pusat Data dan Sistem Informasi';
    case 'INTR':
      return 'Internal';
    case 'EXTR':
      return 'External';
    case '0001':
      return 'Complete';
    case '0000':
      return 'Menunggu';
    case Null || '':
      return "Tidak Ada";
    default:
      return displayValue;
  }
}

String formatCurrency(double amount) {
  final numberFormat = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2);
  return numberFormat.format(amount);
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final double minFontSize;
  final double maxFontSize;
  final TextStyle style;
  final TextOverflow overflow;

  ResponsiveText({
    required this.text,
    required this.minFontSize,
    required this.maxFontSize,
    required this.style,
    required this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = (screenWidth / 10).clamp(minFontSize, maxFontSize);

    return Flexible(
      child: Text(
        text,
        style: style.copyWith(fontSize: fontSize),
        overflow: overflow,
      ),
    );
  }
}
