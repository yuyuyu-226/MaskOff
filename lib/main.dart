import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart'; // NEW IMPORT
import 'dart:math';

void main() {
  runApp(const MaskOffApp());
}

class MaskOffApp extends StatelessWidget {
  const MaskOffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaskOff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F2EE),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

// --- UPDATED MODEL ---
class Emotion {
  final String label;
  final Color color;
  final String lottieUrl; // NEW FIELD FOR ANIMATION
  
  Emotion(this.label, this.color, this.lottieUrl);
}

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

// --- UPDATED DATA WITH ANIMATION URLS ---
final List<Emotion> emotions = [
  Emotion("Numb", Colors.grey, "https://lottie.host/57ee1748-1da5-472e-84b2-03da57099719/9wG53Q2r9R.json"), // A flat line or static feel
  Emotion("Joyful", Colors.amber, "https://lottie.host/88636154-1845-4279-994c-83b54433c24d/R1u3Qj62Xk.json"), // Sun/Happy
  Emotion("Hopeful", const Color(0xFF7BA08E), "https://lottie.host/91a6d482-944c-4740-8809-90b533e46c76/Wc0jY4Z7pM.json"), // Growing plant
  Emotion("Calm", Colors.cyan.shade200, "https://lottie.host/0202220e-c284-4820-9189-66c547846513/p7jD1G3X2s.json"), // Water/Breathing
  Emotion("Anxious", const Color(0xFFE5916E), "https://lottie.host/14b30825-7033-4040-af29-234257121287/9F3z1v2Q0s.json"), // Shaking/Nervous
  Emotion("Overwhelmed", const Color(0xFF6A94CC), "https://lottie.host/a6101267-3c58-4503-be89-72f5c719e767/p3Z0x4Q4yR.json"), // Swirling mess
  Emotion("Sad", const Color(0xFF9186A1), "https://lottie.host/31802958-4796-4177-8356-9d32d4b06540/3c8L3x5z0s.json"), // Rain/Tears
  Emotion("Lonely", const Color(0xFF6B9080), "https://lottie.host/4e531773-6772-4c28-9710-18e384666014/9y1X2w3R4s.json"), // Empty/Ghost
];

List<Post> globalFeed = [
  Post(text: "I feel like I'm drowning in responsibilities. Every time I finish one thing, three more appear.", emotion: emotions[5], timeAgo: "12 min ago", hearCount: 8, aloneCount: 12),
  Post(text: "I keep checking my phone waiting for bad news. I can't relax.", emotion: emotions[4], timeAgo: "5 hours ago", hearCount: 9, aloneCount: 11),
  Post(text: "Today is harder than usual. I miss who I used to be.", emotion: emotions[6], timeAgo: "6 hours ago", hearCount: 13, aloneCount: 16),
];

