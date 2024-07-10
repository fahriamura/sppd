import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sppd/Database/Pengikut.dart';
import 'package:sppd/FrontEnd/Pengikut/PengikutCreate.dart';
import 'package:sppd/FrontEnd/Pengikut/pengikutDetail.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppdDetail.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppdMasterCreate.dart';
import 'package:sppd/FrontEnd/TickerProvider/SPPD.dart';
import 'dart:convert';

import '../../Database/PostSppd.dart';

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
    filteredPengikutList = []; // Initialize filteredSppdList
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
      Uri.parse('http://172.30.7.252/get_pengikut.php?sppd_mst_seq=$index'),
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

  Widget Header() {
    return Padding(padding:EdgeInsets.only(top: 0,bottom: 0,left: 16,right: 16),
      child:    Container(
        width: double.infinity,
        padding:EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(90),
            bottomRight: Radius.circular(90),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.jpg', height: 60),  // Update with your logo asset
            SizedBox(width: 10),
            Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'BP BATAM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Badan Pengusahaan Batam',
                    style: TextStyle(
                      color: Colors.white,
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        Row(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => PengikutCreate(sppd: widget.sppd),
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
                setState(() {
                  _isDeleteMode =!_isDeleteMode;
                  if (_isDeleteMode) {
                    _shakeAnimationController.repeat(reverse: true); // Start shaking animation
                  } else {
                    _shakeAnimationController.reset(); // Stop shaking animation
                  }
                });
              },
              child: Transform.scale(
                scale: _isDeleteMode? 0.9 : 1.0, // scale down when delete mode is enabled
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isDeleteMode? Colors.yellow : Colors.red, // change color when delete mode is enabled
                  ),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            )
          ],
        ),
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: filteredPengikutList.isEmpty
                          ? Center(
                        child: Text('No SPPD data available'),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                          return SppdCard(
                            shakeAnimationController: _shakeAnimationController,
                            sppd: widget.sppd,
                            pengikut: filteredPengikutList[index],
                            statusIcon: index % 2 == 0
                                ? Icons.check_circle
                                : Icons.error,
                            onTap: () async {
                              if (_isDeleteMode) {
                                final shouldDelete = await _showConfirmationDialog(context, filteredPengikutList[index].Id);
                                if (shouldDelete) {
                                  try {
                                    Map<String, dynamic> requestBody = {
                                      'SPPD_MST_SEQ':  filteredPengikutList[index].Id,
                                    };
                                    final response = await http.delete(
                                      Uri.parse('http://172.30.7.252/del_sppd.php'),
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                      body: jsonEncode(requestBody),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print("test ${response.body}");
                                      setState(() {
                                        pengikutList.removeWhere((pengikut) => pengikut.Id == filteredPengikutList[index].Id);
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
                                    builder: (context) => PengikutDetails(pengikut: filteredPengikutList[index], sppd: widget.sppd),
                                    isScrollControlled: true,
                                  );
                                } catch (e) {
                                  print('Error fetching last endpoint: $e');
                                  // Handle error, show toast, etc.
                                }
                              }
                            },
                          );
                        },
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
                ? shakeAnimationController.value * 0.05 // Adjust the shaking amplitude as needed
                : 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWideScreen = constraints.maxWidth > 700;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        pengikut.Nama,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      isWideScreen
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    sppd.tanggalMulai != null
                                        ? DateFormat('yyyy-MM-dd').format(sppd.tanggalMulai!)
                                        : '-',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  Icon(Icons.home, color: Colors.white),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    sppd.tanggalAkhir != null
                                        ? DateFormat('yyyy-MM-dd').format(sppd.tanggalAkhir!)
                                        : '-',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  Icon(Icons.airplanemode_active, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 40),
                          Icon(statusIcon, color: Colors.white, size: 24),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        sppd.tanggalMulai != null
                                            ? DateFormat('yyyy-MM-dd').format(sppd.tanggalMulai!)
                                            : '-',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      Icon(Icons.home, color: Colors.white),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    children: [
                                      Text(
                                        sppd.tanggalAkhir != null
                                            ? DateFormat('yyyy-MM-dd').format(sppd.tanggalAkhir!)
                                            : '-',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      Icon(Icons.airplanemode_active, color: Colors.white),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(statusIcon, color: Colors.white, size: 24),
                            ],
                          ),
                          SizedBox(height: 16),
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


