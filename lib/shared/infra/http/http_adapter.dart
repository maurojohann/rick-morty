import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../data/http/datasources/http_client_datasources.dart';
import '../../data/http/error/http_error.dart';

class HttpAdapter implements HttpClientDataSources {
  final http.Client client;

  HttpAdapter(this.client);

  @override
  Future<Map?> request({required String url, required String method}) async {
    http.Response response = http.Response('', 500);
    if (method == 'get') {
      response = await client.get(Uri.parse(url));
    }

    return _handleResult(response);
  }

  Map? _handleResult(http.Response response) {
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    } else if (response.statusCode == 200 && response.body.isEmpty) {
      throw HttpError.invalidResponse;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
