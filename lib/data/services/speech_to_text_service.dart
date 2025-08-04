import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool isListening = false;
  final Function(SpeechRecognitionResult result) onListen;

  SpeechToTextService({required this.onListen}) {
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners();
  }

  Future<void> stopListening() async {
    isListening = false;
    await _speechToText.stop();
    notifyListeners();
  }

  void startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: onListen);
      isListening = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }
}
