import 'dart:convert';

import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart';

import '../../utils/utils.dart';
import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    try {
      consolelog(getPath(path, params));
      consolelog(params);
      final response = await _client.post(
        getPath(path, null),
        body: jsonEncode(params),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      consolelog(json.decode(response.body));
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else if (response.statusCode == 401) {
    //   throw UnauthorizedException();
    // } else {
    //   throw Exception(response.reasonPhrase);
    // }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    Request request = Request('DELETE', getPath(path, null));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => Response.fromStream(value),
        );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    if (params == null) {
      return Uri.parse(ApiConstants.baseUrl + path);
    } else {
      var paramsString = '';
      params.forEach((key, value) {
        paramsString += '&$key=$value';
      });
      return Uri.parse('${ApiConstants.baseUrl}$path$paramsString');
    }
  }
}
