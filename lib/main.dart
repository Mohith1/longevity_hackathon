import 'package:flutter/material.dart';

// Import your two screens:
import 'login_screen.dart';
import 'survey_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare App',
      theme: ThemeData(
        // Keep your existing color‐scheme approach, just swap in your brand color:
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E9C1C)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // NO home: — we’ll drive everything via routes
      initialRoute: '/',
      routes: {
        // The “login_screen.dart” we built (Sign Up / Log In toggle)
        '/': (ctx) => const LoginScreen(),
        // The “survey_screen.dart” we built
        '/survey': (ctx) => const SurveyScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
