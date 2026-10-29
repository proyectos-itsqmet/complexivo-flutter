import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  User? get usuario => _supabase.auth.currentUser;

  Future<void> registrar(String nombre, String email, String password) async {
    await _supabase.auth.signUp(
      password: password,
      email: email,
      data: {'nombre': nombre},
    );
  }

  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
