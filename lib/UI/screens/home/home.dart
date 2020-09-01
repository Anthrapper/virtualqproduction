import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/drawer.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class HomePage extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Home'),
      drawer: Drawer(
        elevation: 10,
        child: MyDrawer(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 50),
            child: _reusableWidgets.customSvg('assets/images/home.svg'),
          ),
          FadeAnimation(
            1,
            Padding(
              padding: EdgeInsets.fromLTRB(40, 50, 40, 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'bankselection');
                },
                child: ReusableWidgets().customButton('Generate New Token'),
              ),
            ),
          ),
          FadeAnimation(
            1.1,
            Padding(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/currentappointments');
                },
                child: _reusableWidgets.customButton('Current Tokens'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
