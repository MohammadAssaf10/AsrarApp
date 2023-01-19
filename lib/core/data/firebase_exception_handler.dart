import '../../config/strings_manager.dart';
import 'exception_handler.dart';
import 'failure.dart';

enum FirebaseExceptions {
  forbidden,
  unhandled,
  unknown,
  objectNotFound,
  bucketNotFound,
  projectNotFound,
  quotaExceeded,
  unauthenticated,
  unauthorized,
  retryLimitExceeded,
  invalidChecksum,
  canceled,
  invalidEventName,
  invalidUrl,
  invalidArgument,
  noDefaultBucket,
  cannotSliceBlob,
  serverFileWrongSize
}

extension FirebaseExceptionsExtension on FirebaseExceptions {
  Failure getFailure() {
    switch (this) {
      case FirebaseExceptions.forbidden:
        return Failure(ResponseCode.forbidden, AppStrings.forbiddenError);
      case FirebaseExceptions.unhandled:
        return Failure(0, AppStrings.defaultError);
      case FirebaseExceptions.unknown:
        return Failure(ResponseCode.notFound, AppStrings.undefined);
      case FirebaseExceptions.objectNotFound:
        return Failure(ResponseCode.notFound, AppStrings.objectNotFound);
      case FirebaseExceptions.bucketNotFound:
        return Failure(ResponseCode.notFound, AppStrings.bucketNotFound);
      case FirebaseExceptions.projectNotFound:
        return Failure(ResponseCode.notFound, AppStrings.projectNotFound);
      case FirebaseExceptions.quotaExceeded:
        return Failure(ResponseCode.notFound, AppStrings.quotaExceeded);
      case FirebaseExceptions.unauthenticated:
        return Failure(ResponseCode.unauthorized, AppStrings.unauthenticated);
      case FirebaseExceptions.unauthorized:
        return Failure(ResponseCode.unauthorized, AppStrings.unauthorizedError);
      case FirebaseExceptions.retryLimitExceeded:
        return Failure(
            ResponseCode.bandwidthLimitExceeded, AppStrings.retryLimitExceeded);
      case FirebaseExceptions.invalidChecksum:
        return Failure(ResponseCode.notFound, AppStrings.invalidChecksum);
      case FirebaseExceptions.canceled:
        return Failure(ResponseCode.cancel, AppStrings.canceled);
      case FirebaseExceptions.invalidEventName:
        return Failure(ResponseCode.notFound, AppStrings.invalidEventName);
      case FirebaseExceptions.invalidUrl:
        return Failure(ResponseCode.notFound, AppStrings.invalidUrl);
      case FirebaseExceptions.invalidArgument:
        return Failure(ResponseCode.notFound, AppStrings.invalidArgument);
      case FirebaseExceptions.noDefaultBucket:
        return Failure(ResponseCode.notFound, AppStrings.noDefaultBucket);
      case FirebaseExceptions.cannotSliceBlob:
        return Failure(ResponseCode.notFound, AppStrings.cannotSliceBlob);
      case FirebaseExceptions.serverFileWrongSize:
        return Failure(ResponseCode.notFound, AppStrings.serverFileWrongSize);
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
      case "storage/unknown":
        status = FirebaseExceptions.unknown;
        break;
      case "storage/object-not-found":
        status = FirebaseExceptions.objectNotFound;
        break;
      case "storage/bucket-not-found":
        status = FirebaseExceptions.bucketNotFound;
        break;
      case "storage/project-not-found":
        status = FirebaseExceptions.projectNotFound;
        break;
      case "storage/quota-exceeded":
        status = FirebaseExceptions.quotaExceeded;
        break;
      case "storage/unauthenticated":
        status = FirebaseExceptions.unauthenticated;
        break;
      case "storage/unauthorized":
        status = FirebaseExceptions.unauthorized;
        break;
      case "storage/retry-limit-exceeded":
        status = FirebaseExceptions.retryLimitExceeded;
        break;
      case "storage/invalid-checksum":
        status = FirebaseExceptions.invalidChecksum;
        break;
      case "storage/canceled":
        status = FirebaseExceptions.canceled;
        break;
      case "storage/invalid-event-name":
        status = FirebaseExceptions.invalidEventName;
        break;
      case "storage/invalid-url":
        status = FirebaseExceptions.invalidUrl;
        break;
      case "storage/invalid-argument":
        status = FirebaseExceptions.invalidArgument;
        break;
      case "storage/no-default-bucket":
        status = FirebaseExceptions.noDefaultBucket;
        break;
      case "storage/cannot-slice-blob":
        status = FirebaseExceptions.cannotSliceBlob;
        break;
      case "storage/server-file-wrong-size":
        status = FirebaseExceptions.serverFileWrongSize;
        break;

      default:
        status = FirebaseExceptions.unhandled;
    }

    return status;
  }
}
