class ApiException implements Exception {
  String? message;
  String? code;
  String? lang;
  dynamic errors;
  ApiException({this.code, this.message, this.lang, this.errors});

  @override
  String toString() => message ?? '';
}

class BadRequestException extends ApiException {
  BadRequestException([message, code, lang])
      : super(message: message, code: code, lang: lang);
}

class NotFoundException extends ApiException {
  NotFoundException([message, code, lang])
      : super(message: message, code: code, lang: lang);
}

class InvalidInputException extends ApiException {
  InvalidInputException([message, code, lang])
      : super(message: message, code: code, lang: lang);
}
