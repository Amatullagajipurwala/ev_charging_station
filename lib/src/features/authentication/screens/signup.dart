import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../../main.dart';
import 'login.dart'; // Assuming this is where your home page or main app logic is

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Full Name TextField
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              // Email TextField
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              // Phone Number TextField
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic here
                  Get.to(() => const AppHome()); // Navigate to home or app page after sign up
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
                // text: "Sign up with Google",
                onPressed: () {
                  // Handle Google Sign-In logic here
                  Get.snackbar('Google Sign-In', 'Google Sign-In logic goes here!');
                },
              ),
              const SizedBox(height: 20),
              // Already have an account? Login
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate back to login page
                    Get.to(() => const LoginPage()); // Navigate back to the previous page, e.g., LoginPage
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
    );
  }
}
