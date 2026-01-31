import 'package:cloud_firestore/cloud_firestore.dart';

class DropMaskService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost({
    required String title,
    required String content,
  }) async {
    await _db.collection('posts').add({
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
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