import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// Reactive variables for loading state and password visibility
  final isLoading = false.obs; // Observable to track loading state
  final showPassword = false.obs; // Observable to track password visibility

  /// Login method to call the repository method
  Future<void> login() async {
    isLoading.value = true;

    // Call the method from AuthenticationRepository
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

    isLoading.value = false;

    // If there is an error, show it using Snackbar
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error, duration: Duration(seconds: 2)));
    }
  }

  /// To toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }
}
