import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DotPulse extends HookWidget {
  final int delay;

  const DotPulse({super.key, required this.delay});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 900));
    final animation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: delay), () {
          if (context.mounted) {
            controller.repeat(reverse: true);
          }
        });
      });
      return null;
    }, []);

    return Container(
      width: 8 + (4 * animation),
      height: 8 + (4 * animation),
      decoration: BoxDecoration(color: Colors.grey.shade500, shape: BoxShape.circle),
    );
  }
}
