import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_off/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mask_off/services/seeder.dart';
import 'firebase_options.dart';

void main() async{
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
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
