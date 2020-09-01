import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Appointment_Creation/bank_controller.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class SelectBank extends StatefulWidget {
  @override
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final BankController _bankController = Get.put(BankController());

  String bank;
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Select Your Bank'),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            child: _reusableWidgets.customSvg('assets/images/bank.svg'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: _reusableWidgets.customContainer(
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                    child: Obx(
                      () => DropdownButton(
                        elevation: 20,
                        isDense: true,
                        isExpanded: true,
                        autofocus: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        dropdownColor: Colors.grey[200],
                        hint: Text(
                          'Choose Bank',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: bank,
                        items: _bankController.bankData.value.map((item) {
                          return DropdownMenuItem(
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onTap: () {
                          _bankController.showBranch.value = true;
                          print('tapped');
                          setState(() {
                            _bankController.branch.value = null;
                          });
                        },
                        onChanged: (newVal) {
                          _bankController.showBranch.value = false;

                          setState(() {
                            bank = newVal;
                          });
                          _reusableWidgets.progressIndicator();
                          _bankController.getBranch(bank);
                        },
                      ),
                    ),
                  ),
                  _bankController.showBranch.value
                      ? SizedBox()
                      : Obx(
                          () => Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
                            child: DropdownButton(
                              elevation: 20,
                              isDense: true,
                              isExpanded: true,
                              autofocus: true,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              dropdownColor: Colors.grey[200],
                              hint: Text(
                                'Choose Branch',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              value: _bankController.branch.value,
                              items:
                                  _bankController.branchData.value.map((item) {
                                return DropdownMenuItem(
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                _bankController.branch.value = newVal;
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: InkWell(
                onTap: () {
                  if (bank != null && _bankController.branch.value != null) {
                    Get.toNamed('/tokengen/${_bankController.branch.value}');
                  }
                },
                child: _reusableWidgets.customButton(
                  'Next',
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
