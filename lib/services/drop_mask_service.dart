import 'package:cloud_firestore/cloud_firestore.dart';

class DropMaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost({
    required String text,
    required String emotionLabel,
    required int severity,
    required String category,
    required bool isPositive,
    required int hearYouCount,
    required int notAloneCount,
  }) async {
    try {
      await _db.collection('posts').add({
        'Input': text,
        'Emotion': emotionLabel,
        'Severity': severity,
        'Category': category,
        'Is Positive': isPositive,
        'Created At': FieldValue.serverTimestamp(),
        'Hear you count' : hearYouCount,
        'Not alone count' : notAloneCount,
      });
      print("Post saved with full attributes!");
    } catch (e) {
      print("Error: $e");
    }
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