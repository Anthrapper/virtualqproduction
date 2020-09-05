import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class MyDrawer extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  @override
  Widget build(BuildContext context) {
    gotoHome() {
      Get.offAllNamed('/apphome');
    }

    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.userAlt,
              size: 100,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue[300],
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
                  color: Colors.blue[300],
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
          onPressed: () {
            Get.toNamed('/passwordreset');
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.terminal,
                  color: Colors.blue[300],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Change Password',
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
            _reusableWidgets.twoButtonDialog(
              'Log Out',
              'Are you sure you want to log out?',
              gotoHome,
              Icons.assignment_late,
              work: AuthenticationHelper().removeToken,
            );
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.backspace,
                  size: 30,
                  color: Colors.blue[300],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
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
        SizedBox(
          height: 20,
        ),
        FlatButton(
          onPressed: () {
            Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.add_to_home_screen,
                  size: 40,
                  color: Colors.blue[300],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Change Theme',
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
      ],
    );
  }
}