// --- SCREENS ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.face_retouching_off, size: 60, color: Color(0xFF6D5D51)),
            ),
            const SizedBox(height: 40),
            Text("MaskOff", style: GoogleFonts.josefinSans(fontSize: 48, fontWeight: FontWeight.w300, color: const Color(0xFF4A4A4A))),
            const Text("A quiet space to be honest", style: TextStyle(color: Colors.grey, fontSize: 18)),
            const SizedBox(height: 60),
            _buildButton(context, "Drop the mask", const Color(0xFF6D5D51), Colors.white, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DropMaskScreen()));
            }),
            const SizedBox(height: 16),
            _buildButton(context, "How am I feeling?", Colors.white, const Color(0xFF6D5D51), () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EmotionSelectionScreen()));
            }),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text("Anonymous. Safe. Supportive.", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color bg, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: 280,
      height: 65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

class DropMaskScreen extends StatefulWidget {
  const DropMaskScreen({super.key});

  @override
  State<DropMaskScreen> createState() => _DropMaskScreenState();
}

class _DropMaskScreenState extends State<DropMaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.grey)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("What mask are you wearing right now?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300)),
            const Text("You don't have to explain. Just say it.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                decoration: const InputDecoration(hintText: "I'm pretending everything is fine...", border: InputBorder.none),
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE8E2D9), foregroundColor: Colors.black54, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final detectedEmotion = emotions[Random().nextInt(emotions.length)];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AIDetectionScreen(text: _controller.text, emotion: detectedEmotion)));
                    }
                  },
                  child: const Text("Drop the mask"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- UPDATED AI DETECTION SCREEN WITH ANIMATION ---
class AIDetectionScreen extends StatelessWidget {
  final String text;
  final Emotion emotion;
  const AIDetectionScreen({super.key, required this.text, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(label: const Text("AI-detected emotion"), avatar: const Icon(Icons.auto_awesome, size: 16)),
            const SizedBox(height: 20),
            
            // ANIMATED ICON
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.network(emotion.lottieUrl),
            ),

            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(fontSize: 32, color: Colors.black87, fontWeight: FontWeight.w300),
                children: [
                  const TextSpan(text: "It sounds like you're\nfeeling "),
                  TextSpan(text: emotion.label.toLowerCase(), style: TextStyle(color: emotion.color, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text("You deserve rest and care.", style: TextStyle(color: Colors.grey, fontSize: 18)),
            const SizedBox(height: 60),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6D5D51), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  final myPost = Post(text: text, emotion: emotion, timeAgo: "Just now", isPinned: true);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SupportFeedScreen(myPost: myPost)));
                },
                child: const Text("Continue", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportFeedScreen extends StatelessWidget {
  final Post? myPost;
  const SupportFeedScreen({super.key, this.myPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Support Feed"), backgroundColor: Colors.transparent, elevation: 0, centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Everyone here is anonymous. Show them they're not alone.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          if (myPost != null) ...[
            _PostCard(post: myPost!),
            const Divider(height: 40),
            const Text("Other stories", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
          ],
          ...globalFeed.map((p) => _PostCard(post: p)).toList(),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 60), backgroundColor: Colors.white, foregroundColor: Colors.black87, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text("Go back to Home"),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// --- UPDATED SELECTION SCREEN WITH ANIMATIONS ---
class EmotionSelectionScreen extends StatelessWidget {
  const EmotionSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("How are you feeling?", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
                const Text("Take a moment to identify your emotion", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Wrap(
                spacing: 25,
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: emotions.map((e) => GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmotionFilteredStories(emotion: e)));
                  },
                  child: Column(
                    children: [
                      // REPLACED STATIC CIRCLE AVATAR WITH LOTTIE
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Lottie.network(e.lottieUrl, fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(e.label, style: TextStyle(color: e.color, fontWeight: FontWeight.w500)),
                    ],
                  ),
                )).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EmotionFilteredStories extends StatelessWidget {
  final Emotion emotion;
  const EmotionFilteredStories({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    final filtered = globalFeed.where((p) => p.emotion.label == emotion.label).toList();

    return Scaffold(
      appBar: AppBar(title: Text("${emotion.label} Stories"), backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.black)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (filtered.isEmpty) 
            const Center(child: Padding(padding: EdgeInsets.only(top: 50), child: Text("No stories yet for this emotion.")))
          else 
            ...filtered.map((p) => _PostCard(post: p)).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text("Go back to Home"),
          )
        ],
      ),
    );
  }
}

class _PostCard extends StatefulWidget {
  final Post post;
  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
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
                if (widget.post.isPinned) const Icon(Icons.push_pin, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                // Using a small static icon for the feed to keep it clean, 
                // but you could swap this for Lottie too if you want!
                Icon(Icons.circle, size: 12, color: widget.post.emotion.color),
                const SizedBox(width: 8),
                Text(widget.post.emotion.label, style: TextStyle(color: widget.post.emotion.color.withOpacity(0.8), fontWeight: FontWeight.bold)),
                const Spacer(),
                Text("${widget.post.timeAgo} • 24h left", style: const TextStyle(color: Colors.black26, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Text(widget.post.text, style: const TextStyle(fontSize: 16, height: 1.4)),
            const SizedBox(height: 20),
            Row(
              children: [
                _actionButton(Icons.chat_bubble_outline, "I hear you", widget.post.hearCount, () {
                  setState(() => widget.post.hearCount++);
                }),
                const SizedBox(width: 10),
                _actionButton(Icons.favorite_border, "Not alone", widget.post.aloneCount, () {
                  setState(() => widget.post.aloneCount++);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, int count, VoidCallback onTap) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text("$label ($count)", style: const TextStyle(fontSize: 12)),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black54,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );
  }
}