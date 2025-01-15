import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {

late Timer _pindah;

final authToken = GetStorage();
 
  @override
  void onInit() {

  _pindah = Timer.periodic(
    const Duration(seconds: 4),
    (timer) => Get.off(
    () => const LoginView(),
    transition: Transition.leftToRight,
  ),
);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

    _pindah.cancel();
    
    super.onClose();
  }

  
}
