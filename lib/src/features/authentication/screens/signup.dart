

import 'package:ev_charging/src/features/authentication/screens/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:ev_charging/src/features/authentication/controllers/signup_controller.dart';

import '../../../../main.dart';
import 'login.dart'; // Assuming this is where your home page or main app logic is

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
                // Email TextFormField
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Phone Number TextFormField
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
                    return null;
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
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle sign-up logic here
                      SignUpController.instance.registerUser(controller.email.text.trim(),controller.password.text.trim());
                         Get.to(() => const AppHome());
                      // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      // Get.to(() => const OtpScreen());
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
                    // Handle Google Sign-In logic here
                    Get.snackbar(
                        'Google Sign-In', 'Google Sign-In logic goes here!');
                  },
                ),
                const SizedBox(height: 20),
                // Already have an account? Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate back to login page
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
