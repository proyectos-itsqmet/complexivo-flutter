import 'package:dio/dio.dart';
import 'package:lugares_app/models/clima.dart';

class ClimaService {
  final _dio = Dio();

  Future<Clima> obtener(double latitud, double longitud) async {
    final response = await _dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': latitud,
        'longitude': longitud,
        'current': 'temperature_2m,wind_speed_10m,weather_code',
      },
    );

    return Clima.fromJson(response.data);
  }
}
