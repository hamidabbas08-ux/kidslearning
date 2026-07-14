import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/storage/save_system.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saveSystem = Provider.of<SaveSystem>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFB2EBF2), Color(0xFFE1BEE7)]),
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
                        "Game Settings",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildToggle(title: "Music", value: saveSystem.musicEnabled, onChanged: (val) => saveSystem.toggleMusic(val)),
                  _buildToggle(title: "Sound Effects", value: saveSystem.soundEnabled, onChanged: (val) => saveSystem.toggleSound(val)),
                  const Spacer(),
                  BouncyButton(
                    color: AppTheme.softPink,
                    onTap: () => saveSystem.resetProgress(),
                    child: const Center(child: Text("RESET PROGRESS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
