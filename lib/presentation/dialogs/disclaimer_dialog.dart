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
              'Cette application n\'est affiliée à aucune entité gouvernementale et ne représente pas un département gouvernemental officiel. Les informations contenues dans cette application sont fournies uniquement à titre informatif et ne doivent pas être considérées comme des conseils juridiques. Bien que nous nous efforcions de fournir des informations précises et à jour, nous ne garantissons pas leur exactitude, exhaustivité ou actualité. Pour des conseils juridiques spécifiques ou des informations officielles, veuillez consulter directement les sources gouvernementales appropriées ou un conseiller juridique qualifié.',
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
              error: (_, __) => const Center(child: Text('Erreur lors de la lecture des préférences.')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
