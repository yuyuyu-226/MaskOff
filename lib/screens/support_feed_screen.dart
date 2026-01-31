import 'package:flutter/material.dart';
import '../models/post.dart';

class SupportFeedScreen extends StatelessWidget {
  final Post? myPost;

  const SupportFeedScreen({super.key, this.myPost});

  @override
  Widget build(BuildContext context) {
    // Color Palette
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Support Feed',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: colorPrimaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Everyone here is anonymous. Show them they\'re not alone.',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorSecondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // 2. Scrollable Feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  // PINNED POST (User's Recent Post - Only shows if myPost is not null)
                  if (myPost != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: FeedCard(
                        myPost: true,
                        category: myPost!.emotion.label,
                        categoryColor: myPost!.emotion.color,
                        content: myPost!.text,
                        timeAgo: myPost!.timeAgo,
                        timeLeft: '24h left',
                        hearYouCount: 0,
                        notAloneCount: 0,
                      ),
                    ),

                  // "Other stories" Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Other stories',
                            style: TextStyle(color: colorHintText, fontSize: 14),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                  ),

                  // MOCK DATA FEED
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const FeedCard(
                          category: 'Overwhelmed',
                          categoryColor: Colors.blue,
                          content:
                          'I feel like I\'m drowning in responsibilities. Every time I finish one thing, three more appear.',
                          timeAgo: '12 min ago',
                          timeLeft: '23h left',
                          hearYouCount: 8,
                          notAloneCount: 12,
                        ),
                        const SizedBox(height: 16),
                        const FeedCard(
                          category: 'Anxious',
                          categoryColor: Colors.orange,
                          content:
                          'My heart won\'t stop racing. I know logically everything is okay but my body...',
                          timeAgo: '28 min ago',
                          timeLeft: '24h left',
                          hearYouCount: 15,
                          notAloneCount: 22,
                        ),
                        const SizedBox(height: 16),
                        const FeedCard(
                          category: 'Sad',
                          categoryColor: Colors.deepPurpleAccent,
                          content:
                          'Today is harder than usual. I miss who I used to be.',
                          timeAgo: '6 hours ago',
                          timeLeft: '18h left',
                          hearYouCount: 13,
                          notAloneCount: 16,
                        ),
                      ],
                    ),
                  ),

                  // 3. Go Back Button
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 2,
                        shadowColor: Colors.black26,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final bool isPinned;
  final bool myPost;
  final String category;
  final Color categoryColor;
  final String content;
  final String timeAgo;
  final String timeLeft;
  final int hearYouCount;
  final int notAloneCount;

  const FeedCard({
    super.key,
    this.isPinned = false,
    this.myPost = false,
    required this.category,
    required this.categoryColor,
    required this.content,
    required this.timeAgo,
    required this.timeLeft,
    required this.hearYouCount,
    required this.notAloneCount,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorHintText = Color(0xFFB6B1AA);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorHintText.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Show pin icon if it is an official pinned post OR the user's recent post
              if (isPinned || myPost) ...[
                const Icon(Icons.push_pin, size: 16, color: colorPrimaryText),
                const SizedBox(width: 8),
              ],
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: categoryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '$timeAgo • $timeLeft',
                style: const TextStyle(color: colorHintText, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: colorPrimaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: 'I hear you',
                count: hearYouCount,
              ),
              const SizedBox(width: 12),
              _ActionButton(
                icon: Icons.favorite_border,
                label: 'Not alone',
                count: notAloneCount,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB6B1AA).withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF8C837A)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF3F3A36), fontSize: 14),
            ),
            const SizedBox(width: 4),
            Text(
              '($count)',
              style: const TextStyle(color: Color(0xFFB6B1AA), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}