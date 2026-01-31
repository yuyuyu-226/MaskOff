import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/emotion.dart';
import 'support_feed_screen.dart'; // Reuse the FeedCard widget from here

class EmotionFilteredStories extends StatelessWidget {
  final Emotion emotion;
  const EmotionFilteredStories({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    // Colors from your palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);

    // Filter globalFeed based on the selected emotion label
    final filteredPosts = globalFeed
        .where((p) => p.emotion.label == emotion.label)
        .toList();

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 1. FIXED HEADER
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        color: colorPrimaryText,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${emotion.label} Stories",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: colorPrimaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reading how others feel about being ${emotion.label.toLowerCase()}.',
                    style: const TextStyle(fontSize: 16, color: colorSecondaryText),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 2. SCROLLABLE CONTAINER FOR STORIES
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: filteredPosts.isEmpty
                    ? const Center(
                  child: Text(
                    "No stories yet for this emotion.",
                    style: TextStyle(color: colorSecondaryText),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = filteredPosts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: FeedCard(
                        category: post.emotion.label,
                        categoryColor: post.emotion.color,
                        content: post.text,
                        timeAgo: post.timeAgo,
                        timeLeft: '24h left',
                        hearYouCount: post.hearCount,
                        notAloneCount: post.aloneCount,
                      ),
                    );
                  },
                ),
              ),
            ),

            // 3. FIXED FOOTER (Always Visible)
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 4,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Go back to Home',
                    style: TextStyle(
                      color: colorPrimaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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