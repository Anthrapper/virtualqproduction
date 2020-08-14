import 'package:flutter/material.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';

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
        child: ListView(),
      ),
    );
  }
}
