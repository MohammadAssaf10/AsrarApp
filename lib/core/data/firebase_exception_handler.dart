import '../../config/strings_manager.dart';
import 'exception_handler.dart';
import 'failure.dart';

enum FirebaseExceptions { forbidden, unhandled }

extension FirebaseExceptionsExtension on FirebaseExceptions {
  Failure getFailure() {
    switch (this) {
      case FirebaseExceptions.forbidden:
        return Failure(ResponseCode.forbidden, AppStrings.forbiddenError);
      case FirebaseExceptions.unhandled:
        return Failure(0, AppStrings.defaultError);
    }
  }
}

class FirebaseExceptionHandler {
  static FirebaseExceptions handle(e) {
    print(e);
    FirebaseExceptions status;

    switch (e.code) {
      case 'unavailable':
        status = FirebaseExceptions.forbidden;
        break;

      default:
        status = FirebaseExceptions.unhandled;
    }

    return status;
  }
}
