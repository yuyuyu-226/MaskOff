import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_off/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mask_off/services/seeder.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await seedFirestore();
  runApp(const MaskOffApp());
}

class MaskOffApp extends StatelessWidget {
  const MaskOffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaskOff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F2EE),
        // Using apply to ensure the Inter font scales nicely
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      // The builder is key for global responsiveness
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        
        // 1. Cap the text scale factor
        // This prevents the UI from breaking on small screens 
        // if the user has massive font settings in their phone OS.
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 0.8, 
          maxScaleFactor: 1.2,
        );

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: scale,
          ),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}