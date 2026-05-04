import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDummyKeyForWeb',
    appId: '1:767750650169:web:dummywebappid',
    messagingSenderId: '767750650169',
    projectId: 'evently-12345',
    authDomain: 'evently-12345.firebaseapp.com',
    storageBucket: 'evently-12345.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSj3oBzv5aTl6x3u8TePsT4HUIibJ5Wxg',
    appId: '1:767750650169:android:bc8b1543c0db39f89490e8',
    messagingSenderId: '767750650169',
    projectId: 'evently-34893',
    storageBucket: 'evently-34893.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyForIOS',
    appId: '1:767750650169:ios:dummyiosappid',
    messagingSenderId: '767750650169',
    projectId: 'evently-12345',
    storageBucket: 'evently-12345.appspot.com',
    iosBundleId: 'com.example.evently',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDummyKeyForMacOS',
    appId: '1:767750650169:macos:dummymacosappid',
    messagingSenderId: '767750650169',
    projectId: 'evently-12345',
    storageBucket: 'evently-12345.appspot.com',
    iosBundleId: 'com.example.evently',
  );
}
