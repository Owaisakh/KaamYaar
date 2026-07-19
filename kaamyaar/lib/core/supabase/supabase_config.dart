import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    // Load .env variables
    await dotenv.load(fileName: ".env");

    String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

    // If empty for now, just skip or print a warning to avoid crashing before keys are set
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      print('WARNING: Supabase URL or Anon Key is missing from .env file.');
      return;
    }

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
