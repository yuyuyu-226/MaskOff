import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> analyzeEmotion(String userInput) async {
  // Use 10.0.2.2 if using an Android Emulator, otherwise use your PC IP
  final String url = 'http://172.27.4.119:8000/analyze'; 

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": userInput}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['emotion']; // Returns "Joyful", "Sad", etc.
    } else {
      return "Error: ${response.statusCode}";
    }
  } catch (e) {
    return "Connection Failed: $e";
  }
}