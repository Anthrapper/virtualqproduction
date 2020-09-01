import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/token_views/detailed_controller.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class DetailedToken extends StatelessWidget {
  final DetailedController _detailedController = Get.put(DetailedController());
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    tokenDialog(String title, String desc, String id) {
      return Alert(
        context: context,
        title: title,
        desc: desc,
        type: AlertType.warning,
        buttons: [
          DialogButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              _detailedController.tokenStatus(id);
            },
            gradient: LinearGradient(
              colors: [
                Colors.green[600],
                Colors.greenAccent[700],
              ],
            ),
          ),
          DialogButton(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue,
                Colors.lightBlueAccent[200],
              ],
            ),
          )
        ],
      ).show();
    }

    return Scaffold(
      appBar: CustomAppBar('Token Details'),
      body: FutureBuilder(
        future: _detailedController.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
              child: FadeAnimation(
                1,
                _reusableWidgets.customContainer(
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(15),
                        alignment: Alignment.topLeft,
                        child: Obx(() => Text(
                              'Token Number:                   ${_detailedController.token.value}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[900],
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      Obx(() => _reusableWidgets.customText(
                          'Name:   ${_detailedController.userName.value}')),
                      Obx(() => _reusableWidgets.customText(
                          'Bank:     ${_detailedController.bank.value}')),
                      Obx(() => _reusableWidgets.customText(
                          'Branch:  ${_detailedController.branch.value}')),
                      Obx(() => _reusableWidgets.customText(
                          'Date:       ${_detailedController.date.value}')),
                      Obx(() => _reusableWidgets.customText(
                          'Counter Number:  ${_detailedController.counter.value}')),
                      Obx(() => _reusableWidgets.customText(
                          'Purpose:  ${_detailedController.service.value}')),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                        child: RaisedButton(
                          color: Colors.blueGrey[100],
                          onPressed: () {
                            tokenDialog(
                              'Token Cancellation',
                              'Are you sure you want to cancel the token?',
                              '10',
                            );
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(80, 10, 0, 5),
                                  child: Text(
                                    'Cancel Token',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                        child: RaisedButton(
                          color: Colors.blueGrey[100],
                          onPressed: () {
                            tokenDialog(
                              'Token Status Updation',
                              'Are you sure you want to update token status to done?',
                              '15',
                            );
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(80, 10, 0, 5),
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(14, 10, 0, 0),
                                    child: Icon(
                                      Icons.assignment_turned_in,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
