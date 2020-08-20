import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

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
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
            child: ReusableWidgets().customContainer(Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Token Number:                   80',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ReusableWidgets().customText('Name: xyz'),
                ReusableWidgets().customText('Bank: xyz'),
                ReusableWidgets().customText('Branch: xyz'),
                ReusableWidgets().customText('Date & Time: xyz'),
                ReusableWidgets().customText('Purpose: xyz'),
                Row(
                  children: [
                    ReusableWidgets().customText('Update Status'),
                    Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: InkWell(
                        onTap: () {},
                        child: FaIcon(
                          FontAwesomeIcons.windowClose,
                          size: 30,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: InkWell(
                        onTap: () {},
                        child: FaIcon(
                          Icons.assignment_turned_in,
                          size: 30,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
