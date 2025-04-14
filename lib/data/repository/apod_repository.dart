import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_sky/core/dependency_injector.dart';
import 'package:today_sky/core/http/custom_http_client.dart';
import 'package:today_sky/data/model/apod_request_data_model.dart';
import 'package:today_sky/data/model/apod_response_data_model.dart';

class ApodRepository {
  final CustomHttpClient _httpClient;
  final SharedPreferences _sharedPreferences;
  final _favoritesKey = 'favorites-skies';
  final _baseURL = Uri.parse('https://api.nasa.gov/planetary/apod');

  ApodRepository({CustomHttpClient? httpClient, SharedPreferences? sharedPrefs})
      : _httpClient = httpClient ?? DependencyInjector.get<CustomHttpClient>(),
        _sharedPreferences =
            sharedPrefs ?? DependencyInjector.get<SharedPreferences>();

  Future<ApodResponseDataModel> fetchApod(
      {ApodRequestDataModel? requestParams}) async {
    final request = requestParams ?? ApodRequestDataModel.defaultRequest();

    final response = await _httpClient
        .get(_baseURL.replace(queryParameters: request.toMap()));

    return ApodResponseDataModel.fromJson(response.body);
  }

  List<ApodResponseDataModel> fetchFavorites() {
    final result = _sharedPreferences.getString(_favoritesKey);
    if (result == null) return [];
    log(result);

    final List decodedJson = json.decode(result);
    final apodList = decodedJson
        .map((json) => ApodResponseDataModel.fromJson(json))
        .toList();
    return apodList;
  }

  List<ApodResponseDataModel> checkFavorite(DateTime date) {
    final currentList = fetchFavorites();

    return currentList.where((favorite) => favorite.date == date).toList();
  }

  List<ApodResponseDataModel> selectFavorite(ApodResponseDataModel apod) {
    final currentList = fetchFavorites();

    if (checkFavorite(apod.date).isNotEmpty) {
      final updatedList =
          currentList.where((favorite) => favorite.date != apod.date).toList();
      final jsonString = json
          .encode(updatedList.map((favorite) => favorite.toJson()).toList());
      _sharedPreferences.setString(_favoritesKey, jsonString);

      return updatedList;
    }

    currentList.add(apod);
    final jsonString =
        json.encode(currentList.map((favorite) => favorite.toJson()).toList());
    _sharedPreferences.setString(_favoritesKey, jsonString);

    return currentList;
  }
}
