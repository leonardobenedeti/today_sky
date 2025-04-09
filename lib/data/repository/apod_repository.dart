import 'package:today_sky/core/http/custom_http_client.dart';
import 'package:today_sky/data/model/apod_request_data_model.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';

class ApodRepository {
  final CustomHttpClient _httpClient;
  final baseURL = Uri.parse('https://api.nasa.gov/planetary/apod');

  ApodRepository([CustomHttpClient? client])
      : _httpClient = client ?? CustomHttpClient();

  Future<ApodResponseDataModel> fetchApod(
      {ApodRequestDataModel? requestParams}) async {
    final response = await _httpClient
        .get(baseURL.replace(queryParameters: requestParams?.toMap()));

    return ApodResponseDataModel.fromJson(response.body);
  }
}
