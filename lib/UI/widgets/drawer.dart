import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/authentication_helper.dart';
import 'package:virtualq/UI/widgets/icon_button.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class MyDrawer extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  logOutFunction() {
    _reusableWidgets.twoButtonDialog(
      'Log Out',
      'Are you sure you want to log out?',
      () {
        Get.offAllNamed('/apphome');
      },
      Icons.exit_to_app_sharp,
      work: AuthenticationHelper().removeToken,
    );
  }

  @override
  Widget build(BuildContext context) {
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
        ButtonWithIcon(
          icon: Icons.live_help,
          text: 'contact'.tr,
          onPressed: () {
            Get.toNamed('/contact');
          },
        ),
        SizedBox(height: 20),
        ButtonWithIcon(
          onPressed: () {
            Get.toNamed('/passwordreset');
          },
          text: 'passChange'.tr,
          icon: Icons.security,
        ),
        SizedBox(height: 20),
        ButtonWithIcon(
          onPressed: () {
            // Get.locale.toString() == 'ml'
            //     ? Get.updateLocale(Locale('en'))
            //     : Get.updateLocale(Locale('ml'));
            AuthenticationHelper().storeLang();
          },
          text: 'changeLn'.tr,
          icon: Icons.language_sharp,
        ),
        SizedBox(
          height: 20,
        ),
        ButtonWithIcon(
          onPressed: logOutFunction,
          text: 'logout'.tr,
          icon: Icons.exit_to_app_sharp,
        ),
      ],
    );
  }
}
