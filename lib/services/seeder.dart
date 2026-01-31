import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mask_off/data/app_data.dart';

Future<void> seedFirestore() async {
  final postsRef = FirebaseFirestore.instance.collection('posts');

  final snapshot = await postsRef.get();
  if (snapshot.docs.isNotEmpty) return;

  await postsRef.add({
    "text": "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.",
    "emotion": 5, // Overwhelmed
    "timeAgo": "12 min ago",
    "hearCount": 8,
    "aloneCount": 12,
  });

  await postsRef.add({
    "text": "I keep checking my phone waiting for bad news. I can't relax.",
    "emotion": 4, // Anxious
    "timeAgo": "5 hours ago",
    "hearCount": 9,
    "aloneCount": 11,
  });

  await postsRef.add({
    "text": "Today is harder than usual. I miss who I used to be.",
    "emotion": 6, // Sad
    "timeAgo": "6 hours ago",
    "hearCount": 13,
    "aloneCount": 16,
  });
}