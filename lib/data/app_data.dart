import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../models/post.dart';

final List<Emotion> emotions = [
  Emotion("Numb",     Colors.grey,                2, "Mild / Neutral",  false), // 0
  Emotion("Joyful",   Colors.amber,               1, "Positive",        true), // 1
  Emotion("Hopeful",  const Color(0xFF7BA08E),    1, "Positive",        true), // 2
  Emotion("Calm",     Colors.cyan,                2, "Mild / Neutral",  false), // 3
  Emotion("Anxious",  const Color(0xFFE5916E),    3, "Stress Load",     false), //4
  Emotion("Overwhelmed", const Color(0xFF6A94CC), 4, "Distress Load",   false), // 5
  Emotion("Sad",      const Color(0xFF9186A1),    4, "Distress Load",   false), //6
  Emotion("Lonely",   const Color(0xFF6B9080),    3, "Stress Load",     false), //7
  Emotion("Error", Colors.grey, 3, "???", false), // error state //8
];

List<Post> globalFeed = [
  Post(
    id: "mock-1", // Add a unique ID string
    text: "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.",
    emotion: emotions[5], // Overwhelmed
    timeAgo: "12 min ago",
    hearCount: 8,
    aloneCount: 12,
  ),
  Post(
    id: "mock-2", // Add a unique ID string
    text: "I keep checking my phone waiting for bad news. I can't relax.",
    emotion: emotions[4], // Anxious
    timeAgo: "5 hours ago",
    hearCount: 9,
    aloneCount: 11,
  ),
  Post(
    id: "mock-3", // Add a unique ID string
    text: "Today is harder than usual. I miss who I used to be.",
    emotion: emotions[6], // Sad
    timeAgo: "6 hours ago",
    hearCount: 13,
    aloneCount: 16,
  ),
];