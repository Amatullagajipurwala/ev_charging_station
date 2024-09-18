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
    apiKey: 'AIzaSyB3bc6gXQn7y1IcGujAG8yEK4yUr5q7E6U',
    appId: '1:858776695188:web:4d7c1271e2ed6c3e12df81',
    messagingSenderId: '858776695188',
    projectId: 'evcharging-28838',
    authDomain: 'evcharging-28838.firebaseapp.com',
    storageBucket: 'fluuter-evcharging-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3bc6gXQn7y1IcGujAG8yEK4yUr5q7E6U',
    appId: '1:858776695188:android:4d7c1271e2ed6c3e12df81',
    messagingSenderId: '858776695188',
    projectId: 'evcharging-28838',
    storageBucket: 'evcharging-28838.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3bc6gXQn7y1IcGujAG8yEK4yUr5q7E6U',
    appId: '1:858776695188:ios:4d7c1271e2ed6c3e12df81',
    messagingSenderId: '858776695188',
    projectId: 'evcharging-28838',
    storageBucket: 'evcharging-28838.appspot.com',
    iosBundleId: 'com.example.evCharging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3bc6gXQn7y1IcGujAG8yEK4yUr5q7E6U',
    appId: '1:858776695188:ios:4d7c1271e2ed6c3e12df81',
    messagingSenderId: '858776695188',
    projectId: 'evcharging-28838',
    storageBucket: 'evcharging-28838.appspot.com',
    iosBundleId: 'com.example.evCharging',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB3bc6gXQn7y1IcGujAG8yEK4yUr5q7E6U',
    appId: '1:858776695188:web:4d7c1271e2ed6c3e12df81',
    messagingSenderId: '858776695188',
    projectId: 'evcharging-28838',
    authDomain: 'evcharging-28838.firebaseapp.com',
    storageBucket: 'evcharging-28838.appspot.com',
  );

}