import 'package:lugares_app/models/lugar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LugarService {
  final _supabase = Supabase.instance.client;

  String get _usuarioId => _supabase.auth.currentUser!.id;

  Future<List<Lugar>> listar() async {
    final data = await _supabase.from('lugares').select().order('nombre');

    return data.map((i) => Lugar.fromJson(i)).toList();
  }

  Future<List<Lugar>> misLugares() async {
    final data = await _supabase
        .from('lugares_guardados')
        .select('lugares(*)')
        .eq('usuario_id', _usuarioId);

    return data.map((i) => Lugar.fromJson(i['lugares'])).toList();
  }

  Future<bool> estaGuardado(int lugarId) async {
    final data = await _supabase
        .from('lugares_guardados')
        .select('id')
        .eq('usuario_id', _usuarioId)
        .eq('lugar_id', lugarId)
        .maybeSingle();

    return data != null;
  }

  Future<void> guardar(int lugarId) async {
    await _supabase.from('lugares_guardados').insert({
      'usuario_id': _usuarioId,
      'lugar_id': lugarId,
    });
  }

  Future<void> quitar(int lugarId) async {
    await _supabase
        .from('lugares_guardados')
        .delete()
        .eq('usuario_id', _usuarioId)
        .eq('lugar_id', lugarId);
  }
}
