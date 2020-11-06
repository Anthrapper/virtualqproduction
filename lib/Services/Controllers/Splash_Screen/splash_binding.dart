import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Splash_Screen/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() => Get.put(SplashController());
}
