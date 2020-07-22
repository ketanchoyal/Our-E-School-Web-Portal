import 'dart:io';
import 'package:flutter/services.dart';
import 'package:oureschoolweb/core/enums/auth_results.dart';

class FirebaseAuthException {
  static FirebaseAuthResults catchException(Exception e) {
    FirebaseAuthResults errorType = FirebaseAuthResults.UNKNOWN;
    if (e is PlatformException) {
      if (Platform.isIOS) {
        switch ((e as PlatformException).message) {
          case "1":
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = FirebaseAuthResults.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = FirebaseAuthResults.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = FirebaseAuthResults.NetworkError;
            break;
          case 'Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later':
            errorType = FirebaseAuthResults.TOOMANYATTEMPTS;
            break;
          // ...
          default:
            print(
                'Case iOS ${(e as PlatformException).message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch ((e as PlatformException).code) {
          case "1":
          case 'Error 17011':
            errorType = FirebaseAuthResults.UserNotFound;
            break;
          case 'Error 17009':
          case 'ERROR_WRONG_PASSWORD':
            errorType = FirebaseAuthResults.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = FirebaseAuthResults.NetworkError;
            break;
          // ...
          default:
            print(
                'Case Android ${(e as PlatformException).message} ${(e as PlatformException).code} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
