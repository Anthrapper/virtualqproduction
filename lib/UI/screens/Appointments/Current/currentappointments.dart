import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/token_views/token_list_controller.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/app_bar.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class CurrentAppointments extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final TokenListController _tokenListController =
      Get.put(TokenListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Current Appointments'),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _tokenListController.tokenData == null
                ? 0
                : _tokenListController.tokenData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.01,
                        horizontal: Get.width * 0.02),
                    child: FadeAnimation(
                      0.1,
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.07)),
                        color: Colors.blue[400],
                        elevation: 10,
                        child: _reusableWidgets.customContainer(
                          InkWell(
                            onTap: () {
                              Get.toNamed('/detailedtoken');
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(7),
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
                                _reusableWidgets.customText(
                                    'Token Number:    ${_tokenListController.tokenData[index]["order_number"]}'),
                                _reusableWidgets.customText(
                                    'Bank:         ${_tokenListController.tokenData[index]["bank"]}'),
                                _reusableWidgets.customText(
                                    'Service:    ${_tokenListController.tokenData[index]["service"]}'),
                                _reusableWidgets.customText(
                                    'Date :        ${_tokenListController.tokenData[index]["token_date"].toString().substring(
                                          0,
                                          _tokenListController.tokenData[index]
                                                  ["token_date"]
                                              .toString()
                                              .indexOf('T'),
                                        )}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
