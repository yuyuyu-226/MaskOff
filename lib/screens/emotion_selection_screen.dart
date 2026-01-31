import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'emotion_filtered_stories.dart';

class EmotionSelectionScreen extends StatelessWidget {
  const EmotionSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand Color Palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How are you feeling?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: colorPrimaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Take a moment to identify your emotion",
                    style: TextStyle(
                      fontSize: 16,
                      color: colorSecondaryText,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Emotion Grid (Using Wrap for flexibility)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: emotions.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmotionFilteredStories(emotion: e),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 100, // Fixed width for consistent grid look
                        child: Column(
                          children: [
                            // Colored Circle Visualization
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: e.color.withValues(alpha: 0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Emotion Label
                            Text(
                              e.label,
                              style: TextStyle(
                                color: colorPrimaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 3. Simple Back Button (Optional Footer)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Go back",
                    style: TextStyle(color: colorSecondaryText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}