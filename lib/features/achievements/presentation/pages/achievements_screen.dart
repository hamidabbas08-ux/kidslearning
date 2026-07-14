import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/storage/save_system.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saveSystem = Provider.of<SaveSystem>(context);

    final List<Map<String, String>> achievementsData = [
      {'id': 'level_up_2', 'title': 'Level 2 Achiever', 'desc': 'Unlock Level 2!', 'icon': '🎖️'},
      {'id': 'level_up_5', 'title': 'Super Kid', 'desc': 'Unlock Level 5!', 'icon': '🏆'},
      {'id': 'alphabet_master', 'title': 'Alphabet Master', 'desc': 'Master all alphabets', 'icon': '🔤'},
      {'id': 'fruits_master', 'title': 'Fruit Master', 'desc': 'Master all fruits names', 'icon': '🍎'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFFF176), Color(0xFFFFB74D)]),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      BouncyButton(
                        color: AppTheme.softPink,
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "My Badges & Medals",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("🔥 Active streak:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("${saveSystem.loginStreak} Days!", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.grassGreen)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: achievementsData.length,
                      itemBuilder: (context, index) {
                        final item = achievementsData[index];
                        bool isUnlocked = saveSystem.unlockedAchievements.contains(item['id']);
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isUnlocked ? Colors.white : Colors.white24,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Text(isUnlocked ? item['icon']! : "🔒", style: const TextStyle(fontSize: 40)),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text(item['desc']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                                ],
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
          ),
        ],
      ),
    );
  }
}
