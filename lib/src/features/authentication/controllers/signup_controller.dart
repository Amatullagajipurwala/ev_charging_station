import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // Method to register a new user
  Future<void> registerUser(String email, String password) async {
    try {
      await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      // Handle registration error here, e.g., show a Snackbar
      Get.snackbar('Registration Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
  var emailErrorMessage = ''.obs;

  // Method to check if email exists
  Future<void> checkEmailExists(String email) async {
    try {
      bool exists = await AuthenticationRepository.instance.isEmailRegistered(email);
      if (exists) {
        emailErrorMessage.value = 'Email already exists. Please use a different email.';
      } else {
        emailErrorMessage.value = '';
      }
    } catch (e) {
      emailErrorMessage.value = 'An error occurred while checking email existence.';
    }
  }

  // Method for phone number authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
