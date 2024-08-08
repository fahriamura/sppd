import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sppd/Backend/AlterFunction.dart';
import 'package:sppd/Database/Pengikut.dart';
import 'package:sppd/FrontEnd/Pengikut/PengikutCreate.dart';
import 'package:sppd/FrontEnd/Pengikut/pengikutDetail.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppdDetail.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppdMasterCreate.dart';
import 'package:sppd/FrontEnd/TickerProvider/SPPD.dart';
import 'dart:convert';

import '../../Database/Harga.dart';
import '../../Database/PostSppd.dart';
import '../Cost/Cost.dart';
import '../Cost/CostDetail.dart';

bool _isDeleteMode = false;
class PengikutMain extends StatefulWidget {
  const PengikutMain({Key? key, this.animationController, required this.sppd}) : super(key: key);

  final AnimationController? animationController;
  final Sppd sppd;

  @override
  _PengikutMainState createState() => _PengikutMainState();
}

class _PengikutMainState extends State<PengikutMain> with TickerProviderStateMixin {

  late AnimationController animationController;
  late AnimationController _shakeAnimationController;
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  late List<Harga> filteredHargaList;
  late List<Harga> hargaList;
  late List<Pengikut> pengikutList;
  late List<Pengikut> filteredPengikutList;
  @override
  void initState() {
    super.initState();
    _shakeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animationController.forward();
    pengikutList = [];
    hargaList=[];
    filteredHargaList=[];
    filteredPengikutList = [];
    fetchHargaList(widget.sppd.index);// Initialize filteredSppdList
    fetchPengikutList(widget.sppd.index); // Fetch SPPD list on init
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  Future<bool> _showConfirmationDialog(BuildContext context, String sppdNo) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Pengikut'),
          content: Text('Apakah anda yakin ingin menghapus Pengikut No. $sppdNo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  Future<void> fetchPengikutList(String index) async {
    final response = await http.get(
      Uri.parse('http://$api/get_pengikut.php?sppd_mst_seq=$index'),
    );

    if (response.statusCode == 200) {
      List<Pengikut> loadedSppd = [];
      List<dynamic> data = json.decode(response.body);

      data.forEach((item) {
        Pengikut news = Pengikut.fromJson(item);
        loadedSppd.add(news);
      });

      setState(() {
        pengikutList = loadedSppd;
        filteredPengikutList = pengikutList;
      });
    } else {
      throw Exception('Failed to load SPPD');
    }
  }
  Future<void> fetchHargaList(String index) async {
    final response = await http.get(
      Uri.parse('http://$api/get_harga.php?sppd_mst_seq=$index'),
    );
    if (response.statusCode == 200) {
      List<Harga> loadedSppd = [];
      List<dynamic> data = json.decode(response.body);

      data.forEach((item) {
        Harga news = Harga.fromJson(item);
        loadedSppd.add(news);
      });

      setState(() {
        hargaList = loadedSppd;
        filteredHargaList = hargaList;
      });
    } else {
      throw Exception('Failed to load SPPD');
    }
  }



  Widget Header() {
    return Padding(padding:EdgeInsets.only(top: 0,bottom: 0,left: 16,right: 16),
      child:    Container(
        width: double.infinity,
        padding:EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(90),
            bottomRight: Radius.circular(90),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.jpg', height: 60),  // Update with your logo asset
            SizedBox(width: 10),
            Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'BP BATAM',
                    style: TextStyle(
                      color: Color(0xFF10218B),
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Badan Pengusahaan Batam',
                    style: TextStyle(
                      color: Color(0xFFB28000) ,
                      fontSize: 16,
                    ),
                  ),
                ]
            ),


          ],
        ),
      ),
    );


  }

  void filterPengikutList(String query) {
    setState(() {
      filteredPengikutList = pengikutList
          .where((pengikut) =>
      pengikut.Nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    double calculateTotalHarga() {
      double total = 0.0;

      for (Harga item in filteredHargaList) {
        double hargaAsDouble = double.tryParse(item.HargaTotal) ?? 0.0;
        total += hargaAsDouble;
      }

      return total;
    }

    return Column(
      children: <Widget>[
        Header(),
        Expanded(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animationController,
                child: Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    30 * (1.0 - animationController.value),
                    0.0,
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      color: Color(0xFF2B3994),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Data Pengikut',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure space between columns
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'No. SPPD : ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            ResponsiveText(
                                              text: widget.sppd.index + widget.sppd.noSppd,
                                              minFontSize: 8,
                                              maxFontSize: 14,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.clip,
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Berangkat : ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              widget.sppd.berangkat,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Tujuan : ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              widget.sppd.tujuan,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Harga :',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${formatCurrency(calculateTotalHarga())}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.info),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SppdCostDetail(harga: filteredHargaList);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                          ,
                        ),
                        SizedBox(height: 16),
                          Row(
                            children: [
                              // Search Bar
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search, color: Colors.grey),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextField(
                                          controller: searchController,
                                          onChanged: (value) {
                                            filterPengikutList(value);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Nomor SPPD',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // "Cari" Button
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                      child: PengikutCreate(sppd: widget.sppd),
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SppdCostDialog(sppd: widget.sppd);
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow,
                                  ),
                                  child: Icon(Icons.attach_money, color: Colors.white),
                                ),
                              ),
                              // Delete Button
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isDeleteMode = !_isDeleteMode;
                                    if (_isDeleteMode) {
                                      _shakeAnimationController.repeat(reverse: true); // Start shaking animation
                                    } else {
                                      _shakeAnimationController.reset(); // Stop shaking animation
                                    }
                                  });
                                },
                                child: Transform.scale(
                                  scale: _isDeleteMode ? 0.9 : 1.0, // scale down when delete mode is enabled
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _isDeleteMode ? Colors.yellow : Colors.red, // change color when delete mode is enabled
                                    ),
                                    child: Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: filteredPengikutList.isEmpty
                                ? Center(
                              child: Text('No Pengikut data available', style: TextStyle(color: Colors.white)),
                            )
                                : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredPengikutList.length,
                              itemBuilder: (context, index) {
                                final Animation<double> animation =
                                Tween<double>(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval(
                                      (1 / filteredPengikutList.length) * index,
                                      1.0,
                                      curve: Curves.fastOutSlowIn,
                                    ),
                                  ),
                                );
                                return FadeTransition(
                                  opacity: animation,
                                  child: SppdCard(
                                    shakeAnimationController: _shakeAnimationController,
                                    sppd: widget.sppd,
                                    pengikut: filteredPengikutList[index],
                                    statusIcon: index % 2 == 0
                                        ? Icons.check_circle
                                        : Icons.error,
                                    onTap: () async {
                                      if (_isDeleteMode) {
                                        final shouldDelete = await _showConfirmationDialog(
                                            context, filteredPengikutList[index].Id);
                                        if (shouldDelete) {
                                          try {
                                            Map<String, dynamic> requestBody = {
                                              'SPPD_MST_SEQ': filteredPengikutList[index].Id,
                                            };
                                            final response = await http.delete(
                                              Uri.parse('http://$api/del_sppd.php'),
                                              headers: {
                                                'Content-Type': 'application/json',
                                              },
                                              body: jsonEncode(requestBody),
                                            );
                                            print(response.statusCode);
                                            if (response.statusCode == 200) {
                                              print("test ${response.body}");
                                              setState(() {
                                                pengikutList.removeWhere(
                                                        (pengikut) => pengikut.Id == filteredPengikutList[index].Id);
                                              });
                                            } else {
                                              throw Exception('Failed to delete SPPD');
                                            }
                                          } catch (e) {
                                            print('Error deleting SPPD: $e');
                                            // Handle error, show toast, etc.
                                          }
                                        }
                                      } else {
                                        try {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                PengikutDetails(pengikut: filteredPengikutList[index], sppd: widget.sppd),
                                            isScrollControlled: true,
                                          );
                                        } catch (e) {
                                          print('Error fetching last endpoint: $e');
                                          // Handle error, show toast, etc.
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<String> fetchLastEndpoint(String selfUrl) async {
    final response = await http.get(Uri.parse(selfUrl));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return data['_links']['self'][0]['href'];
    } else {
      throw Exception('Failed to load endpoint');
    }
  }
}


class QuarterCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width * 2, size.height * 2),
      0,
      1.5 * 3.14159, // This draws a quarter circle
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class SppdCard extends StatelessWidget {
  final Sppd sppd;
  final Pengikut pengikut;
  final IconData statusIcon;
  final VoidCallback onTap;
  final AnimationController shakeAnimationController;

  SppdCard({
    required this.sppd,
    required this.pengikut,
    required this.statusIcon,
    required this.onTap,
    required this.shakeAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: shakeAnimationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _isDeleteMode
                ? shakeAnimationController.value * 0.05
                : 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWideScreen = constraints.maxWidth > 700;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nama : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              pengikut.Nama,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'ID/No.Ktp : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              pengikut.Id,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Golongan : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              getLastTwoDigits(pengikut.golongan),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}


