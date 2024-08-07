import 'package:flutter/material.dart';
import 'package:sppd/Database/PostSppd.dart';
import 'package:sppd/FrontEnd/SppdMaster/sppd.dart';


class SppdAdapter extends StatefulWidget {

  const SppdAdapter({Key? key}) : super(key: key);

  @override
  _SppdAdapterState createState() => _SppdAdapterState();
}

class _SppdAdapterState extends State<SppdAdapter>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  Widget tabBody = Container(
    color: Colors.blue,
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    tabBody = SppdMain();

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF2F3F8),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Stack(
                    children: <Widget>[
                      tabBody,
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

}
