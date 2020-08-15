import 'package:flutter/material.dart';
import 'package:virtualQ/UI/screens/Token/token.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class CurrentAppointments extends StatefulWidget {
  @override
  _CurrentAppointmentsState createState() => _CurrentAppointmentsState();
}

class _CurrentAppointmentsState extends State<CurrentAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Current Appointments'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            ReusableWidgets().customContainer(
              Token(),
            )
          ],
        ),
      ),
    );
  }
}
