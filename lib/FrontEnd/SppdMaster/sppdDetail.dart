import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Database/PostSppd.dart';
import '../TickerProvider/PengikutAdapter.dart';

class SppdDetails extends StatelessWidget {
  final Sppd sppd; // Declare Sppd object as a field

  SppdDetails({required this.sppd}); // Constructor to receive Sppd object

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text('No. SPPD', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.noSppd,
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
              Expanded(
                child: Column(
                  children: [
                    Text('Tanggal Dikeluarkan', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tanggalDikeluarkan != null ? sppd.tanggalDikeluarkan!.toString().substring(0, 10) : '',
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
              Expanded(
                child: Column(
                  children: [
                    Text('Tanggal Permohonan', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tanggalPermohonan != null ? sppd.tanggalPermohonan!.toString().substring(0, 10) : '',
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
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Tanggal Mulai', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tanggalMulai != null ? sppd.tanggalMulai!.toString().substring(0, 10) : '',
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
              Expanded(
                child: Column(
                  children: [
                    Text('Tanggal Akhir', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tanggalAkhir != null ? sppd.tanggalAkhir!.toString().substring(0, 10) : '',
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
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Tipe Organisasi', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tipeOrganisasi,
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
              Expanded(
                child: Column(
                  children: [
                    Text('Transportasi', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.transportasi,
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
              Expanded(
                child: Column(
                  children: [
                    Text('Status', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.status,
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
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Organisasi', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 160,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.organisasi,
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
          SizedBox(height: 10,),
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
                        sppd.berangkat,
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
              Expanded(
                child: Column(
                  children: [
                    Text('Tujuan', style: TextStyle(color: Colors.black)),
                    Container(
                      width: 130,
                      padding: EdgeInsets.all(5),
                      color: Colors.grey[300],
                      child: Text(
                        sppd.tujuan,
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
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Maksud', style: TextStyle(color: Colors.black)),
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.all(5),
                color: Colors.grey[300],
                child: Text(
                  sppd.maksud,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PengikutAdapter(sppd: sppd)),
                    );
                  },
                  child: Text(
                    'Tampilkan Pengikut >',
                    style: TextStyle(
                      color: Colors.blue, // Adjust the color as needed
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
