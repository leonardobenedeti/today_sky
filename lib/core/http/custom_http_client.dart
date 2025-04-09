import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CustomHttpClient extends http.BaseClient {
  final http.Client _httpClient;

  CustomHttpClient([http.Client? client])
      : _httpClient = client ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    String? apiKey = dotenv.env['NASA_API_KEY'];
    apiKey ??= 'DEMO_KEY';

    final url = request.url.replace(queryParameters: {
      ...request.url.queryParameters,
      'api_key': apiKey,
    });

    final newRequest = http.Request(request.method, url)
      ..headers.addAll(request.headers)
      ..bodyBytes = (request is http.Request) ? request.bodyBytes : [];

    return _httpClient.send(newRequest);
  }
}
