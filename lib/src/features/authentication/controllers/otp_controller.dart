
import 'package:ev_charging/main.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository.dart';

class OtpController extends GetxController{
  static OtpController get instance =>Get.find();
  void verifyOTP(String otp) async {
    var isVerified =await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified? Get.offAll(const AppHome()) :Get.back();
  }
}