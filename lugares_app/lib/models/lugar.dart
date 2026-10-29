class Lugar {
  final int id;
  final String pais;
  final String ciudad;
  final String nombre;
  final double latitud;
  final double longitud;
  final double precio;
  final String? imagen;

  Lugar({
    required this.id,
    required this.pais,
    required this.ciudad,
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.precio,
    this.imagen,
  });

  factory Lugar.fromJson(Map<String, dynamic> json) {
    return Lugar(
      id: json['id'] as int,
      pais: json['pais'] as String,
      ciudad: json['ciudad'] as String,
      nombre: json['nombre'] as String,
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      precio: (json['precio'] as num).toDouble(),
      imagen: json['imagen'] as String?,
    );
  }
}
