import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/audio/audio_manager.dart';
import '../../../../core/storage/save_system.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';
import 'package:provider/provider.dart';

class SpellingGameScreen extends StatefulWidget {
  const SpellingGameScreen({super.key});

  @override
  State<SpellingGameScreen> createState() => _SpellingGameScreenState();
}

class _SpellingGameScreenState extends State<SpellingGameScreen> {
  final String targetWord = "APPLE";
  List<String> scrambledLetters = ["P", "L", "A", "P", "E"];
  List<String> currentAttempt = [];
  bool isLevelCompleted = false;

  void _onLetterTap(String letter, int index) {
    final saveSystem = Provider.of<SaveSystem>(context, listen: false);
    AudioManager().speakLetter(letter, saveSystem.soundEnabled);

    setState(() {
      currentAttempt.add(letter);
      scrambledLetters.removeAt(index);
    });

    if (scrambledLetters.isEmpty) {
      _checkAnswer();
    }
  }

  void _checkAnswer() {
    final saveSystem = Provider.of<SaveSystem>(context, listen: false);
    String attemptWord = currentAttempt.join();

    if (attemptWord == targetWord) {
      setState(() {
        isLevelCompleted = true;
      });
      AudioManager().playSoundEffect('correct', saveSystem.soundEnabled);
      AudioManager().speakWord(targetWord, saveSystem.soundEnabled);
      saveSystem.addCoins(10);
      saveSystem.addStars(5);
      saveSystem.completeLevel();
    } else {
      print("Wrong Answer!");
      AudioManager().playSoundEffect('wrong', saveSystem.soundEnabled);
      _resetLevel();
    }
  }

  void _resetLevel() {
    setState(() {
      scrambledLetters = ["P", "L", "A", "P", "E"];
      currentAttempt.clear();
      isLevelCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final saveSystem = Provider.of<SaveSystem>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BouncyButton(
                    color: AppTheme.softPink,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
                  ),
                  Row(
                    children: [
                      _buildHeaderBadge(Icons.star, Colors.amber, '${saveSystem.stars}'),
                      const SizedBox(width: 8),
                      _buildHeaderBadge(Icons.monetization_on, Colors.orange, '${saveSystem.coins}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: AppTheme.textDark, width: 4),
                  ),
                  child: const Center(
                    child: Icon(Icons.apple, size: 100, color: Colors.redAccent),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(targetWord.length, (index) {
                    bool hasLetter = index < currentAttempt.length;
                    return Container(
                      width: 50,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: hasLetter ? Colors.yellowAccent : Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.textDark, width: 3),
                      ),
                      child: Center(
                        child: Text(
                          hasLetter ? currentAttempt[index] : "",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),
                if (!isLevelCompleted)
                  Wrap(
                    spacing: 12,
                    children: List.generate(scrambledLetters.length, (index) {
                      final letter = scrambledLetters[index];
                      return BouncyButton(
                        color: Colors.lightBlueAccent,
                        onTap: () => _onLetterTap(letter, index),
                        child: Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                      );
                    }),
                  ),
                if (isLevelCompleted) ...[
                  const Text(
                    'Perfect!',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BouncyButton(
                    color: Colors.greenAccent,
                    onTap: _resetLevel,
                    child: const Text(
                      'NEXT WORD',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(IconData icon, Color color, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.textDark, width: 3),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
