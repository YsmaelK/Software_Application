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
    apiKey: 'AIzaSyA1JNgjTY8hg9c9mmFqoVcJYJM2nOIhrLA',
    appId: '1:395566159317:web:6f610dc733b4b39b19195c',
    messagingSenderId: '395566159317',
    projectId: 'project1-adaee',
    authDomain: 'project1-adaee.firebaseapp.com',
    storageBucket: 'project1-adaee.appspot.com',
    measurementId: 'G-5M1YJLFHY7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAStXh81g8HMH79t7VeVdoWJr1CiOyAYqw',
    appId: '1:395566159317:android:2eeeb8b72c31fafe19195c',
    messagingSenderId: '395566159317',
    projectId: 'project1-adaee',
    storageBucket: 'project1-adaee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMQP82CwGsoEr6MhMXT6z0qwIiMDA__B4',
    appId: '1:395566159317:ios:5ad9915775b331c119195c',
    messagingSenderId: '395566159317',
    projectId: 'project1-adaee',
    storageBucket: 'project1-adaee.appspot.com',
    iosClientId: '395566159317-r91rvoilpqt08i4kneefo0anp5fapv50.apps.googleusercontent.com',
    iosBundleId: 'com.untitled.networkUpp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMQP82CwGsoEr6MhMXT6z0qwIiMDA__B4',
    appId: '1:395566159317:ios:5ad9915775b331c119195c',
    messagingSenderId: '395566159317',
    projectId: 'project1-adaee',
    storageBucket: 'project1-adaee.appspot.com',
    iosClientId: '395566159317-r91rvoilpqt08i4kneefo0anp5fapv50.apps.googleusercontent.com',
    iosBundleId: 'com.untitled.networkUpp',
  );
}