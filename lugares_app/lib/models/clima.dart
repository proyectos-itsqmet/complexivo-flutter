class Clima {
  final double temperatura;
  final double viento;
  final int codigo;

  Clima({
    required this.temperatura,
    required this.viento,
    required this.codigo,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;

    return Clima(
      temperatura: (current['temperature_2m'] as num).toDouble(),
      viento: (current['wind_speed_10m'] as num).toDouble(),
      codigo: current['weather_code'] as int,
    );
  }

  String get description => switch (codigo) {
    0 => 'Despejado',
    1 || 2 || 3 => 'Parcialmente nublado',
    45 || 48 => 'Niebla',
    >= 51 && <= 67 => 'Lluvia',
    >= 71 && <= 77 => 'Nieve',
    >= 80 && <= 82 => 'Chubascos',
    _ => 'Desconocido',
  };
}
