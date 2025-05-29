import 'package:codedutravail/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoScreen extends HookConsumerWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Code Source'),
              leading: const Icon(Icons.code),
              onTap: () async {
                final urlString = 'https://github.com/oseeshogun/work_code';
                if (await canLaunchUrlString(urlString)) {
                  await launchUrlString(urlString);
                }
              },
            ),
            ListTile(
              title: const Text('Développeur'),
              leading: const Icon(Icons.waving_hand),
              onTap: () async {
                final urlString = 'https://oseemasuaku.com';
                if (await canLaunchUrlString(urlString)) {
                  await launchUrlString(urlString);
                }
              },
            ),
            ListTile(
              title: const Text('À propos du Code du Travail'),
              leading: const Icon(Icons.corporate_fare),
              onTap: () => AboutRoute().push(context),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CLAUSE DE NON-RESPONSABILITÉ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text(
                    'Cette application fournit une version du Code du Travail basée sur des informations disponibles publiquement, notamment via le site LegalRDC. Elle n\'est affiliée à aucune entité gouvernementale et ne représente pas un service gouvernemental officiel. Les informations contenues dans cette application sont fournies uniquement à titre informatif et ne doivent pas être interprétées comme des conseils juridiques. Pour des informations officielles et à jour, nous vous encourageons à consulter directement les sources gouvernementales appropriées ou à utiliser le lien disponible sur LegalRDC.',
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async {
                      final uriString = 'https://legalrdc.com/2016/07/15/code-du-travail/';
                      if (await canLaunchUrlString(uriString)) {
                        await launchUrlString(uriString);
                      }
                    },
                    child: const Text('Lien de LegalRDC', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
