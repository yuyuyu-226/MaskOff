import 'package:flutter/material.dart';
import 'package:mask_off/services/drop_mask_service.dart';
import 'ai_detection_screen.dart';
import '../models/emotion.dart';
import '../data/app_data.dart'; 
import '../services/analyze.dart';

class DropMaskScreen extends StatefulWidget {
  const DropMaskScreen({super.key});

  @override
  State<DropMaskScreen> createState() => _DropMaskScreenState();
}

class _DropMaskScreenState extends State<DropMaskScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  // NEW: Loading state variable
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
                        // NEW: Disable input during loading
                        enabled: !_isLoading,
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  // NEW: Disable if either the button is not enabled OR it's currently loading
                  onPressed: (_isButtonEnabled && !_isLoading) ? () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      // 1. Get the emotion string from the AI
                      String aiResponse = await analyzeEmotion(_controller.text);

                      // 2. Find the full Emotion object
                      final selectedEmotion = emotions.firstWhere(
                        (e) => e.label.toLowerCase() == aiResponse.toLowerCase(),
                        orElse: () => emotions[0],
                      );

                      // 3. Send to database
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

                      if (!mounted) return;

                      // 4. Navigate
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AIDetectionScreen(
                            text: _controller.text,
                            emotion: selectedEmotion,
                          ),
                        ),
                      );
                    } finally {
                      // NEW: Reset loading state if we return to this screen 
                      // or if an error occurred.
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryBrand,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: colorPrimaryBrand.withValues(alpha: 0.5),
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
                    elevation: (_isButtonEnabled && !_isLoading) ? 2 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // NEW: Show spinner or text based on loading state
                  child: _isLoading 
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
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