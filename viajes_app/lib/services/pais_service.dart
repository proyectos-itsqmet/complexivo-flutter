import 'package:dio/dio.dart';
import 'package:viajes_app/configs/app_env.dart';
import 'package:viajes_app/models/pais.dart';

class PaisService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.restcountries.com/countries/v5',
      headers: {'Authorization': 'Bearer ${AppEnv.restCountriesKey}'},
    ),
  );

  Future<List<Pais>> buscar(String texto) async {
    try {
      final res = await _dio.get(
        '/name',
        queryParameters: {
          'q': texto,
          'response_fields':
              'names.common,names.official,capitals,population,flag.url_png',
        },
      );

      final objetos = res.data['data']['objects'] as List;
      return objetos
          .map((e) => Pais.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }
}
