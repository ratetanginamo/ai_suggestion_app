import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  Future<String?> listen() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen();
      await Future.delayed(const Duration(seconds: 5));
      await _speech.stop();
      return _speech.lastRecognizedWords;
    }
    return null;
  }

  Future speak(String text) async {
    await _tts.speak(text);
  }
}
