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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDnsuL2bqQ67Bq0xUqYg-WzHO3EpLx1g1I',
    appId: '1:735897242781:web:a3231db16ab9bc732b5874',
    messagingSenderId: '735897242781',
    projectId: 'tanbits-fiebase-project',
    authDomain: 'tanbits-fiebase-project.firebaseapp.com',
    storageBucket: 'tanbits-fiebase-project.appspot.com',
    measurementId: 'G-S3PE1CH0CC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXQByG4POnmW1_tTMEw5QC0FpIvwFlx5E',
    appId: '1:735897242781:android:16b30aa760d1fbc32b5874',
    messagingSenderId: '735897242781',
    projectId: 'tanbits-fiebase-project',
    storageBucket: 'tanbits-fiebase-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeIEVDYqb5iaDuE1GMamcYDFgXGMoVjH8',
    appId: '1:735897242781:ios:b42c5bbe15cf65df2b5874',
    messagingSenderId: '735897242781',
    projectId: 'tanbits-fiebase-project',
    storageBucket: 'tanbits-fiebase-project.appspot.com',
    iosBundleId: 'com.example.loginPage',
  );
}