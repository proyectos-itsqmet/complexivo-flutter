class Pais {
  final String nombre;
  final String nombreOficial;
  final String capital;
  final int poblacion;
  final String bandera;

  Pais({
    required this.nombre,
    required this.nombreOficial,
    required this.capital,
    required this.poblacion,
    required this.bandera,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    final capitales = json['capitals'] as List? ?? [];

    return Pais(
      nombre: json['names']['common'] as String,
      nombreOficial: json['names']['official'] as String,
      capital: capitales.isEmpty
          ? 'Sin capital'
          : capitales.first['name'] as String,
      poblacion: (json['population'] as num).toInt(),
      bandera: json['flag']['url_png'] as String,
    );
  }
}
