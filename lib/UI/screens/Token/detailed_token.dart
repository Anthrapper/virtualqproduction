import 'package:flutter/material.dart';

import 'package:virtualQ/UI/widgets/app_bar.dart';

import '../../widgets/reusable_widgets.dart';

class DetailedToken extends StatefulWidget {
  @override
  _DetailedTokenState createState() => _DetailedTokenState();
}

class _DetailedTokenState extends State<DetailedToken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Token Details'),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
            child: ReusableWidgets().customContainer(Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Token Number:                   80',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ReusableWidgets().customText('Name: xyz'),
                ReusableWidgets().customText('Bank: xyz'),
                ReusableWidgets().customText('Branch: xyz'),
                ReusableWidgets().customText('Date & Time: xyz'),
                ReusableWidgets().customText('Purpose: xyz'),
                Container(
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Current Queue Status:    80 / 90',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
