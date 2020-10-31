import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'login': 'Login',
          'homeButtonOne': 'Generate New Token',
          'homeButtonTwo': 'Current Tokens',
          'dropdownOne': 'Choose Bank',
          'dropdownTwo': 'Choose Branch',
          'dropDownThree': 'Select Date',
          'dropDownFour': 'Choose Purpose',
          'dropDownFive': 'Choose Time Slot',
        },
        'ml': {
          'login': 'ലോഗിൻ',
          'homeButtonOne': 'പുതിയ ടോക്കൺ നിർമ്മിക്കുക',
          'homeButtonTwo': 'നിലവിലുള്ള ടോക്കൺ',
          'dropdownOne': 'ബാങ്ക്',
          'dropdownTwo': 'ബ്രാഞ്ച്',
          'dropDownThree': 'തീയ്യതി',
          'dropDownFour': 'ആവശ്യം',
          'dropDownFive': 'സമയം',
        },
      };
}
