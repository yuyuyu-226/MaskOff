import 'emotion.dart';

class Post {
  final String id;
  final String text;
  final Emotion emotion;
  final String timeAgo;
  int hearCount;
  int aloneCount;
  final bool isPinned;

  final category;


  Post({
    required this.id,
    required this.text,
    required this.emotion,
    required this.timeAgo,
    this.hearCount = 0,
    this.aloneCount = 0,
    this.isPinned = false,
    this.category = "",
  });
}
