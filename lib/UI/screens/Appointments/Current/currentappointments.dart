import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/token_views/token_list_controller.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class CurrentAppointments extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final TokenListController _tokenListController =
      Get.put(TokenListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Current Appointments'),
      body: SafeArea(
        child: FutureBuilder(
          future: _tokenListController.getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(
                () => ListView.builder(
                  itemCount: _tokenListController.tokenData == null
                      ? 0
                      : _tokenListController.tokenData.length,
                  itemBuilder: (context, index) {
                    String tokenNumber =
                        _tokenListController.tokenData[index]["order_number"];
                    String bank = _tokenListController.tokenData[index]["bank"];
                    String date =
                        _tokenListController.tokenData[index]["token_date"];
                    String service =
                        _tokenListController.tokenData[index]["service"];
                    date = date.substring(
                      0,
                      date.indexOf('T'),
                    );
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: FadeAnimation(
                            0.7,
                            _reusableWidgets.customContainer(
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
                                        'Token Number:    $tokenNumber'),
                                    _reusableWidgets
                                        .customText('Bank:         $bank'),
                                    _reusableWidgets
                                        .customText('Service:    $service'),
                                    _reusableWidgets
                                        .customText('Date :        $date'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
