import 'package:flutter/material.dart';
import 'package:mask_off/services/drop_mask_service.dart';
import 'ai_detection_screen.dart';
import '../models/emotion.dart';
import '../data/app_data.dart'; // Import this to access your emotions list
import '../services/analyze.dart';


class DropMaskScreen extends StatefulWidget {
  const DropMaskScreen({super.key});

  @override
  State<DropMaskScreen> createState() => _DropMaskScreenState();
}

class _DropMaskScreenState extends State<DropMaskScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Listener to toggle the button state based on text input
    _controller.addListener(() {
      final isNotEmpty = _controller.text.trim().isNotEmpty;
      if (isNotEmpty != _isButtonEnabled) {
        setState(() {
          _isButtonEnabled = isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Brand Color Palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);
    const Color colorPrimaryBrand = Color(0xFF6F5D4E);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Fixed Header (Back Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  color: colorPrimaryText,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // 2. Scrollable Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'What mask are you wearing\nright now?',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: colorPrimaryText,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "You don't have to explain. Just say it.",
                      style: TextStyle(fontSize: 14, color: colorSecondaryText),
                    ),
                    const SizedBox(height: 24),

                    // The Input Box
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorHintText.withValues(alpha: 0.3),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 18,
                          color: colorPrimaryText,
                        ),
                        decoration: const InputDecoration(
                          hintText: "I'm pretending everything is fine...",
                          hintStyle: TextStyle(color: colorHintText),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your words stay anonymous. No one will know it’s you.',
                      style: TextStyle(fontSize: 12, color: colorHintText),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 3. Fixed Footer (Submit Button)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? () async {
                    // 1. Get the emotion string from the AI
                    String aiResponse = await analyzeEmotion(_controller.text);

                    // 2. Find the full Emotion object that matches that name
                    final selectedEmotion = emotions.firstWhere(
                      (e) => e.label.toLowerCase() == aiResponse.toLowerCase(),
                      orElse: () => emotions[0], // Fallback to 'Numb' if no match
                    );

                    // 3. Send all attributes to the database
                    final DropMaskService database = DropMaskService();
                    await database.createPost(
                      text: _controller.text,
                      emotionLabel: selectedEmotion.label,
                      severity: selectedEmotion.severity,
                      category: selectedEmotion.category,
                      isPositive: selectedEmotion.isPositive,
                      hearYouCount: 0,
                      notAloneCount: 0
                    );

                    // 4. Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AIDetectionScreen(
                          text: _controller.text,
                          emotion: selectedEmotion,
                        ),
                      ),
                    );
                  } : null, // Button remains locked if textbox is empty
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryBrand,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                    colorPrimaryBrand.withValues(alpha: 0.5),
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
                    elevation: _isButtonEnabled ? 2 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Drop the mask',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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