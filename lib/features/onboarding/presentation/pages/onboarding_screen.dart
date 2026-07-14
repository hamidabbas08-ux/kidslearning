import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/storage/save_system.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../home/presentation/widgets/bouncy_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  int _currentStep = 0;
  int _selectedAge = 5;
  String _selectedAvatar = '🦁';
  final List<String> _avatars = ['🦁', '🦊', '🐻', '🐰', '🐼', '🐱', '🐶', '🐯', '🐘'];

  void _nextStep() {
    if (_currentStep == 0 && _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tell me your name, little hero!")),
      );
      return;
    }
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.animateToPage(_currentStep, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      final saveSystem = Provider.of<SaveSystem>(context, listen: false);
      saveSystem.saveProfile(name: _nameController.text.trim(), age: _selectedAge, avatar: _selectedAvatar);
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.textDark, width: 4),
                    ),
                    child: Row(
                      children: [
                        const Text('🦁', style: TextStyle(fontSize: 48)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _currentStep == 0 ? "Let's learn together. What is your name?" : _currentStep == 1 ? "Great name! Now, how old are you?" : "Choose your avatar!",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [_buildNameStep(), _buildAgeStep(), _buildAvatarStep()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: BouncyButton(
                    color: Colors.yellowAccent,
                    onTap: _nextStep,
                    child: Center(
                      child: Text(
                        _currentStep == 2 ? "LET'S PLAY! 🚀" : "NEXT STEP ✨",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Your Sweet Name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeStep() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        int age = index + 3;
        bool isSelected = _selectedAge == age;
        return GestureDetector(
          onTap: () => setState(() => _selectedAge = age),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 55,
            height: 55,
            decoration: BoxDecoration(color: isSelected ? Colors.yellowAccent : Colors.white, shape: BoxShape.circle),
            child: Center(child: Text("$age", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          ),
        );
      }),
    );
  }

  Widget _buildAvatarStep() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemCount: _avatars.length,
      itemBuilder: (context, index) {
        String av = _avatars[index];
        bool isSelected = _selectedAvatar == av;
        return GestureDetector(
          onTap: () => setState(() => _selectedAvatar = av),
          child: Container(
            decoration: BoxDecoration(color: isSelected ? Colors.yellowAccent : Colors.white24, borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text(av, style: const TextStyle(fontSize: 44))),
          ),
        );
      },
    );
  }
}
