import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<Color> _rainbowColors = [
  Color(0xFFFF3B30),
  Color(0xFFFF9500),
  Color(0xFFFFCC00),
  Color(0xFF34C759),
  Color(0xFF00C7BE),
  Color(0xFF32ADE6),
  Color(0xFF5856D6),
  Color(0xFFAF52DE),
  Color(0xFFFF3B30),
];

/// Wraps [child] in a rainbow gradient border. The gradient spins
/// continuously while [animate] is true (used to signal the AI is working)
/// and freezes in place otherwise — the border stays rainbow either way.
class RainbowBorder extends StatefulWidget {
  final Widget child;
  final bool animate;
  final double radius;
  final double borderWidth;
  final Color backgroundColor;

  const RainbowBorder({
    super.key,
    required this.child,
    required this.animate,
    required this.backgroundColor,
    this.radius = 24,
    this.borderWidth = 2.5,
  });

  @override
  State<RainbowBorder> createState() => _RainbowBorderState();
}

class _RainbowBorderState extends State<RainbowBorder> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    if (widget.animate) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant RainbowBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final innerRadius = math.max(0.0, widget.radius - widget.borderWidth);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.all(widget.borderWidth),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: SweepGradient(colors: _rainbowColors, transform: GradientRotation(_controller.value * 2 * math.pi)),
          ),
          child: Container(
            decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(innerRadius)),
            child: widget.child,
          ),
        );
      },
    );
  }
}
