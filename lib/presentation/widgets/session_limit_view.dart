import 'package:codedutravail/core/services/rewarded_ad_manager.dart';
import 'package:codedutravail/domain/providers/chat/session_limit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionLimitView extends HookConsumerWidget {
  final VoidCallback? onRetry;

  const SessionLimitView({super.key, this.onRetry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final adManager = useMemoized(() => RewardedAdManager()..loadAd());
    useEffect(() => adManager.dispose, const []);
    final isWatchingAd = useState(false);

    void watchAd() {
      isWatchingAd.value = true;
      adManager.showAd(
        onRewardEarned: () async {
          await ref.read(sessionLimitProvider.notifier).grantBonusSessions();
          isWatchingAd.value = false;
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('+$bonusSessionsPerAd sessions débloquées pour ${bonusSessionsDuration.inHours}h !')),
            );
          }
        },
        onAdUnavailable: () {
          isWatchingAd.value = false;
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Publicité indisponible pour l'instant. Réessayez dans un instant.")),
            );
          }
        },
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_bottom_rounded, size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'Limite de sessions atteinte',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Vous avez atteint votre limite quotidienne de $maxSessionsPerDay sessions. Revenez demain, ou regardez '
              'une publicité pour continuer maintenant.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: isWatchingAd.value ? null : watchAd,
              icon:
                  isWatchingAd.value
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                      : const Icon(Icons.play_circle_outline),
              label: Text(
                isWatchingAd.value ? 'Chargement...' : 'Regarder une pub : +$bonusSessionsPerAd sessions',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Valable ${bonusSessionsDuration.inHours} heures',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Réessayer')),
            ],
          ],
        ),
      ),
    );
  }
}
