import 'package:ev_charging/src/features/authentication/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
   var otp=''; // Initialize the otp variable

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (code) {
                // Handle validation or other checks if needed
              },
              onSubmit: (code) {
                otp = code; // Assign the entered OTP to the otp variable
                OtpController.instance.verifyOTP(otp);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle OTP verification or submission here
                OtpController.instance.verifyOTP(otp);
              },
              child: const Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
