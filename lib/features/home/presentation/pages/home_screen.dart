import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:kids_learning/core/theme/app_theme.dart';
import 'package:kids_learning/core/audio/audio_manager.dart';
import 'package:kids_learning/core/storage/save_system.dart';
import 'package:kids_learning/core/routes/app_routes.dart';
import 'package:kids_learning/features/home/presentation/widgets/bouncy_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final saveSystem = Provider.of<SaveSystem>(context, listen: false);
      AudioManager().playBackgroundMusic(saveSystem.musicEnabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final saveSystem = Provider.of<SaveSystem>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF80DEEA), Color(0xFF4DD0E1)]),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: -50,
            right: -50,
            child: Opacity(
              opacity: 0.6,
              child: CustomPaint(size: Size(size.width + 100, 150), painter: RainbowPainter()),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.22,
            child: Container(
              color: AppTheme.grassGreen,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: const Icon(Icons.local_florist, color: Colors.pinkAccent, size: 32)
                        .animate(onPlay: (controller) => controller.repeat())
                        .shake(hz: 1, duration: 3.seconds),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Text(saveSystem.currentAvatar, style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(saveSystem.playerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Text("Level ${saveSystem.playerLevel}", style: const TextStyle(fontSize: 11, color: AppTheme.grassGreen, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      BouncyButton(
                        color: Colors.amber,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.achievements),
                        child: const Row(
                          children: [
                            Icon(Icons.emoji_events, color: AppTheme.textDark, size: 24),
                            SizedBox(width: 4),
                            Text("MEDALS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'KIDS LEARNING',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 42,
                        shadows: [const Shadow(color: Color(0xFF37474F), offset: Offset(3, 3))],
                      ),
                    ),
                    Text(
                      'ADVENTURE',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.yellowAccent,
                        fontSize: 32,
                        shadows: [const Shadow(color: Color(0xFF37474F), offset: Offset(3, 3))],
                      ),
                    ),
                  ],
                ).animate().scale(duration: 1.seconds, curve: Curves.elasticOut), // باؤنس ایرر کو فکس کیا گیا
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    children: [
                      BouncyButton(
                        color: Colors.yellowAccent,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.categorySelection),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow_rounded, size: 48, color: AppTheme.textDark),
                            SizedBox(width: 8),
                            Text('PLAY NOW', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                          ],
                        ),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                       .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.05, 1.05), duration: 1.5.seconds),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BouncyButton(
                            color: AppTheme.softPink,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.parentDashboard),
                            child: const Text('PARENTS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(Icons.settings, color: AppTheme.textDark, size: 38),
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
                          ),
                        ],
                      ),
                    ],
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

class RainbowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 1.5);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 10;
    final colors = [Colors.redAccent, Colors.orangeAccent, Colors.yellowAccent, Colors.greenAccent, Colors.blueAccent, Colors.indigoAccent];
    double radius = size.height * 1.2;
    for (var color in colors) {
      paint.color = color;
      canvas.drawCircle(center, radius, paint);
      radius -= 10;
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
