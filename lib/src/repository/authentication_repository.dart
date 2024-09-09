import 'package:ev_charging/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../features/authentication/screens/login.dart';
import '../features/authentication/screens/welcome.dart';
import '../repository/signup_email_password_failure';
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId=''.obs;

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
    user==null?Get.offAll(() => const WelcomePage()): Get.offAll(() => const AppHome());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        },
        codeSent:(verificationId, resendToken){
        this.verificationId.value=verificationId;

        },
        codeAutoRetrievalTimeout:(verificationId){
          this.verificationId.value=verificationId;
        },
    verificationFailed: (e){
        if(e.code=='invalid-phone-number'){
          Get.snackbar('Error', 'Provide phone number is nt valid');

        }
        else{
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
    },);
  }

 Future< bool> verifyOTP(String otp)async{
  var credentials=  await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
  return credentials.user!=null?true:false;
  }


  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value!=null?Get.offAll(() => const AppHome()): Get.offAll(() => const WelcomePage());
    } on FirebaseAuthException catch (e) {
    final ex= SignUpWithEmailAndPasswordFailure.code(e.code);
    print('Firebase auth exception ${ex.message}');
    } catch (e) {
     final ex= SignUpWithEmailAndPasswordFailure();
     print('exception ${ex.message}');
     throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "Unknown error occurred.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
