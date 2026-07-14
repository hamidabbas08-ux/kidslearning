import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/learning_models.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';
import 'dynamic_game_screen.dart';

class GameModeScreen extends StatelessWidget {
  final LearningCategory category;

  const GameModeScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFFF59D), Color(0xFFFFCC80)]),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        BouncyButton(
                          color: AppTheme.softPink,
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${category.name} Modes',
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _buildModeButton(context, '📚 LEARN MODE', Colors.lightBlueAccent, GameMode.learn),
                  const SizedBox(height: 16),
                  _buildModeButton(context, '💡 PRACTICE MODE', Colors.lightGreenAccent, GameMode.practice),
                  const SizedBox(height: 16),
                  _buildModeButton(context, '🏆 CHALLENGE MODE', Colors.orangeAccent, GameMode.challenge),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, String title, Color color, GameMode mode) {
    return SizedBox(
      width: 280,
      child: BouncyButton(
        color: color,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DynamicGameScreen(category: category, mode: mode)),
          );
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark),
          ),
        ),
      ),
    );
  }
}
