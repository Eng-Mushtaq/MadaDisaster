// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:red_zone/data/repositories/user/user_repository.dart';
//
// import 'package:red_zone/features/authentication/screens/login/login.dart';
// import 'package:red_zone/features/authentication/screens/onboarding/onboarding.dart';
// import 'package:red_zone/navigation_menu.dart';
// import '../../../features/authentication/screens/signup/verify_email.dart';
// import '../../../utils/exceptions/firebase_auth_exceptions.dart';
// import '../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../utils/exceptions/format_exceptions.dart';
// import '../../../utils/exceptions/platform_exceptions.dart';
//
// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//
//   // Variables
//   final deviceStorage = GetStorage();
//   final _auth = FirebaseAuth.instance;
//
//   // Get Authentication User Data
//   User? get authUser => _auth.currentUser;
//
//   // Called from main.dart on app launch
//   @override
//   void onReady() {
//     // Remove splash screen
//     FlutterNativeSplash.remove();
//     // Redirect to the relevant screen
//     screenRedirect();
//   }
//
//   // Function to show relevant screen
//   screenRedirect() async {
//     final user = _auth.currentUser;
//
//     if (user != null) {
//       // if user is already logged in
//       if (user.emailVerified) {
//         // if user is verified redirect to navigation menu
//         Get.offAll(() => const NavigationMenu());
//       } else {
//         // if the user's email is not verified, redirect to verify email screen
//         Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
//       }
//     } else {
//       // Local storage
//       deviceStorage.writeIfNull('isFirstTime', true);
//
//       // check if its the first time launching the app
//       deviceStorage.read('isFirstTime') != true
//           ? Get.offAll(() => const LoginScreen()) // Redirect to Login Screen if not the first time
//           : Get.offAll(() => const OnBoardingScreen() // Redirect to OnBoarding Screen if the first time
//               );
//     }
//
//     // Local Storage debug - when the first time
//     if (kDebugMode) {
//       print('======== GET STORAGE ========');
//       print(deviceStorage.read('isFirstTime'));
//     }
//   }
//
//   /* ------------------------Email & Password sign in ------------------------ */
//
//   // [EmailAuthentication] - SignIn
//   Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   // [EmailAuthentication] - REGISTER
//   Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       return await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   // [EmailVerification] - MAIL VERIFICATION
//
//   Future<void> sendEmailVerification() async {
//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   // [ReAuthentication] - Re Authentication User
//
//   Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
//     try {
//       // Create credentials
//       AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//
//       // Re Authenticate
//       await _auth.currentUser!.reauthenticateWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   // [EmailAuthentication] - FORGOT PASSWORD
//
//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   /* -------------------- Federated identity & social sign-in -------------------- */
//
//   // [GoogleAuthentication] - GOOGLE SIGN IN
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
//
//       // Create a new credential
//       final credentials = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       // Once signed in, return the UserCredential
//       return await _auth.signInWithCredential(credentials);
//
//       // validation
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       if (kDebugMode) 'Something went wrong! $e';
//       return null;
//     }
//   }
//
//   // [FacebookAuthentication] - FACEBOOK SIGN IN
//
//   /* ------------------------ ./end federated identity & social sign-in ------------------------ */
//
//   // [LogoutUser] - Valid for any authenticated user
//
//   Future<void> logout() async {
//     try {
//       await GoogleSignIn().signOut();
//       await FirebaseAuth.instance.signOut();
//       Get.offAll(() => const LoginScreen());
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
//
//   // DELETE USER - Remove user Auth and Firestore Account
//   Future<void> deleteAccount() async {
//     try {
//       await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//       await _auth.currentUser?.delete();
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong! Please try again!';
//     }
//   }
// }

// ADMIN PANEL

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:red_zone/data/repositories/user/user_repository.dart';

import 'package:red_zone/features/authentication/screens/login/login.dart';
import 'package:red_zone/features/authentication/screens/onboarding/onboarding.dart';
import 'package:red_zone/navigation_menu.dart';
import '../../../admin_navigation_menu.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get Authentication User Data
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    // Remove splash screen
    FlutterNativeSplash.remove();
    // Redirect to the relevant screen
    screenRedirect();
  }

  // Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        // Check if the user is an admin
        if (user.email == 'Jinan.alshehri@gmail.com') {
          Get.offAll(() => const NavigationMenu());
        } else {
          Get.offAll(() => const AdminNavigationMenu());
        }
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local storage
      deviceStorage.writeIfNull('isFirstTime', true);

      // check if its the first time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() =>
              const LoginScreen()) // Redirect to Login Screen if not the first time
          : Get.offAll(() =>
                  const OnBoardingScreen() // Redirect to OnBoarding Screen if the first time
              );
    }

    // Local Storage debug - when the first time
    if (kDebugMode) {
      print('======== GET STORAGE ========');
      print(deviceStorage.read('isFirstTime'));
    }
  }

  /* ------------------------Email & Password sign in ------------------------ */

  // [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [EmailVerification] - MAIL VERIFICATION

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [ReAuthentication] - Re Authentication User

  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create credentials
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // Re Authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // [EmailAuthentication] - FORGOT PASSWORD

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  /* -------------------- Federated identity & social sign-in -------------------- */

  // [GoogleAuthentication] - GOOGLE SIGN IN
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);

      // validation
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) 'Something went wrong! $e';
      return null;
    }
  }

  // [FacebookAuthentication] - FACEBOOK SIGN IN

  /* ------------------------ ./end federated identity & social sign-in ------------------------ */

  // [LogoutUser] - Valid for any authenticated user

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  // DELETE USER - Remove user Auth and Firestore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }
}
