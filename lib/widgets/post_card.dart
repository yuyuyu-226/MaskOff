import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.post.isPinned)
                  const Icon(Icons.push_pin, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Icon(Icons.circle, size: 12, color: widget.post.emotion.color),
                const SizedBox(width: 8),
                Text(
                  widget.post.emotion.label,
                  style: TextStyle(
                    color: widget.post.emotion.color.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "${widget.post.timeAgo} • 24h left",
                  style: const TextStyle(color: Colors.black26, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(widget.post.text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                _action(
                  Icons.chat_bubble_outline,
                  "I hear you",
                  widget.post.hearCount,
                  () {
                    setState(() => widget.post.hearCount++);
                  },
                ),
                const SizedBox(width: 10),
                _action(
                  Icons.favorite_border,
                  "Not alone",
                  widget.post.aloneCount,
                  () {
                    setState(() => widget.post.aloneCount++);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label, int count, VoidCallback onTap) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text("$label ($count)", style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
