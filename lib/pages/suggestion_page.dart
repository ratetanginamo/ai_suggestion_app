import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import '../services/local_storage_service.dart';
import '../services/voice_service.dart';
import '../widgets/suggestion_card.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final OpenAIService _openAI = OpenAIService();
  final LocalStorageService _storage = LocalStorageService();
  final VoiceService _voice = VoiceService();
  final TextEditingController _controller = TextEditingController();
  String result = "";

  void getSuggestion() async {
    String suggestion = await _openAI.generateSuggestion(_controller.text);
    setState(() => result = suggestion);
    _storage.saveSuggestion(suggestion);
    _voice.speak(suggestion);
  }

  void useVoice() async {
    String? text = await _voice.listen();
    if (text != null && text.isNotEmpty) {
      _controller.text = text;
      getSuggestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> history = _storage.getSuggestions();
    return Scaffold(
      appBar: AppBar(title: const Text("AI Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: "Enter a topic", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: getSuggestion, child: const Text("Get")),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: useVoice, child: const Icon(Icons.mic)),
              ],
            ),
            const SizedBox(height: 20),
            if (result.isNotEmpty) SuggestionCard(text: result),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, i) => SuggestionCard(text: history[i]['text']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
