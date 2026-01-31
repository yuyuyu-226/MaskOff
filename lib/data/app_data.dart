import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../models/post.dart';

final List<Emotion> emotions = [
  Emotion(
    "Numb",
    Colors.grey,
    "https://lottie.host/57ee1748-1da5-472e-84b2-03da57099719/9wG53Q2r9R.json",
  ),
  Emotion(
    "Joyful",
    Colors.amber,
    "https://lottie.host/88636154-1845-4279-994c-83b54433c24d/R1u3Qj62Xk.json",
  ),
  Emotion(
    "Hopeful",
    const Color(0xFF7BA08E),
    "https://lottie.host/91a6d482-944c-4740-8809-90b533e46c76/Wc0jY4Z7pM.json",
  ),
  Emotion(
    "Calm",
    Colors.cyan,
    "https://lottie.host/0202220e-c284-4820-9189-66c547846513/p7jD1G3X2s.json",
  ),
  Emotion(
    "Anxious",
    const Color(0xFFE5916E),
    "https://lottie.host/14b30825-7033-4040-af29-234257121287/9F3z1v2Q0s.json",
  ),
  Emotion(
    "Overwhelmed",
    const Color(0xFF6A94CC),
    "https://lottie.host/a6101267-3c58-4503-be89-72f5c719e767/p3Z0x4Q4yR.json",
  ),
  Emotion(
    "Sad",
    const Color(0xFF9186A1),
    "https://lottie.host/31802958-4796-4177-8356-9d32d4b06540/3c8L3x5z0s.json",
  ),
  Emotion(
    "Lonely",
    const Color(0xFF6B9080),
    "https://lottie.host/4e531773-6772-4c28-9710-18e384666014/9y1X2w3R4s.json",
  ),
];

List<Post> globalFeed = [
  Post(
    text:
        "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.",
    emotion: emotions[5],
    timeAgo: "12 min ago",
    hearCount: 8,
    aloneCount: 12,
  ),
  Post(
    text: "I keep checking my phone waiting for bad news. I can't relax.",
    emotion: emotions[4],
    timeAgo: "5 hours ago",
    hearCount: 9,
    aloneCount: 11,
  ),
  Post(
    text: "Today is harder than usual. I miss who I used to be.",
    emotion: emotions[6],
    timeAgo: "6 hours ago",
    hearCount: 13,
    aloneCount: 16,
  ),
];
