import 'package:flutter/material.dart';
import 'package:mask_off/services/support_feed_service.dart';
import '../models/emotion.dart';
import '../models/post.dart';
import 'support_feed_screen.dart';

class EmotionFilteredStories extends StatelessWidget {
  final Emotion emotion;
  final FirebasePostService _service = FirebasePostService();

  EmotionFilteredStories({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);

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
                      Expanded(
                        child: Text(
                          "${emotion.label} Stories",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w300,
                            color: colorPrimaryText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reading how others feel about being ${emotion.label.toLowerCase()}.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: colorSecondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 2. SCROLLABLE FEED (SAME STYLE AS SUPPORT FEED)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: FutureBuilder<List<Post>>(
                  future: _service.getPostsByEmotion(emotion.label),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF6F5D4E),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Failed to load stories'),
                      );
                    }

                    final posts = snapshot.data ?? [];

                    // CHANGE: Sorting b.compareTo(a) ensures newest DateTime is at index 0
                    posts.sort((a, b) => b.timeAgo.compareTo(a.timeAgo));

                    if (posts.isEmpty) {
                      return const Center(
                        child: Text(
                          'No stories yet for this emotion.',
                          style: TextStyle(color: colorSecondaryText),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: posts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        return FeedCard(
                          postId: post.id,
                          category: post.emotion.label,
                          categoryColor: post.emotion.color,
                          content: post.text,
                          timeAgo: timeAgoString(post.timeAgo),
                          timeLeft: '24h left',
                          hearYouCount: post.hearCount,
                          notAloneCount: post.aloneCount,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // 3. FIXED FOOTER
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 4,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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