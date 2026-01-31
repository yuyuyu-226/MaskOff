import 'emotion.dart';

class Post {
  final String text;
  final Emotion emotion;
  final String timeAgo;
  int hearCount;
  int aloneCount;
  final bool isPinned;

  Post({
    required this.text,
    required this.emotion,
    required this.timeAgo,
    this.hearCount = 0,
    this.aloneCount = 0,
    this.isPinned = false,
  });
}
