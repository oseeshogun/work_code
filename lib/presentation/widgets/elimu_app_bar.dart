import 'package:flutter/material.dart';

/// Custom app bar for the Elimu (AI assistant) chat screen.
class ElimuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ElimuAppBar({super.key, this.onReset});

  /// Shown as a "new conversation" action when non-null.
  final VoidCallback? onReset;

  static const double _barHeight = 68;

  @override
  Size get preferredSize => const Size.fromHeight(_barHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.06))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _barHeight,
          child: Row(
            children: [
              const SizedBox(width: 4),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back),
                color: Colors.black87,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
              _Avatar(scheme: scheme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elimu',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Assistant IA · Code du travail',
                          style: theme.textTheme.labelSmall?.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onReset != null)
                IconButton(
                  onPressed: onReset,
                  icon: const Icon(Icons.add_comment_outlined),
                  color: scheme.primary,
                  tooltip: 'Nouvelle conversation',
                ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, Color.lerp(scheme.primary, scheme.tertiary, 0.6) ?? scheme.primary],
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.auto_awesome, size: 20, color: Colors.white),
    );
  }
}
