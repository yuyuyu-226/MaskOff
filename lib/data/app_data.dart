import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../models/post.dart';

final List<Emotion> emotions = [
  Emotion("Numb", Colors.grey),
  Emotion("Joyful", Colors.amber),
  Emotion("Hopeful", const Color(0xFF7BA08E)),
  Emotion("Calm", Colors.cyan),
  Emotion("Anxious", const Color(0xFFE5916E)),
  Emotion("Overwhelmed", const Color(0xFF6A94CC)),
  Emotion("Sad", const Color(0xFF9186A1)),
  Emotion("Lonely", const Color(0xFF6B9080)),
];

List<Post> globalFeed = [
  Post(
    text: "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.",
    emotion: emotions[5], // Overwhelmed
    timeAgo: "12 min ago",
    hearCount: 8,
    aloneCount: 12,
  ),
  Post(
    text: "I keep checking my phone waiting for bad news. I can't relax.",
    emotion: emotions[4], // Anxious
    timeAgo: "5 hours ago",
    hearCount: 9,
    aloneCount: 11,
  ),
  Post(
    text: "Today is harder than usual. I miss who I used to be.",
    emotion: emotions[6], // Sad
    timeAgo: "6 hours ago",
    hearCount: 13,
    aloneCount: 16,
  ),
];