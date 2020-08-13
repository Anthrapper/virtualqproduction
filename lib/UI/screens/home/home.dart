import 'package:flutter/material.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/drawer.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Home'),
      drawer: Drawer(
        elevation: 10,
        child: drawerItems,
      ),
      body: Column(
        children: [
          FadeAnimation(
            0.5,
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ReusableWidgets()
                  .customImage(context, 'assets/images/waiting.png'),
            ),
          ),
          FadeAnimation(
            1,
            Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: ReusableWidgets().customButton(context, 'New Appointment'),
            ),
          ),
          FadeAnimation(
            1.1,
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: ReusableWidgets()
                  .customButton(context, 'Current Appointments'),
            ),
          ),
        ],
      ),
    );
  }
}
