import 'package:flutter/material.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class Token extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            'Token Deatails',
            style: TextStyle(
              fontSize: 18,
              color: Colors.lightBlue[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ReusableWidgets().customText('Name: xyz'),
        ReusableWidgets().customText('Purpose: xyz'),
        ReusableWidgets().customText('Date & Time: xyz'),
        ReusableWidgets().customText('Token Number: xyz'),
      ],
    );
  }
}
