import 'package:ev_charging/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../features/authentication/screens/welcome.dart';
import '../repository/signup_email_password_failure';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);

    // Bind the stream to listen for auth state changes
    firebaseUser.bindStream(_auth.userChanges());

    // Redirect user to appropriate screen when auth state changes
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomePage()) : Get.offAll(() => const AppHome());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'Provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user != null;
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP. Please try again.');
      return false;
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const AppHome()) : Get.offAll(() => const WelcomePage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Error', ex.message);
    } catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar('Error', ex.message);
      throw ex;
    }
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  Future<bool> isEmailRegistered(String email) async {
    try {
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty; // If there are sign-in methods, the email exists
    } catch (e) {
      // If there's an error, handle it here
      return false;
    }
  }
}

class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = "An unknown error occurred."]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure('The email address is badly formatted.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure('This user has been disabled.');
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure('No user found for this email.');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure('Wrong password provided for this user.');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}





