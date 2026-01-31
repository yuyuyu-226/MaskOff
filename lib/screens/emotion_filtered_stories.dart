import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/emotion.dart';
import '../widgets/post_card.dart';

class EmotionFilteredStories extends StatelessWidget {
  final Emotion emotion;
  const EmotionFilteredStories({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    final filtered = globalFeed
        .where((p) => p.emotion.label == emotion.label)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("${emotion.label} Stories"),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (filtered.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text("No stories yet for this emotion."),
              ),
            )
          else
            ...filtered.map((p) => PostCard(post: p)).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            child: const Text("Go back to Home"),
          ),
        ],
      ),
    );
  }
}
