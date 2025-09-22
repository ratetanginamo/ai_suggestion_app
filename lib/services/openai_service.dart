import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String endpoint = "https://api.openai.com/v1/chat/completions";

  Future<String> generateSuggestion(String prompt) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful suggestion bot."},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 60
      }),
    );
    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'].trim();
  }
}
