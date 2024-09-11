import 'package:ev_charging/src/features/authentication/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../controllers/login_controller.dart'; // Ensure correct path

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Login image at the top
                Image.asset(
                  'assets/images/login.png', // Replace with your image path
                  height: 200,
                ),
                const SizedBox(height: 30),
                // Welcome Back text
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Quote text
                Text(
                  'Login to continue your journey.',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Email TextField
                TextFormField(
                  controller: controller.email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                // Password TextField with visibility toggle
                Obx(
                      () => TextFormField(
                    controller: controller.password,
                    obscureText: controller.showPassword.value ? false : true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: controller.showPassword.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () => controller.togglePasswordVisibility(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Forgot Password?
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.lato(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                Obx(
                      () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null // Disable button while loading
                        : () async {
                      await controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Login',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // OR sign in with Google
                Column(
                  children: [
                    Text(
                      'OR',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Sign in with Google button
                    SignInButton(
                      Buttons.google,
                      text: "Sign up with Google",
                      onPressed: () {
                        // Handle Google sign-up action
                      },
                    ),
                    const SizedBox(height: 20),
                    // Don't have an account? Signup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.lato(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to Signup screen
                            Get.to(() => const SignUpPage());
                          },
                          child: Text(
                            'Signup',
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
    );
  }
}
