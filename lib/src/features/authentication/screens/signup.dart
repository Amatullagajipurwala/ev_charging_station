import 'package:ev_charging/src/features/authentication/screens/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:ev_charging/src/features/authentication/controllers/signup_controller.dart';
import '../../../../main.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>(); // Form key for validation

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image at the top
                Image.asset(
                  'assets/images/login.png', // Replace with your image path
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                // Main Text
                Text(
                  'Get on board!',
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Create your profile to start your journey.',
                  style: GoogleFonts.lato(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Full Name TextFormField
                TextFormField(
                  controller: controller.fullName,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Email TextFormField with error message beside it
                Obx(() => Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegExp = RegExp(
                              r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    controller.emailErrorMessage.value.isNotEmpty
                        ? Text(
                      controller.emailErrorMessage.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : Container(),
                  ],
                )),
                const SizedBox(height: 20),
                // Phone Number TextFormField (Firebase validation)
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null; // Firebase handles further validation
                  },
                ),
                const SizedBox(height: 20),
                // Password TextFormField
                TextFormField(
                  controller: controller.password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    final passwordRegExp = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                    if (!passwordRegExp.hasMatch(value)) {
                      return 'Password must be at least 8 characters long, include 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // Check if the email already exists
                      await controller.checkEmailExists(controller.email.text.trim());
                      if (controller.emailErrorMessage.value.isEmpty) {
                        // Handle sign-up logic here
                        await controller.registerUser(
                          controller.email.text.trim(),
                          controller.password.text.trim(),
                        );
                        Get.to(() => const AppHome());
                      }else {
                        // Display the error message without navigating away
                        Get.snackbar('Error', controller.emailErrorMessage.value, snackPosition: SnackPosition.BOTTOM);
                      }
                      // If there is an email error message, the sign-up will not proceed
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                // OR sign up with Google
                const Center(
                  child: Text('Or sign up with'),
                ),
                const SizedBox(height: 20),
                // Google Sign-In Button using SignInButton package
                SignInButton(
                  Buttons.google,
                  onPressed: () {
                    Get.snackbar('Google Sign-In',
                        'Google Sign-In logic goes here!');
                  },
                ),
                const SizedBox(height: 20),
                // Already have an account? Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                    child: Text(
                      'Already have an account? Log In',
                      style: GoogleFonts.poppins(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
