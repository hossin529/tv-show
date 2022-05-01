import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tv_shows/config/app_config.dart';
import 'package:tv_shows/helpers/exceptions/ApiException.dart';
import 'package:tv_shows/helpers/exceptions/FetchDataException.dart';

class Api {
  static final Api _api = Api._internal();

  final String url = AppConfig.baseUrl;
  final String path = AppConfig.path;
  final String token = AppConfig.accessToken;

  factory Api() {
    return _api;
  }

  Api._internal();

  Future<dynamic> httpGet(String endPath,
      {Map<String, String>? query, bool publicApi = false}) async {
    Uri uri = Uri.http(url, "$path/$endPath", query);
    print(uri);
    final dynamic responseJson;
    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    var responseJson = json.decode(response.body.toString());
    print('responseJson $responseJson');
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
        return responseJson;
      case HttpStatus.badRequest:
        var exception = _parseError(responseJson);
        throw BadRequestException(
            exception['error'], exception['code'], exception['lang']);
      case HttpStatus.notFound:
        var exception = _parseError(responseJson);
        throw NotFoundException(
            exception['error'], exception['code'], exception['lang']);

      case HttpStatus.internalServerError:
      default:
        var exception = _parseError(responseJson);
        throw FetchDataException(
            exception['error'], exception['code'], exception['lang']);
    }
  }

  HashMap<String, String> _parseError(dynamic responseJson) {
    HashMap<String, String> parsedErrors = HashMap();
    parsedErrors['error'] = responseJson['error'].toString();
    parsedErrors['code'] = responseJson['code'].toString();
    parsedErrors['lang'] = responseJson['lang'].toString();
    return parsedErrors;
  }

  HashMap<String, String> _parseValidationErrors(dynamic responseJson) {
    HashMap<String, String> parsedErrors = HashMap();
    parsedErrors['errors'] = responseJson['errors'].toString();
    parsedErrors['code'] = responseJson['code'].toString();
    parsedErrors['lang'] = responseJson['lang'].toString();
    return parsedErrors;
  }
}
