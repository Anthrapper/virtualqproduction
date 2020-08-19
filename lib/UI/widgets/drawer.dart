import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.userCircle,
              size: 100,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent[200],
          ),
        ),
        SizedBox(height: 40),
        FlatButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.blenderPhone,
                  color: Colors.lightBlueAccent[200],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Contact Bank',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        FlatButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.terminal,
                  color: Colors.lightBlueAccent[200],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Technical Support',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        FlatButton(
          onPressed: () {
            ReusableWidgets().logOutDialog(
                context, 'Log Out', 'Are you sure you want to log out?');
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.windowClose,
                  color: Colors.lightBlueAccent[200],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
