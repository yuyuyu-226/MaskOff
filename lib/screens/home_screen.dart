import 'package:flutter/material.dart';
import 'drop_mask_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors from your palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);
    const Color colorPrimaryBrand = Color(0xFF6F5D4E);
    const Color colorSecondaryBrand = Color(0xFFE3D9CF);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Logo Section
              const Icon(
                Icons.face_retouching_off, //logo icon
                size: 80,
                color: colorPrimaryText,
              ),
              const SizedBox(height: 32),

              // 2. Main Titles
              const Text(
                'MaskOff',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: colorPrimaryText,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A quiet space to be honest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: colorSecondaryText,
                ),
              ),

              const Spacer(flex: 2),

              // 3. Action Buttons
              // Primary Button (Drop the mask)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DropMaskScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryBrand,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Drop the mask',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Secondary Button (How am I feeling?)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Match image look
                    side: BorderSide.none, // Clean look as per image
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'How am I feeling ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: colorPrimaryBrand,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // 4. Footer Text
              const Text(
                'Anonymous. Safe. Supportive.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorHintText,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}