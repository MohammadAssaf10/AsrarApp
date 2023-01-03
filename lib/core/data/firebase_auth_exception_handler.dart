import '../../config/strings_manager.dart';
import 'exception_handler.dart';
import 'failure.dart';

enum FirebaseAuthExceptions {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  weakPassword,
  forbidden,
  expiredActionCode,
  invalidActionCode,
  undefined
}

extension AuthResultStatusExtension on FirebaseAuthExceptions {
  Failure getFailure() {
    switch (this) {
      case FirebaseAuthExceptions.successful:
        return Failure(ResponseCode.success, AppStrings.success);

      case FirebaseAuthExceptions.emailAlreadyExists:
        return Failure(
            ResponseCode.unauthorized, AppStrings.emailAlreadyExists);

      case FirebaseAuthExceptions.wrongPassword:
        return Failure(ResponseCode.unauthorized, AppStrings.wrongPassword);

      case FirebaseAuthExceptions.invalidEmail:
        return Failure(ResponseCode.unauthorized, AppStrings.invalidEmail);

      case FirebaseAuthExceptions.userNotFound:
        return Failure(ResponseCode.notFound, AppStrings.userNotFound);

      case FirebaseAuthExceptions.userDisabled:
        return Failure(ResponseCode.unauthorized, AppStrings.userDisabled);

      case FirebaseAuthExceptions.operationNotAllowed:
        return Failure(
            ResponseCode.unauthorized, AppStrings.operationNotAllowed);

      case FirebaseAuthExceptions.forbidden:
        return Failure(ResponseCode.forbidden, AppStrings.forbiddenError);

      case FirebaseAuthExceptions.undefined:
        return Failure(ResponseCode.unauthorized, AppStrings.undefined);
      case FirebaseAuthExceptions.weakPassword:
        return Failure(ResponseCode.unauthorized, AppStrings.weakPassword);
      case FirebaseAuthExceptions.expiredActionCode:
        return Failure(ResponseCode.unauthorized, AppStrings.expiredActionCode);
      case FirebaseAuthExceptions.invalidActionCode:
        return Failure(ResponseCode.unauthorized, AppStrings.invalidActionCode);
    }
  }
}

class FirebaseAuthExceptionHandler {
  static FirebaseAuthExceptions handle(e) {
    print(e.code);
    FirebaseAuthExceptions status;
    switch (e.code) {
      case "invalid-email":
      case "auth/invalid-email":
        status = FirebaseAuthExceptions.invalidEmail;
        break;
      case "wrong-password":
        status = FirebaseAuthExceptions.wrongPassword;
        break;
      case "user-not-found":
      case "auth/user-not-found":
        status = FirebaseAuthExceptions.userNotFound;
        break;
      case "user-disabled":
        status = FirebaseAuthExceptions.userDisabled;
        break;
      case "operation-not-allowed":
        status = FirebaseAuthExceptions.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = FirebaseAuthExceptions.emailAlreadyExists;
        break;
      case 'weak-password':
        status = FirebaseAuthExceptions.weakPassword;
        break;
      case 'expired-action-code':
        status = FirebaseAuthExceptions.expiredActionCode;
        break;
      case 'invalid-action-code':
        status = FirebaseAuthExceptions.invalidActionCode;
        break;
      default:
        status = FirebaseAuthExceptions.undefined;
    }
    return status;
  }
}
