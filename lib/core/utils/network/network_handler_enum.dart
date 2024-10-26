enum NetworkStatus {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  notAcceptable,
  requestTimeout,
  conflict,
  gone,
  lengthRequired,
  preconditionFailed,
  payloadTooLarge,
  uriTooLong,
  unsupportedMediaType,
  rangeNotSatisfiable,
  expectationFailed,
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
  httpVersionNotSupported,
  networkAuthenticationRequired,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  cancel,
  connectionError,
  unknown,
  noInternetConnection,
  socketException,
  others;

  int get value {
    switch (this) {
      case NetworkStatus.socketException:
        return -10;
      case NetworkStatus.noInternetConnection:
        return -9;
      case NetworkStatus.connectionTimeout:
        return -8;
      case NetworkStatus.sendTimeout:
        return -7;
      case NetworkStatus.receiveTimeout:
        return -6;
      case NetworkStatus.badCertificate:
        return -5;
      case NetworkStatus.cancel:
        return -4;
      case NetworkStatus.connectionError:
        return -3;
      case NetworkStatus.unknown:
        return -2;
      case NetworkStatus.others:
        return -1;
      case NetworkStatus.badRequest:
        return 400;
      case NetworkStatus.unauthorized:
        return 401;
      case NetworkStatus.forbidden:
        return 403;
      case NetworkStatus.notFound:
        return 404;
      case NetworkStatus.methodNotAllowed:
        return 405;
      case NetworkStatus.notAcceptable:
        return 406;
      case NetworkStatus.requestTimeout:
        return 408;
      case NetworkStatus.conflict:
        return 409;
      case NetworkStatus.gone:
        return 410;
      case NetworkStatus.lengthRequired:
        return 411;
      case NetworkStatus.preconditionFailed:
        return 412;
      case NetworkStatus.payloadTooLarge:
        return 413;
      case NetworkStatus.uriTooLong:
        return 414;
      case NetworkStatus.unsupportedMediaType:
        return 415;
      case NetworkStatus.rangeNotSatisfiable:
        return 416;
      case NetworkStatus.expectationFailed:
        return 417;
      case NetworkStatus.internalServerError:
        return 500;
      case NetworkStatus.notImplemented:
        return 501;
      case NetworkStatus.badGateway:
        return 502;
      case NetworkStatus.serviceUnavailable:
        return 503;
      case NetworkStatus.gatewayTimeout:
        return 504;
      case NetworkStatus.httpVersionNotSupported:
        return 505;
      case NetworkStatus.networkAuthenticationRequired:
        return 511;
    }
  }

  static NetworkStatus setStatusFromCode(int code) {
    switch (code) {
      case 400:
        return NetworkStatus.badRequest;
      case 401:
        return NetworkStatus.unauthorized;
      case 403:
        return NetworkStatus.forbidden;
      case 404:
        return NetworkStatus.notFound;
      case 405:
        return NetworkStatus.methodNotAllowed;
      case 406:
        return NetworkStatus.notAcceptable;
      case 408:
        return NetworkStatus.requestTimeout;
      case 409:
        return NetworkStatus.conflict;
      case 410:
        return NetworkStatus.gone;
      case 411:
        return NetworkStatus.lengthRequired;
      case 412:
        return NetworkStatus.preconditionFailed;
      case 413:
        return NetworkStatus.payloadTooLarge;
      case 414:
        return NetworkStatus.uriTooLong;
      case 415:
        return NetworkStatus.unsupportedMediaType;
      case 416:
        return NetworkStatus.rangeNotSatisfiable;
      case 417:
        return NetworkStatus.expectationFailed;
      case 500:
        return NetworkStatus.internalServerError;
      case 501:
        return NetworkStatus.notImplemented;
      case 502:
        return NetworkStatus.badGateway;
      case 503:
        return NetworkStatus.serviceUnavailable;
      case 504:
        return NetworkStatus.gatewayTimeout;
      case 505:
        return NetworkStatus.httpVersionNotSupported;
      case 511:
        return NetworkStatus.networkAuthenticationRequired;
      case -10:
        return NetworkStatus.socketException;
      case -9:
        return NetworkStatus.noInternetConnection;
      case -8:
        return NetworkStatus.connectionTimeout;
      case -7:
        return NetworkStatus.sendTimeout;
      case -6:
        return NetworkStatus.receiveTimeout;
      case -5:
        return NetworkStatus.badCertificate;
      case -4:
        return NetworkStatus.cancel;
      case -3:
        return NetworkStatus.connectionError;
      case -2:
        return NetworkStatus.unknown;
      case -1:
        return NetworkStatus.others;
      default:
        return NetworkStatus.unknown; // Default case for any unhandled status code
    }
  }
}