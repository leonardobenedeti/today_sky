import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_sky/core/http/custom_http_client.dart';
import 'package:today_sky/data/repository/apod_repository.dart';

class DependencyInjector {
  static final GetIt get = GetIt.instance;

  static Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    get.registerSingleton<SharedPreferences>(sharedPrefs);

    final httpClient = CustomHttpClient();
    get.registerSingleton<CustomHttpClient>(httpClient);

    get.registerSingleton<ApodRepository>(
      ApodRepository(sharedPrefs: sharedPrefs, httpClient: httpClient),
    );
  }
}
