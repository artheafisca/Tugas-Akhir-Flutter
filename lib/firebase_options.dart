// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDujTRQeYSU8zvHgjkDoBaPjyXwREJaQ4M',
    appId: '1:588687707898:web:db1dd3be4241093e568343',
    messagingSenderId: '588687707898',
    projectId: 'e-wallet-5f435',
    authDomain: 'e-wallet-5f435.firebaseapp.com',
    storageBucket: 'e-wallet-5f435.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2joiK9E-cqL4TNHLcSRAcclBeBiF5l18',
    appId: '1:588687707898:android:86a65785e471b86f568343',
    messagingSenderId: '588687707898',
    projectId: 'e-wallet-5f435',
    storageBucket: 'e-wallet-5f435.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDexU1EV7QU_7rx0AyGgRJSIEqiIaI6W5w',
    appId: '1:588687707898:ios:e6dc396436d3e888568343',
    messagingSenderId: '588687707898',
    projectId: 'e-wallet-5f435',
    storageBucket: 'e-wallet-5f435.appspot.com',
    iosClientId: '588687707898-pdjv5uqcphb1pk09vh99as24rkmd9ut7.apps.googleusercontent.com',
    iosBundleId: 'com.example.eWallet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDexU1EV7QU_7rx0AyGgRJSIEqiIaI6W5w',
    appId: '1:588687707898:ios:e6dc396436d3e888568343',
    messagingSenderId: '588687707898',
    projectId: 'e-wallet-5f435',
    storageBucket: 'e-wallet-5f435.appspot.com',
    iosClientId: '588687707898-pdjv5uqcphb1pk09vh99as24rkmd9ut7.apps.googleusercontent.com',
    iosBundleId: 'com.example.eWallet',
  );
}