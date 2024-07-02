import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SppdDetails extends StatelessWidget {
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
                        '14/SPPD/03/2024',
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
                        '22-06-2003',
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
                        '22-06-2003',
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
                        '22-06-2003',
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
                        '22-06-2003',
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
                        'Internal',
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
                        'Pesawat',
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
                        'Selesai',
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
                        'Pusat Data dan Informasi',
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
                        'Kepulauan Riau',
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
                        'Jawa Barat',
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
                  'Uppacara Kemerdakaan',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}