import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Splash_Screen/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() => Get.put(SplashController());
}
