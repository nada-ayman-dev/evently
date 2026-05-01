import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

/// Firebase configuration options for all platforms
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // TODO: Replace with your Firebase project configuration
    // You can get this from Firebase Console > Project Settings > google-services.json (Android)
    // or GoogleService-Info.plist (iOS)

    if (kIsWeb) {
      return web;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ios;
    }
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return windows;
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      return macos;
    }
    if (defaultTargetPlatform == TargetPlatform.linux) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for linux - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCiWuGA9DSGlh59ZPf9L4ZMNVidklRvQg',
    appId: '1:602009762660:android:84192f17e11c70d1ad1871',
    messagingSenderId: '602009762660',
    projectId: 'evently-12345',
    databaseURL: 'https://evently-12345.firebaseio.com',
    storageBucket: 'evently-12345.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCiWuGA9DSGlh59ZPf9L4ZMNVidklRvQg',
    appId: '1:602009762660:ios:84192f17e11c70d1ad1871',
    messagingSenderId: '602009762660',
    projectId: 'evently-12345',
    databaseURL: 'https://evently-12345.firebaseio.com',
    storageBucket: 'evently-12345.firebasestorage.app',
    iosBundleId: 'com.example.evently',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCCiWuGA9DSGlh59ZPf9L4ZMNVidklRvQg',
    appId: '1:602009762660:windows:84192f17e11c70d1ad1871',
    messagingSenderId: '602009762660',
    projectId: 'evently-12345',
    databaseURL: 'https://evently-12345.firebaseio.com',
    storageBucket: 'evently-12345.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCCiWuGA9DSGlh59ZPf9L4ZMNVidklRvQg',
    appId: '1:602009762660:web:84192f17e11c70d1ad1871',
    messagingSenderId: '602009762660',
    projectId: 'evently-12345',
    databaseURL: 'https://evently-12345.firebaseio.com',
    storageBucket: 'evently-12345.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCiWuGA9DSGlh59ZPf9L4ZMNVidklRvQg',
    appId: '1:602009762660:macos:84192f17e11c70d1ad1871',
    messagingSenderId: '602009762660',
    projectId: 'evently-12345',
    databaseURL: 'https://evently-12345.firebaseio.com',
    storageBucket: 'evently-12345.firebasestorage.app',
    iosBundleId: 'com.example.evently',
  );
}
