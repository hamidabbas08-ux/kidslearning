import 'package:flutter/material.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _isMusicPlaying = false;

  void playBackgroundMusic(bool enabled) {
    if (!enabled) {
      stopBackgroundMusic();
      return;
    }
    if (_isMusicPlaying) return;
    debugPrint('BGM Running smoothly...');
    _isMusicPlaying = true;
  }

  void stopBackgroundMusic() {
    debugPrint('BGM Stopped.');
    _isMusicPlaying = false;
  }

  void playSoundEffect(String soundType, bool enabled) {
    if (!enabled) return;
    debugPrint('Sound Effect triggered: $soundType');
  }

  void speakLetter(String letter, bool enabled) {
    if (!enabled) return;
    debugPrint('Speaking letter: $letter');
  }

  void speakWord(String word, bool enabled) {
    if (!enabled) return;
    debugPrint('Speaking word: $word. Sentence: This is an $word.');
  }
}
