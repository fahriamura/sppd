import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sppd/Backend/AlterFunction.dart';

import '../../Database/Pengikut.dart';
import '../../Database/PostSppd.dart';
import '../TickerProvider/PengikutAdapter.dart';

class PengikutDetails extends StatelessWidget {
  final Pengikut pengikut;
  final Sppd sppd;

  PengikutDetails({required this.pengikut, required this.sppd});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                      Text('Jenis Pengikut', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.Jenis),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Wilayah', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.wilayah),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
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
                      Text('Nama', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.Nama,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('No.KTP/NIP', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.Id,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Status Pegawai', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.status),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
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
                      Text('Organisasi', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.Organisasi,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Golongan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          getLastTwoDigits(pengikut.golongan),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Jabatan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.jabatan),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tipe SPPD', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.tipe),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Jenis Tujuan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 160,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          convertPostToDisplay(pengikut.jenisTujuan),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Berangkat', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.berangkat,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tujuan', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.tujuan,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Berangkat', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.periodeAwal.toString().substring(0, 10),  // Ensure it's converted to String
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Tanggal Kembali', style: TextStyle(color: Colors.black)),
                      Container(
                        width: 130,
                        padding: EdgeInsets.all(5),
                        color: Colors.grey[300],
                        child: Text(
                          pengikut.periodeAkhir.toString().substring(0, 10),  // Ensure it's converted to String
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
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
                Text('Tujuan Business Trip', style: TextStyle(color: Colors.black)),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: EdgeInsets.all(5),
                  color: Colors.grey[300],
                  child: Text(
                    pengikut.tujuanBisnis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
