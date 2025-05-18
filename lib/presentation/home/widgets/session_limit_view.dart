import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionLimitView extends ConsumerWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onWatchAd;

  const SessionLimitView({super.key, this.onRetry, this.onWatchAd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Limite de sessions atteinte',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Vous avez atteint votre limite quotidienne de 2 sessions. Revenez demain pour continuer à utiliser l\'IA.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        if (onWatchAd != null)
          ElevatedButton.icon(
            onPressed: onWatchAd,
            icon: const Icon(Icons.card_giftcard),
            label: Text('Regarder une publicité pour une session supplémentaire', textAlign: TextAlign.center),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Colors.amber.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        const SizedBox(height: 16),
        if (onRetry != null)
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          ),
      ],
    );
  }
}
