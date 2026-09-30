
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
    apiKey: 'AIzaSyDNV3lUuw6TYtWX7L4xkRGcb2yGK0XX5sk',
    appId: '1:405299764420:web:d139760fe466a7ae0cbd91',
    messagingSenderId: '405299764420',
    projectId: 'project-for-com',
    authDomain: 'project-for-com.firebaseapp.com',
    storageBucket: 'project-for-com.firebasestorage.app',
    measurementId: 'G-582M4P1WMB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNByWrXYSJRo_MJOx8a0x6Wyv6rqGW4X0',
    appId: '1:405299764420:android:6bbc991fbdb45da20cbd91',
    messagingSenderId: '405299764420',
    projectId: 'project-for-com',
    storageBucket: 'project-for-com.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCB5MgtxNXWaO-5pIYmjBU1xXQzurXVt6I',
    appId: '1:405299764420:ios:3714354d87c1f8700cbd91',
    messagingSenderId: '405299764420',
    projectId: 'project-for-com',
    storageBucket: 'project-for-com.firebasestorage.app',
    iosBundleId: 'com.example.untitled19',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCB5MgtxNXWaO-5pIYmjBU1xXQzurXVt6I',
    appId: '1:405299764420:ios:3714354d87c1f8700cbd91',
    messagingSenderId: '405299764420',
    projectId: 'project-for-com',
    storageBucket: 'project-for-com.firebasestorage.app',
    iosBundleId: 'com.example.untitled19',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNV3lUuw6TYtWX7L4xkRGcb2yGK0XX5sk',
    appId: '1:405299764420:web:91b2d0c4393566a80cbd91',
    messagingSenderId: '405299764420',
    projectId: 'project-for-com',
    authDomain: 'project-for-com.firebaseapp.com',
    storageBucket: 'project-for-com.firebasestorage.app',
    measurementId: 'G-4SL72F91P5',
  );
}
