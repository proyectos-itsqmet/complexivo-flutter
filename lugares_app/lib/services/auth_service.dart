import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  User? get usuario => _supabase.auth.currentUser;

  Future<void> registrar(String nombre, String email, String password) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'nombre': nombre},
    );
  }

  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
