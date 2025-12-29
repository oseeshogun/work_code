import 'package:codedutravail/core/presentations/providers/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showDisclaimerDialog(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (BuildContext context) => _DisclaimerDialog(),
  );
}

class _DisclaimerDialog extends HookConsumerWidget {
  const _DisclaimerDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(prefsProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CLAUSE DE NON-RESPONSABILITÉ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'Cette application n\'est pas une application officielle du gouvernement. Elle ne représente aucun gouvernement, ministère ou institution publique et n’est affiliée à aucune entité gouvernementale.\n\n'
              'Les informations fournies dans cette application sont proposées à titre informatif et éducatif uniquement. Elles ne constituent pas des conseils juridiques. Bien que nous nous efforcions de fournir un contenu fidèle au texte disponible, aucune garantie n’est donnée quant à l’exactitude, l’exhaustivité ou l’actualité des informations.\n\n'
              'Pour toute interprétation officielle ou pour des conseils juridiques spécifiques, il est recommandé de consulter les autorités compétentes ou un professionnel du droit qualifié.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            prefsAsync.when(
              data:
                  (prefs) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        prefs.setBool('read_disclaimer', true);
                        Navigator.of(context).pop();
                      },
                      child: const Text('J\'ai compris'),
                    ),
                  ),
              error: (_, _) => const Center(child: Text('Erreur lors de la lecture des préférences.')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
