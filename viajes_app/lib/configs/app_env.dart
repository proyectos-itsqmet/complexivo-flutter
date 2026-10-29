import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  static String get projectUrl => dotenv.get('PROJECT_URL');
  static String get publishableKey => dotenv.get('PUBLISHABLE_KEY');
  static String get restCountriesKey => dotenv.get('REST_COUNTRIES_KEY');
}
