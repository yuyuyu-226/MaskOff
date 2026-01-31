import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_off/models/post.dart';
import 'package:mask_off/models/emotion.dart';

class FirebasePostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch posts with pagination.
  /// If randomize is true, it fetches a larger pool and shuffles (simulated for demo purposes)
  Future<List<Post>> getPosts({int limit = 5, DocumentSnapshot? startAfter, bool randomize = false}) async {
    Query query = _db.collection('posts');

    if (randomize) {
      // For true randomness in Firestore, one would use a random field.
      // Here we'll just shuffle the results from a slightly larger pool for simplicity in this context.
      final snapshot = await query.limit(limit * 2).get();
      final docs = snapshot.docs.toList()..shuffle();
      return docs.take(limit).map((doc) => _mapDocToPost(doc)).toList();
    }

    query = query.orderBy('Created At', descending: true).limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) => _mapDocToPost(doc)).toList();
  }

  Post _mapDocToPost(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

      DateTime createdAt;
      var rawDate = data["Created At"];

      if (rawDate is Timestamp) {
        createdAt = rawDate.toDate();
      } else if (rawDate is String) {
        createdAt = DateTime.parse(rawDate); // Correctly handles ISO 8601
      } else {
        createdAt = DateTime.now(); // Fallback if data is missing
      }

    return Post(
      id: doc.id,
      text: data["Input"] ?? "",
      emotion: Emotion(
        data["Emotion"] ?? "Unknown",
        _categoryColor(data["Emotion"] ?? ""),
        data["Severity"] ?? 0,
        data["Category"] ?? "",
        data["Is Positive"] ?? false,
      ),
      timeAgo: createdAt,
      hearCount: data["Hear you count"] ?? 0,
      aloneCount: data["Not alone count"] ?? 0,
      category: data["Category"] ?? "",
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Numb':
        return const Color(0xFF9E9E9E); // Exact Grey
      case 'Joyful':
        return const Color(0xFFFFC107); // Exact Amber hex
      case 'Hopeful':
        return const Color(0xFF7BA08E); // Your Sage Green
      case 'Calm':
        return const Color(0xFF00BCD4); // Exact Cyan hex
      case 'Anxious':
        return const Color(0xFFE5916E); // Your Orange/Peach
      case 'Overwhelmed':
        return const Color(0xFF6A94CC); // Your Blue
      case 'Sad':
        return const Color(0xFF9186A1); // Your Purple/Grey
      case 'Lonely':
        return const Color(0xFF6B9080); // Your Teal
      default:
        return const Color(0xFFB6B1AA); // Your Fallback
    }
  }

  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Future<void> updateInteraction(String postId, String field, int value) async {
    try {
      await _db.collection('posts').doc(postId).update({
        field: FieldValue.increment(value),
      });
    } catch (e) {
      debugPrint('Error updating interaction: $e');
    }
  }

  Future<List<Post>> getPostsByEmotion(String emotionLabel) async {
    final querySnapshot = await _db.collection('posts')
        .where('Emotion', isEqualTo: emotionLabel) // Filter by the Firestore field
        .orderBy('Created At', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => _mapDocToPost(doc)).toList();
  }

  // Backwards compatibility for the existing FeedList if needed
  Future<List<Post>> getNewestPosts({int limit = 5}) async {
    return getPosts(limit: limit);
  }
}
