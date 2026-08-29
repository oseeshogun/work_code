import 'package:flutter/material.dart';

/// Pulsing-dots + status text, so waiting for a (non-streamed) reply shows
/// real progress — which tool the AI is currently using — instead of a bare
/// spinner.
class AiTypingIndicator extends StatefulWidget {
  final String? statusMessage;

  const AiTypingIndicator({super.key, this.statusMessage});

  @override
  State<AiTypingIndicator> createState() => _AiTypingIndicatorState();
}

class _AiTypingIndicatorState extends State<AiTypingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 14,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (i) {
                    final t = (_controller.value - i * 0.2) % 1.0;
                    final bump = (1 - (2 * t - 1).abs()).clamp(0.0, 1.0);
                    return Opacity(
                      opacity: 0.35 + 0.65 * bump,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                widget.statusMessage ?? 'Réflexion en cours...',
                key: ValueKey(widget.statusMessage),
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
