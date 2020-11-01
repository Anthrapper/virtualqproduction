import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Appointment_Creation/bank_controller.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/dropdown.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class SelectBank extends StatefulWidget {
  @override
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final BankController _bankController = Get.put(BankController());

  String bank;
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  dOnchanged(String val) {
    print(val);
    _bankController.branch.value = val;
  }

  bankOntapped() {
    _bankController.showBranch.value = true;
    print('tapped');
    setState(() {
      _bankController.branch.value = null;
    });
  }

  bankOnchanged(String val) {
    _bankController.showBranch.value = false;

    setState(() {
      bank = val;
    });
    _reusableWidgets.progressIndicator();
    _bankController.getBranch(bank);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('appbarTwo'.tr),
      body: SafeArea(
        child: ListView(
          children: [
            _reusableWidgets.customSvg('assets/images/bank.svg'),
            _reusableWidgets.customContainer(
              Column(
                children: [
                  Obx(
                    () => CustomDropDown(
                      hintText: 'dropdownOne'.tr,
                      drValue: bank,
                      data: _bankController.bankData.value,
                      onChanged: bankOnchanged,
                      dText: 'name',
                      onTap: bankOntapped,
                      misc: true,
                    ),
                  ),
                  _bankController.showBranch.value
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Obx(
                            () => CustomDropDown(
                              hintText: 'dropdownTwo'.tr,
                              drValue: _bankController.branch.value,
                              data: _bankController.branchData.value,
                              onChanged: dOnchanged,
                              dText: 'name',
                              misc: true,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04),
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
        ),
      ),
    );
  }
}
