import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mask_off/models/post.dart';

class FirebasePostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch all posts matching a specific emotion/category
  Future<List<Post>> getNewestPosts({int limit = 5}) async {
    final querySnapshot = await _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

     return querySnapshot.docs
        .map((doc) => Post(
          text: doc["Input"],
          emotion: doc["Emotion"],
          timeAgo: doc["Created At"],
          hearCount: doc["Hear you count"],
          aloneCount: doc["Not Alone count"],
        ))
        .toList();
  }

  /// Optional: realtime stream
  Stream<List<Post>> streamPostsByCategory(String category) {
    return _db
        .collection('posts')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post(
            text: doc["Input"],
            emotion: doc["Emotion"],
            timeAgo: doc["Created At"],
            hearCount: doc["Hear you count"],
            aloneCount: doc["Not Alone count"],
          )).toList());
  }
}
