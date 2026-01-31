import 'package:flutter/material.dart';
import '../models/post.dart';


class SupportFeedScreen extends StatelessWidget {
  final Post? myPost;

  const SupportFeedScreen({super.key, this.myPost});

  @override
  Widget build(BuildContext context) {
    const Color colorBackground = Color(0xFFF6EFE7);
    const Color colorPrimaryText = Color(0xFF3F3A36);
    const Color colorSecondaryText = Color(0xFF8C837A);
    const Color colorHintText = Color(0xFFB6B1AA);

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
                    style: TextStyle(fontSize: 16, color: colorSecondaryText),
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
                  // Optional: adds a very slight background to the scroll area
                  color: Colors.black.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    // USER'S RECENT POST
                    if (myPost != null) ...[
                      FeedCard(
                        myPost: true,
                        category: myPost!.emotion.label,
                        categoryColor: myPost!.emotion.color,
                        content: myPost!.text,
                        timeAgo: myPost!.timeAgo,
                        timeLeft: '24h left',
                        hearYouCount: 0,
                        notAloneCount: 0,
                      ),
                      const SizedBox(height: 10),
                    ],

                    // OTHER STORIES SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Other stories',
                                style: TextStyle(color: colorHintText, fontSize: 14)),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),

                    // THE LIST OF STORIES
                    const FeedCard(
                      category: 'Overwhelmed',
                      categoryColor: Color(0xFF6A94CC),
                      content: 'I feel like I\'m drowning in responsibilities. Every time I finish one thing, three more appear.',
                      timeAgo: '12 min ago',
                      timeLeft: '23h left',
                      hearYouCount: 8,
                      notAloneCount: 12,
                    ),
                    const SizedBox(height: 16),
                    const FeedCard(
                      category: 'Anxious',
                      categoryColor: Color(0xFFE5916E),
                      content: 'My heart won\'t stop racing. I know logically everything is okay but my body just won\'t calm down.',
                      timeAgo: '28 min ago',
                      timeLeft: '24h left',
                      hearYouCount: 15,
                      notAloneCount: 22,
                    ),
                    const SizedBox(height: 16),
                    const FeedCard(
                      category: 'Sad',
                      categoryColor: Color(0xFF9186A1),
                      content: 'Today is harder than usual. I miss the version of myself that didn\'t feel this heavy.',
                      timeAgo: '1 hour ago',
                      timeLeft: '22h left',
                      hearYouCount: 42,
                      notAloneCount: 31,
                    ),
                    const SizedBox(height: 16),
                    const FeedCard(
                      category: 'Lonely',
                      categoryColor: Color(0xFF6B9080),
                      content: 'Being in a room full of people and still feeling completely invisible.',
                      timeAgo: '3 hours ago',
                      timeLeft: '21h left',
                      hearYouCount: 5,
                      notAloneCount: 19,
                    ),
                    const SizedBox(height: 16),
                    const FeedCard(
                      category: 'Hopeful',
                      categoryColor: Color(0xFF7BA08E),
                      content: 'Finally had a good morning. The sun felt warm and for the first time in weeks, I didn\'t wake up with dread.',
                      timeAgo: '8 hours ago',
                      timeLeft: '16h left',
                      hearYouCount: 55,
                      notAloneCount: 12,
                    ),
                  ],
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
                      style: TextStyle(color: colorPrimaryText, fontSize: 18, fontWeight: FontWeight.w500)
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

class FeedCard extends StatefulWidget {
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
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  // Local state to track toggles
  bool isHeard = false;
  bool isNotAlone = false;

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
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.isPinned || widget.myPost) ...[
                const Icon(Icons.push_pin, size: 16, color: colorPrimaryText),
                const SizedBox(width: 8),
              ],
              Container(
                width: 12, height: 12,
                decoration: BoxDecoration(color: widget.categoryColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(widget.category, style: TextStyle(color: widget.categoryColor, fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              Text('${widget.timeAgo} • ${widget.timeLeft}', style: const TextStyle(color: colorHintText, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          Text(widget.content, style: const TextStyle(fontSize: 18, color: colorPrimaryText, height: 1.4)),
          const SizedBox(height: 20),
          Row(
            children: [
              _ActionButton(
                icon: isHeard ? Icons.chat_bubble : Icons.chat_bubble_outline,
                label: 'I hear you',
                count: isHeard ? widget.hearYouCount + 1 : widget.hearYouCount,
                isActive: isHeard,
                onTap: () => setState(() => isHeard = !isHeard),
              ),
              const SizedBox(width: 12),
              _ActionButton(
                icon: isNotAlone ? Icons.favorite : Icons.favorite_border,
                label: 'Not alone',
                count: isNotAlone ? widget.notAloneCount + 1 : widget.notAloneCount,
                isActive: isNotAlone,
                onTap: () => setState(() => isNotAlone = !isNotAlone),
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
  final bool isActive;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorPrimaryBrand = Color(0xFF6F5D4E);
    const Color colorHintText = Color(0xFFB6B1AA);
    const Color colorPrimaryText = Color(0xFF3F3A36);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? colorPrimaryBrand.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? colorPrimaryBrand : colorHintText.withValues(alpha: 0.3),
              width: isActive ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isActive ? colorPrimaryBrand : const Color(0xFF8C837A)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? colorPrimaryBrand : colorPrimaryText,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '($count)',
                style: TextStyle(
                  color: isActive ? colorPrimaryBrand : colorHintText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}