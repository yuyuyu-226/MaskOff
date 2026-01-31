import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../models/post.dart';
import 'support_feed_screen.dart';

class AIDetectionScreen extends StatelessWidget {
  final String text;
  final Emotion emotion;

  const AIDetectionScreen({
    super.key,
    required this.text,
    required this.emotion,
  });

  @override
  Widget build(BuildContext context) {
    // Your specific color palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);
    const Color colorPrimaryBrand = Color(0xFF6F5D4E);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // 1. AI Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: colorPrimaryBrand),
                    const SizedBox(width: 8),
                    const Text(
                      "AI-detected emotion",
                      style: TextStyle(
                        fontSize: 14,
                        color: colorSecondaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 2. Central Emotion Visualization (Circles)
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer soft circle
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorPrimaryBrand.withValues(alpha: 0.05),
                    ),
                  ),
                  // Middle soft circle
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorPrimaryBrand.withValues(alpha: 0.1),
                    ),
                  ),
                  // Inner solid emotion circle
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: emotion.color.withValues(alpha: 0.8), // Using emotion's color
                      boxShadow: [
                        BoxShadow(
                          color: emotion.color.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 3. Feedback Text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32,
                    color: colorPrimaryText,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                  children: [
                    const TextSpan(text: "It sounds like you're\nfeeling "),
                    TextSpan(
                      text: emotion.label.toLowerCase(),
                      style: TextStyle(
                        color: emotion.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "It's normal to not have all the answers.",
                style: TextStyle(
                  fontSize: 16,
                  color: colorSecondaryText,
                ),
              ),

              const Spacer(flex: 2),

              // 4. Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryBrand,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    final myPost = Post(
                      text: text,
                      emotion: emotion,
                      timeAgo: "Just now",
                      isPinned: true,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupportFeedScreen(myPost: myPost),
                      ),
                    );
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 5. Footer Text
              Text(
                "Your expression has been shared anonymously with the community",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: colorHintText,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}