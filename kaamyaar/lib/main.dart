import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/supabase/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create a default .env file in the root if you don't have one
  await dotenv.load(fileName: ".env").catchError((_) {
    // ignore if not found during early init
  });
  
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: KaamYaarApp(),
    ),
  );
}

class KaamYaarApp extends ConsumerWidget {
  const KaamYaarApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'KaamYaar',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Switch based on system settings
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
