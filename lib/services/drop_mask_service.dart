import 'package:cloud_firestore/cloud_firestore.dart';

class DropMaskService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost({
    required String text,
    required String emotion,
    required int severity,
    required bool isPositive,
    required int hearCount,
    required int aloneCount,
    required String emoCategory

  }) async {
    await _db.collection('posts').add({
      'Input': text,
      'Emotion': emotion,
      'Created At': DateTime.now(),
      'Expires At' : DateTime.now().add(Duration(days: 7)),
      'Severity' : severity,
      'Positive Emotion' : isPositive,
      'I Hear you' : hearCount,
      'You\'re not Alone' : aloneCount,
      'Emotional Category' : emoCategory
    });
  }
}

/*

  await postsRef.add({
    "text": "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.",
    "emotion": 5, // Overwhelmed
    "timeAgo": "12 min ago",
    "hearCount": 8,
    "aloneCount": 12,
  });

*/