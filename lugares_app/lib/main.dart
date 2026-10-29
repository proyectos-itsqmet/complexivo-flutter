import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lugares_app/app.dart';
import 'package:lugares_app/core/config/app_env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: AppEnv.projectUrl,
    publishableKey: AppEnv.publishableKey,
  );

  runApp(const App());
}
