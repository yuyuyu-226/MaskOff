import 'package:cloud_firestore/cloud_firestore.dart';

class DropMaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Change return type from Future<void> to Future<String?>
  Future<String?> createPost({
    required String text,
    required String emotionLabel,
    required int severity,
    required String category,
    required bool isPositive,
    required int hearYouCount,
    required int notAloneCount,
  }) async {
    try {
      // Capture the DocumentReference returned by .add()
      DocumentReference docRef = await _db.collection('posts').add({
        'Input': text,
        'Emotion': emotionLabel,
        'Severity': severity,
        'Category': category,
        'Is Positive': isPositive,
        'Created At': FieldValue.serverTimestamp(),
        'Hear you count' : hearYouCount,
        'Not alone count' : notAloneCount,
      });

      print("Post saved with ID: ${docRef.id}");
      return docRef.id; // Return the ID so the UI can use it
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}