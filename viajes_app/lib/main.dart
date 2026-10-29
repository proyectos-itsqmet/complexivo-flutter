import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:viajes_app/app.dart';
import 'package:viajes_app/configs/app_env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: AppEnv.projectUrl,
    publishableKey: AppEnv.publishableKey,
  );

  runApp(const App());
}
