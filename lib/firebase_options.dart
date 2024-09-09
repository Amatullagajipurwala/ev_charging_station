// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBrtn9F2mCSSdORsjEdpP1AOriQ6CwCL5U',
    appId: '1:1095989705989:web:5cccb1b60e2e6051d28b6c',
    messagingSenderId: '1095989705989',
    projectId: 'fluuter-evcharging-app',
    authDomain: 'fluuter-evcharging-app.firebaseapp.com',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnQY97YQ1W5_M8fxonH6Hf7aP8X4Cp3uc',
    appId: '1:1095989705989:android:5721645e8ff284d2d28b6c',
    messagingSenderId: '1095989705989',
    projectId: 'fluuter-evcharging-app',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjoYl07oLUVBZpS8V6f0WhW5ok6Rs-Zkc',
    appId: '1:1095989705989:ios:537404b874469ff8d28b6c',
    messagingSenderId: '1095989705989',
    projectId: 'fluuter-evcharging-app',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
    iosBundleId: 'com.example.evCharging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjoYl07oLUVBZpS8V6f0WhW5ok6Rs-Zkc',
    appId: '1:1095989705989:ios:537404b874469ff8d28b6c',
    messagingSenderId: '1095989705989',
    projectId: 'fluuter-evcharging-app',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
    iosBundleId: 'com.example.evCharging',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBrtn9F2mCSSdORsjEdpP1AOriQ6CwCL5U',
    appId: '1:1095989705989:web:b917167ca23af6d6d28b6c',
    messagingSenderId: '1095989705989',
    projectId: 'fluuter-evcharging-app',
    authDomain: 'fluuter-evcharging-app.firebaseapp.com',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
  );

}