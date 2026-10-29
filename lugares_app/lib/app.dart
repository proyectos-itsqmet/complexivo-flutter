import 'package:flutter/material.dart';
import 'package:lugares_app/screens/home_screen.dart';
import 'package:lugares_app/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: Supabase.instance.client.auth.currentSession == null
          ? LoginScreen()
          : HomeScreen(),
    );
  }
}
