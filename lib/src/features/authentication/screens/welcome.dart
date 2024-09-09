import 'package:ev_charging/src/features/authentication/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:ev_charging/src/features/authentication/screens/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // Full-width image at the top
            Image.asset(
              'assets/images/login.png', // Replace with your image path
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
            ),
            const SizedBox(height: 20),
            // Text in the middle
            Text(
              'Welcome to EV Charging Station',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Subtext (optional)
            Text(
              'Find and manage charging stations with ease.',
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Two buttons in a row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  // Signup Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Signup Screen
                      Get.to(() => const SignUpPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Button color
                      foregroundColor: Colors.black, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Signup',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some space at the bottom
          ],
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
    );
  }
}
