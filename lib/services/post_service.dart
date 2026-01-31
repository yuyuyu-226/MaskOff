import 'package:cloud_firestore/cloud_firestore.dart';

class DropMaskService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost({
    required String text,
    required String emotion,
  }) async {
    await _db.collection('posts').add({
      'text': text,
      'content': emotion, // <--- Galing AI
      'timeAgo': FieldValue.serverTimestamp(),
      "hearCount": 0,
      "aloneCount": 12
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