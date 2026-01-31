import 'package:flutter/material.dart';
import 'package:mask_off/data/app_data.dart';
import 'package:mask_off/screens/drop_mask_screen.dart';
import '../models/emotion.dart';
import '../models/post.dart';
import 'support_feed_screen.dart';

class AIDetectionScreen extends StatefulWidget {
  final String text;
  final Emotion emotion;
  final String postId;

  const AIDetectionScreen({
    super.key,
    required this.postId,
    required this.text,
    required this.emotion,
  });

  @override
  State<AIDetectionScreen> createState() => _AIDetectionScreenState();
}

class _AIDetectionScreenState extends State<AIDetectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // Slower for a calming ripple
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

              // 1. Central Ripple Emotion Visualization
              SizedBox(
                width: 300,
                height: 300,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // We generate 3 ripple layers
                        ...List.generate(3, (index) {
                          // Each ripple is delayed based on its index
                          double progress = (_controller.value + (index / 3)) % 1.0;
                          double opacity = 1.0 - progress; // Fade out as it expands
                          double size = 100 + (progress * 150); // Expand from 100 to 250

                          return Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.emotion.color.withValues(alpha: opacity * 0.3),
                            ),
                          );
                        }),
                        
                        // Inner solid emotion circle (The core)
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.emotion.color,
                            boxShadow: [
                              BoxShadow(
                                color: widget.emotion.color.withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              // 2. Feedback Text
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
                      text: widget.emotion.label.toLowerCase(),
                      style: TextStyle(
                        color: widget.emotion.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "It's normal to not have all the answers.",
                style: TextStyle(
                  fontSize: 16,
                  color: colorSecondaryText,
                ),
              ),

              const Spacer(flex: 2),

              // 3. Continue Button
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
                      id: widget.postId,
                      text: widget.text,
                      emotion: widget.emotion,
                      timeAgo: "Just now",
                      isPinned: true,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (emotions == emotions[8]) ? SupportFeedScreen(myPost: myPost) : DropMaskScreen(),
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

              // 4. Footer Text
              const Text(
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