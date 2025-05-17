import 'package:codedutravail/presentation/home/widgets/dot_pulse.dart';
import 'package:flutter/material.dart';

class ThinkingIndicator extends StatelessWidget {
  const ThinkingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotPulse(delay: 0),
            const SizedBox(width: 4),
            DotPulse(delay: 300),
            const SizedBox(width: 4),
            DotPulse(delay: 600),
          ],
        ),
      ),
    );
  }
}
