class Viaje {
  final int id;
  final String pais;
  final DateTime fecha;
  final String? nota;

  Viaje({required this.id, required this.pais, required this.fecha, this.nota});

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'] as int,
      pais: json['pais'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      nota: json['nota'] as String?,
    );
  }
}
