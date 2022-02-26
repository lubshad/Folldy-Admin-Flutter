import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart';
// import "package:http/src/multipart_file.dart" as multipart;
import 'package:http_parser/http_parser.dart';

// import 'package:http/src/response.dart' as res;

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

  dynamic formData(
      {required Map<String, dynamic> data,
      required Map<String, PlatformFile> files,
      required String path}) async {
    consolelog(ApiConstants.baseUrl + path);
    consolelog(jsonEncode(data));
    consolelog(files);
    var request =
        MultipartRequest("POST", Uri.parse(ApiConstants.baseUrl + path));

    data.forEach((key, value) {
      if (value is List) {
        for (var element in value) {
          final index = value.indexOf(element);
          final fieldString = key + "[$index]";
          request.fields[fieldString] = element;
        }
      } else {
        request.fields[key] = value.toString();
      }
    });

    consolelog(request.fields);

    // ignore: avoid_function_literals_in_foreach_calls
    // images.forEach((image) async {
    //   final index = images.indexOf(image);
    //   var multipartFile = await MultipartFile.fromPath(
    //     "images[$index]",
    //     image.path,
    //     filename: "images[$index]",
    //     contentType: MediaType("image", "jpeg"),
    //   );
    //   request.files.add(multipartFile);
    // });
    files.forEach((key, value) async {
      var multipartFile = MultipartFile.fromBytes(key, value.bytes!.cast(),
          contentType: MediaType("image", "jpeg"));
      request.files.add(multipartFile);
    });
    // var multipartFile = await http.MultipartFile.fromPath(
    //   "finished_image",
    //   file.path,
    //   filename: basename(file.path),
    //   contentType: MediaType("image", "jpeg"),
    // );

    // request.files.add(multipartFile);
    final response = await request.send();
    var httpResponse = await Response.fromStream(response);
    final jsonresposne = json.decode(httpResponse.body);
    consolelog(jsonresposne);
    return jsonresposne;
  }

  dynamic post(String path, Map<dynamic, dynamic>? params) async {
    try {
      consolelog(getPath(path, null));
      consolelog(params);
      final response = await _client.post(
        getPath(path, null),
        body: jsonEncode(params),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      consolelog(json.decode(response.body));
      return json.decode(response.body);
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
