import 'dart:math';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/emotion.dart';
import 'emotion_filtered_stories.dart';

class EmotionSelectionScreen extends StatefulWidget {
  const EmotionSelectionScreen({super.key});

  @override
  State<EmotionSelectionScreen> createState() => _EmotionSelectionScreenState();
}

class _EmotionSelectionScreenState extends State<EmotionSelectionScreen> with TickerProviderStateMixin {
  Emotion? selectedEmotion;
  Emotion? hoveredEmotion;

  // Animation controllers for the entrance effect
  late AnimationController _centerController;
  late List<AnimationController> _emotionControllers;

  @override
  void initState() {
    super.initState();

    // 1. Initialize Center Circle Controller
    _centerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // 2. Initialize Controllers for each emotion
    _emotionControllers = List.generate(
      emotions.length,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    _startEntranceAnimation();
  }

  void _startEntranceAnimation() async {
    // Start Center Circle first
    _centerController.forward();

    // Randomize the order of emotions popping up
    List<int> indices = List.generate(emotions.length, (i) => i);
    indices.shuffle();

    for (int index in indices) {
      // Small random delay between each pop
      await Future.delayed(Duration(milliseconds: 100 + Random().nextInt(150)));
      if (mounted) {
        _emotionControllers[index].forward();
      }
    }
  }

  @override
  void dispose() {
    _centerController.dispose();
    for (var controller in _emotionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorPrimaryBrand = Color(0xFF6F5D4E);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 40, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How are you feeling?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: colorPrimaryText),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Take a moment to identify your emotion",
                    style: TextStyle(fontSize: 16, color: colorSecondaryText),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 420,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ANIMATED CENTRAL CIRCLE
                      ScaleTransition(
                        scale: CurvedAnimation(parent: _centerController, curve: Curves.easeOutBack),
                        child: FadeTransition(
                          opacity: _centerController,
                          child: _buildCentralCircle(),
                        ),
                      ),

                      // ANIMATED EMOTION CIRCLES
                      ...List.generate(emotions.length, (index) {
                        return FadeTransition(
                          opacity: _emotionControllers[index],
                          child: ScaleTransition(
                            scale: CurvedAnimation(
                              parent: _emotionControllers[index],
                              curve: Curves.easeOutBack,
                            ),
                            // Move the helper method call here
                            child: _buildCircularEmotion(index, emotions.length, emotions[index]),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedEmotion == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EmotionFilteredStories(emotion: selectedEmotion!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryBrand,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: colorPrimaryBrand.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Continue", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralCircle() {
    String centerLabel = "Select";
    const Color colorPrimaryText = Color(0xFF3F3A36);
    Color centerColor = colorPrimaryText;

    if (hoveredEmotion != null) {
      centerLabel = hoveredEmotion!.label;
      centerColor = hoveredEmotion!.color;
    } else if (selectedEmotion != null) {
      centerLabel = selectedEmotion!.label;
      centerColor = selectedEmotion!.color;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: centerColor.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Center(
        child: Text(
          centerLabel,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: centerColor, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildCircularEmotion(int index, int total, Emotion emotion) {
    // Calculate coordinates
    double angle = (index * 2 * pi / total) - (pi / 2);
    double radius = 145.0;
    double x = radius * cos(angle);
    double y = radius * sin(angle);

    bool isSelected = selectedEmotion == emotion;
    bool isHovered = hoveredEmotion == emotion;

    return Center( // Use Center + Transform to keep hit-testing accurate
      child: Transform.translate(
        offset: Offset(x, y),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque, // Ensures the whole area is clickable
          onTap: () {
            setState(() {
              selectedEmotion = emotion;
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => hoveredEmotion = emotion),
            onExit: (_) => setState(() => hoveredEmotion = null),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: isHovered || isSelected ? 65 : 55,
                  height: isHovered || isSelected ? 65 : 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: emotion.color,
                    border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                    boxShadow: [
                      BoxShadow(
                          color: emotion.color.withValues(alpha: 0.2),
                          blurRadius: isHovered ? 12 : 4
                      )
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 28)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  emotion.label,
                  style: TextStyle(
                    color: emotion.color,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}