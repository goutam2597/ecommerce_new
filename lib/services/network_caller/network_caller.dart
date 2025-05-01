import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String errorMessage;
  final Map<String, dynamic>? responseJson;

  NetworkResponse({
    this.responseJson,
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(String url, {String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      if (accessToken != null) {
        headers['token'] = accessToken;
      }
      _logRequest(url);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
          responseJson: decoded, // ✅ Added
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decoded['message']?.toString() ?? 'Something went wrong',
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(String url, [Map<String, dynamic>? body]) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      _logRequest(url, headers, body);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded,
          responseJson: decoded, // ✅ Added
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decoded['message']?.toString() ?? 'Something went wrong',
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, [Map<String, dynamic>? headers, dynamic body]) {
    _logger.i('🔍 REQUEST:\nURL => $url\nHEADERS => $headers\nBODY => $body');
  }

  void _logResponse(String url, int statusCode, Map<String, String>? headers, String body, [String? errorMessage]) {
    if (errorMessage != null) {
      _logger.e('ERROR:\nURL => $url\nError Message => $errorMessage');
    } else {
      _logger.i('RESPONSE:\nURL => $url\nStatusCode => $statusCode\nHEADERS => $headers\nBODY => $body');
    }
  }
}
