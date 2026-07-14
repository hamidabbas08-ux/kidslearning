import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/game_data_registry.dart';
import '../../../../core/models/learning_models.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';
import 'game_mode_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = GameDataRegistry.getCategories();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF80DEEA), Color(0xFFE1BEE7)]),
            ),
          ),
          SafeArea(
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
                      const Text(
                        'Learning Academy',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, shadows: [
                          Shadow(color: AppTheme.textDark, offset: Offset(2, 2)),
                        ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return BouncyButton(
                        color: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GameModeScreen(category: cat)),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cat.icon, style: const TextStyle(fontSize: 40)),
                            const SizedBox(height: 8),
                            Text(
                              cat.name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
