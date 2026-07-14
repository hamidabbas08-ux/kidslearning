import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/audio/audio_manager.dart';
import '../../../../core/storage/save_system.dart';
import '../../../../core/models/learning_models.dart';
import '../../../../core/services/ads_mascot_service.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';

class DynamicGameScreen extends StatefulWidget {
  final LearningCategory category;
  final GameMode mode;

  const DynamicGameScreen({super.key, required this.category, required this.mode});

  @override
  State<DynamicGameScreen> createState() => _DynamicGameScreenState();
}

class _DynamicGameScreenState extends State<DynamicGameScreen> {
  int currentItemIndex = 0;
  List<String> scrambledLetters = [];
  List<String> currentAttempt = [];
  bool isLevelCompleted = false;
  int mistakesCount = 0;
  int starsEarned = 3;
  String mascotMessage = "Can you make the word?";

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() {
    if (widget.category.items.isEmpty) return;
    final item = widget.category.items[currentItemIndex];
    
    setState(() {
      currentAttempt.clear();
      isLevelCompleted = false;
      mistakesCount = 0;
      starsEarned = 3;
      mascotMessage = "Let's build the word!";

      if (widget.mode == GameMode.learn) {
        currentAttempt = item.word.split('');
        isLevelCompleted = true;
        scrambledLetters.clear();
        _triggerRewards();
      } else {
        scrambledLetters = item.word.split('')..shuffle();
      }
    });
  }

  void _onLetterTap(String letter, int index) {
    final saveSystem = Provider.of<SaveSystem>(context, listen: false);
    AudioManager().speakLetter(letter, saveSystem.soundEnabled);

    setState(() {
      currentAttempt.add(letter);
      scrambledLetters.removeAt(index);
    });

    if (currentAttempt.length == widget.category.items[currentItemIndex].word.length) {
      _checkAnswer();
    }
  }

  void _checkAnswer() {
    final item = widget.category.items[currentItemIndex];
    final saveSystem = Provider.of<SaveSystem>(context, listen: false);
    String attemptWord = currentAttempt.join();

    if (attemptWord == item.word) {
      setState(() {
        isLevelCompleted = true;
        starsEarned = mistakesCount == 0 ? 3 : mistakesCount == 1 ? 2 : 1;
        mascotMessage = AdsMascotService().getRandomPraise();
      });
      _triggerRewards();
    } else {
      setState(() {
        mistakesCount++;
        mascotMessage = "Great Try! Let's try once more!";
      });
      AudioManager().playSoundEffect('wrong', saveSystem.soundEnabled);
      _resetAttempt();
    }
  }

  void _triggerRewards() {
    final item = widget.category.items[currentItemIndex];
    final saveSystem = Provider.of<SaveSystem>(context, listen: false);
    AudioManager().playSoundEffect('correct', saveSystem.soundEnabled);
    AudioManager().speakWord(item.word, saveSystem.soundEnabled);

    saveSystem.addRewards(coinsAmount: 10 * starsEarned, starsAmount: starsEarned, xpAmount: 20);
    saveSystem.updateCategoryProgress(widget.category.id, (currentItemIndex + 1) / widget.category.items.length);
  }

  void _resetAttempt() {
    final item = widget.category.items[currentItemIndex];
    setState(() {
      currentAttempt.clear();
      scrambledLetters = item.word.split('')..shuffle();
    });
  }

  void _nextLevel() {
    if (currentItemIndex < widget.category.items.length - 1) {
      setState(() => currentItemIndex++);
      _loadItem();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category.items.isEmpty) {
      return const Scaffold(body: Center(child: Text("No items available")));
    }

    final item = widget.category.items[currentItemIndex];
    final saveSystem = Provider.of<SaveSystem>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)]),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BouncyButton(
                        color: AppTheme.softPink,
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
                      ),
                      Row(
                        children: [
                          _buildBadge(Icons.star, Colors.amber, '${saveSystem.stars}'),
                          const SizedBox(width: 8),
                          _buildBadge(Icons.monetization_on, Colors.orange, '${saveSystem.coins}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("🦁 ", style: TextStyle(fontSize: 24)),
                        Flexible(
                          child: Text(
                            mascotMessage,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
                          child: Center(child: Text(widget.category.icon, style: const TextStyle(fontSize: 64))),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(item.word.length, (index) {
                            bool hasLetter = index < currentAttempt.length;
                            return Container(
                              width: 42,
                              height: 52,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: hasLetter ? Colors.yellowAccent : Colors.white24,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.textDark, width: 3),
                              ),
                              child: Center(
                                child: Text(
                                  hasLetter ? currentAttempt[index] : "",
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 32),
                        if (!isLevelCompleted)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(scrambledLetters.length, (index) {
                              final letter = scrambledLetters[index];
                              return BouncyButton(
                                color: Colors.lightBlueAccent,
                                onTap: () => _onLetterTap(letter, index),
                                child: Text(letter, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                              );
                            }),
                          ),
                        if (isLevelCompleted) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) => Icon(index < starsEarned ? Icons.star : Icons.star_border, color: Colors.amber, size: 40)),
                          ),
                          const SizedBox(height: 8),
                          Text(item.sentence, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 16),
                          BouncyButton(
                            color: Colors.greenAccent,
                            onTap: _nextLevel,
                            child: const Text('CONTINUE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                AdsMascotService().showBottomBannerAd(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, Color color, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
