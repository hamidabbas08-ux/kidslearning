import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/audio/audio_manager.dart';
import '../../../../core/storage/save_system.dart';

class BouncyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color color;

  const BouncyButton({super.key, required this.child, required this.onTap, this.color = const Color(0xFFFFB74D)});

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        final saveSystem = Provider.of<SaveSystem>(context, listen: false);
        AudioManager().playSoundEffect('tap', saveSystem.soundEnabled);
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF37474F), width: 4),
            boxShadow: [
              BoxShadow(color: const Color(0xFF37474F).withOpacity(0.4), offset: const Offset(0, 6)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: widget.child,
        ),
      ),
    );
  }
}
