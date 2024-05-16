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
    apiKey: 'AIzaSyCnvb58twRHWEkhU_WTtxZFYCeeiMpTjFo',
    appId: '1:272230166623:web:edd07a3358251b39c1ebea',
    messagingSenderId: '272230166623',
    projectId: 'house-arena-web-app-basic',
    authDomain: 'house-arena-web-app-basic.firebaseapp.com',
    storageBucket: 'house-arena-web-app-basic.appspot.com',
    measurementId: 'G-XS1WZ2KVB2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD8LXOviMSCw2WF1hs9Xm7WJ1fNZR9CfE',
    appId: '1:272230166623:android:e22819c27f4b31d3c1ebea',
    messagingSenderId: '272230166623',
    projectId: 'house-arena-web-app-basic',
    storageBucket: 'house-arena-web-app-basic.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtOC8pncu5HKRe_Ht2FRnnlKnlrYDqPPk',
    appId: '1:272230166623:ios:34a1fb0a7e8dfd43c1ebea',
    messagingSenderId: '272230166623',
    projectId: 'house-arena-web-app-basic',
    storageBucket: 'house-arena-web-app-basic.appspot.com',
    iosBundleId: 'com.example.webAppHouseArenaBasic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtOC8pncu5HKRe_Ht2FRnnlKnlrYDqPPk',
    appId: '1:272230166623:ios:34a1fb0a7e8dfd43c1ebea',
    messagingSenderId: '272230166623',
    projectId: 'house-arena-web-app-basic',
    storageBucket: 'house-arena-web-app-basic.appspot.com',
    iosBundleId: 'com.example.webAppHouseArenaBasic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnvb58twRHWEkhU_WTtxZFYCeeiMpTjFo',
    appId: '1:272230166623:web:4018fab5ee664439c1ebea',
    messagingSenderId: '272230166623',
    projectId: 'house-arena-web-app-basic',
    authDomain: 'house-arena-web-app-basic.firebaseapp.com',
    storageBucket: 'house-arena-web-app-basic.appspot.com',
    measurementId: 'G-2F9626177S',
  );
}
