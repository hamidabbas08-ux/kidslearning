import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_logger.dart';

class SaveSystem extends ChangeNotifier {
  static const String _coinsKey = 'user_coins';
  static const String _starsKey = 'user_stars';
  static const String _xpKey = 'user_xp';
  static const String _playerLevelKey = 'player_level';
  static const String _soundKey = 'sound_enabled';
  static const String _musicKey = 'music_enabled';
  static const String _animationKey = 'animation_enabled';
  
  static const String _hasCompletedOnboardingKey = 'onboarding_complete';
  static const String _playerNameKey = 'player_name';
  static const String _playerAgeKey = 'player_age';
  static const String _currentAvatarKey = 'current_avatar';
  
  static const String _categoryProgressKey = 'category_progress_map';
  static const String _unlockedAchievementsKey = 'unlocked_achievements';
  static const String _lastActiveDateKey = 'last_active_date';
  static const String _loginStreakKey = 'login_streak_count';

  int _coins = 0;
  int _stars = 0;
  int _xp = 0;
  int _playerLevel = 1;
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _animationEnabled = true;
  
  bool _hasCompletedOnboarding = false;
  String _playerName = 'Guest Friend';
  int _playerAge = 5;
  String _currentAvatar = '🦁';
  
  Map<String, double> _categoryProgress = {};
  List<String> _unlockedAchievements = [];
  int _loginStreak = 1;

  int get coins => _coins;
  int get stars => _stars;
  int get xp => _xp;
  int get playerLevel => _playerLevel;
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get animationEnabled => _animationEnabled;
  
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  String get playerName => _playerName;
  int get playerAge => _playerAge;
  String get currentAvatar => _currentAvatar;
  
  Map<String, double> get categoryProgress => _categoryProgress;
  List<String> get unlockedAchievements => _unlockedAchievements;
  int get loginStreak => _loginStreak;

  SaveSystem() {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _coins = prefs.getInt(_coinsKey) ?? 0;
      _stars = prefs.getInt(_starsKey) ?? 0;
      _xp = prefs.getInt(_xpKey) ?? 0;
      _playerLevel = prefs.getInt(_playerLevelKey) ?? 1;
      _soundEnabled = prefs.getBool(_soundKey) ?? true;
      _musicEnabled = prefs.getBool(_musicKey) ?? true;
      _animationEnabled = prefs.getBool(_animationKey) ?? true;
      
      _hasCompletedOnboarding = prefs.getBool(_hasCompletedOnboardingKey) ?? false;
      _playerName = prefs.getString(_playerNameKey) ?? 'Guest Friend';
      _playerAge = prefs.getInt(_playerAgeKey) ?? 5;
      _currentAvatar = prefs.getString(_currentAvatarKey) ?? '🦁';
      _loginStreak = prefs.getInt(_loginStreakKey) ?? 1;

      String? progressJson = prefs.getString(_categoryProgressKey);
      if (progressJson != null) {
        Map<String, dynamic> decoded = jsonDecode(progressJson);
        _categoryProgress = decoded.map((key, value) => MapEntry(key, (value as num).toDouble()));
      }

      _unlockedAchievements = prefs.getStringList(_unlockedAchievementsKey) ?? [];
      _checkStreak(prefs);
      notifyListeners();
    } catch (e) {
      AppLogger.error("Failed to load local save data", e);
    }
  }

  Future<void> saveProfile({required String name, required int age, required String avatar}) async {
    _playerName = name;
    _playerAge = age;
    _currentAvatar = avatar;
    _hasCompletedOnboarding = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_playerNameKey, name);
    await prefs.setInt(_playerAgeKey, age);
    await prefs.setString(_currentAvatarKey, avatar);
    await prefs.setBool(_hasCompletedOnboardingKey, true);
    notifyListeners();
  }

  Future<void> updateCategoryProgress(String categoryId, double progressPercent) async {
    _categoryProgress[categoryId] = progressPercent;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_categoryProgressKey, jsonEncode(_categoryProgress));
    
    if (progressPercent >= 1.0) {
      await unlockAchievement('${categoryId}_master');
    }
    notifyListeners();
  }

  Future<void> unlockAchievement(String achievementId) async {
    if (!_unlockedAchievements.contains(achievementId)) {
      _unlockedAchievements.add(achievementId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_unlockedAchievementsKey, _unlockedAchievements);
      notifyListeners();
    }
  }

  void _checkStreak(SharedPreferences prefs) {
    String todayStr = DateTime.now().toIso8601String().split('T')[0];
    String? lastActive = prefs.getString(_lastActiveDateKey);

    if (lastActive != null) {
      DateTime today = DateTime.parse(todayStr);
      DateTime lastDate = DateTime.parse(lastActive);
      int difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        _loginStreak++;
        prefs.setInt(_loginStreakKey, _loginStreak);
      } else if (difference > 1) {
        _loginStreak = 1;
        prefs.setInt(_loginStreakKey, 1);
      }
    }
    prefs.setString(_lastActiveDateKey, todayStr);
  }

  Future<void> addRewards({required int coinsAmount, required int starsAmount, required int xpAmount}) async {
    _coins += coinsAmount;
    _stars += starsAmount;
    _xp += xpAmount;

    int nextLevelThreshold = _playerLevel * 100;
    if (_xp >= nextLevelThreshold) {
      _playerLevel++;
      _xp = _xp - nextLevelThreshold;
      await unlockAchievement('level_up_$_playerLevel');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinsKey, _coins);
    await prefs.setInt(_starsKey, _stars);
    await prefs.setInt(_xpKey, _xp);
    await prefs.setInt(_playerLevelKey, _playerLevel);
    notifyListeners();
  }

  Future<void> toggleAnimation(bool value) async {
    _animationEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_animationKey, value);
    notifyListeners();
  }

  Future<void> toggleSound(bool value) async {
    _soundEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, value);
    notifyListeners();
  }

  Future<void> toggleMusic(bool value) async {
    _musicEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicKey, value);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _coins = 0;
    _stars = 0;
    _xp = 0;
    _playerLevel = 1;
    _soundEnabled = true;
    _musicEnabled = true;
    _animationEnabled = true;
    _playerName = 'Guest Friend';
    _playerAge = 5;
    _currentAvatar = '🦁';
    _hasCompletedOnboarding = false;
    _categoryProgress.clear();
    _unlockedAchievements.clear();
    _loginStreak = 1;
    notifyListeners();
  }
}
