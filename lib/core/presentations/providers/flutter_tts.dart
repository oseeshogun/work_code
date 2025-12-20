import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_tts.g.dart';

@Riverpod(keepAlive: true)
Future<FlutterTts> tts(Ref ref) async {
  final flutterTts = FlutterTts();

  await flutterTts.setLanguage('fr-FR');
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setVolume(1.0);
  await flutterTts.setPitch(1.0);
  
  ref.onDispose(() {
    flutterTts.stop();
  });

  return flutterTts;
}
