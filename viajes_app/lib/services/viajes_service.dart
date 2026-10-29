import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:viajes_app/models/viaje.dart';

class ViajesService {
  final _db = Supabase.instance.client;

  String get _usuarioId => _db.auth.currentUser!.id;
  String _fechaSql(DateTime f) => f.toIso8601String().split('T').first;

  Future<List<Viaje>> listar() async {
    final datos = await _db
        .from('viajes')
        .select()
        .eq('usuario_id', _usuarioId)
        .order('fecha');
    return datos.map((e) => Viaje.fromJson(e)).toList();
  }

  Future<void> crear(String pais, DateTime fecha, String nota) async {
    await _db.from('viajes').insert({
      'pais': pais,
      'fecha': _fechaSql(fecha),
      'nota': nota,
    });
  }

  Future<void> editar(int id, DateTime fecha, String nota) async {
    await _db
        .from('viajes')
        .update({'fecha': _fechaSql(fecha), 'nota': nota})
        .eq('id', id);
  }

  Future<void> eliminar(int id) async {
    await _db.from('viajes').delete().eq('id', id);
  }
}
