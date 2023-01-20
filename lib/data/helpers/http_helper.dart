import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:marketplace/data/exceptions/api_exception.dart';

/// A `static` helepr for `HTTP` requests throughout the application.
class HttpHelper {
  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type,
      Map<String, String>? headers, Object? body, Encoding? encoding) async {
    http.Response? response;
    Map<String, dynamic> responseBody;
    try {
      final requestBody = jsonEncode(body);
      response = await _invoke(url, type, headers, requestBody, encoding);
    } catch (error) {
      rethrow;
    }

    if (response != null) {
      String data = response.body;
      responseBody = jsonDecode(data);
    } else {
      responseBody = {
        "message": "Response is empty",
      };
    }
    return responseBody;
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response?> _invoke(dynamic url, RequestType type,
      Map<String, String>? headers, Object? body, Encoding? encoding) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }

      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;

      // handle no internet connection
    } on SocketException catch (e) {
      if (e.osError != null) {
        throw Exception(e.osError!.message);
      }
    } catch (error) {
      rethrow;
    }

    return null;
  }
}

// types used by the helper
enum RequestType { get, post, put, delete }
