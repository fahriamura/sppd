import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sppd/sppdDetail.dart';
import 'package:sppd/sppdMasterCreate.dart';

class SPPDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SppdCreate(),
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
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4, // Adjust the number of items based on your data
                  itemBuilder: (context, index) {
                    return SppdCard(
                      statusIcon: index % 2 == 0 ? Icons.check_circle : Icons.error,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SppdDetails(),
                          isScrollControlled: true,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 90,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomPaint(
                    size: Size(200, 200), // Adjust the size as needed
                    painter: QuarterCirclePainter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90),
          bottomRight: Radius.circular(90),
        ),
      ),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 60),  // Update with your logo asset
          SizedBox(height: 8),
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
        ],
      ),
    );
  }
}

class SppdCard extends StatefulWidget {
  final IconData statusIcon;
  final VoidCallback onTap;

  SppdCard({required this.statusIcon, required this.onTap});

  @override
  _SppdCardState createState() => _SppdCardState();
}

class _SppdCardState extends State<SppdCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideUpTransition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideUpTransition = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
            if (isWideScreen) {
              _controller.reverse();
            } else {
              _controller.forward();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransition(
                  position: _slideUpTransition,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No. SPPD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '14/SPPD/03/2024',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
                              '23-06-2024',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Icon(Icons.home, color: Colors.white),
                          ],
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              '25-06-2024',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Icon(Icons.airplanemode_active, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Icon(widget.statusIcon, color: Colors.white, size: 24),
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
                                  '23-06-2024',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                Icon(Icons.home, color: Colors.white),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Text(
                                  '25-06-2024',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                Icon(Icons.airplanemode_active, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                        Icon(widget.statusIcon, color: Colors.white, size: 24),
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
  }
}

