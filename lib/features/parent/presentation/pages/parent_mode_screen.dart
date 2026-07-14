import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/storage/save_system.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';

class ParentModeScreen extends StatefulWidget {
  const ParentModeScreen({super.key});

  @override
  State<ParentModeScreen> createState() => _ParentModeScreenState();
}

class _ParentModeScreenState extends State<ParentModeScreen> {
  bool isLocked = true;
  late int num1;
  late int num2;
  late int correctResult;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    num1 = random.nextInt(9) + 2;
    num2 = random.nextInt(9) + 2;
    correctResult = num1 + num2;
  }

  void _verify() {
    if (int.tryParse(_controller.text) == correctResult) {
      setState(() => isLocked = false);
    } else {
      _controller.clear();
      _generateQuestion();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Only parents can enter!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final saveSystem = Provider.of<SaveSystem>(context);

    if (isLocked) {
      return Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("PARENT GATE", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text("Solve: $num1 + $num2 = ?"),
                const SizedBox(height: 12),
                TextField(controller: _controller, keyboardType: TextInputType.number, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                BouncyButton(onTap: _verify, child: const Text("Enter")),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  BouncyButton(
                    color: AppTheme.softPink,
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 16),
                  const Text("Parent Dashboard", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    _buildStatTile("Total Coins Collected", "${saveSystem.coins}"),
                    _buildStatTile("Total Stars Earned", "${saveSystem.stars}"),
                    _buildStatTile("Player Level Status", "Level ${saveSystem.playerLevel}"),
                    _buildStatTile("Current Streak Active", "${saveSystem.loginStreak} Days"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
