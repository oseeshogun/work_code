import 'package:codedutravail/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

class InfoScreen extends HookConsumerWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const packageName = 'com.oseemasuaku.codedutravail';
    final androidUrl = 'https://play.google.com/store/apps/details?id=$packageName';
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
              title: const Text('Partager l\'application'),
              leading: Image.asset('assets/images/google-play.png', width: 36, height: 36),
              trailing: const Icon(Icons.share),
              onTap: () {
                final box = context.findRenderObject() as RenderBox?;
                SharePlus.instance.share(
                  ShareParams(
                    text: 'Découvrez l\'application : $androidUrl',
                    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                  ),
                );
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
                  const Text('Source d’information :', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    'Cette application met à disposition une version numérique du Code du travail de la République Démocratique du Congo issue de sources accessibles au public en ligne. À ce jour, aucune plateforme gouvernementale officielle ne propose une version numérique complète et librement accessible du Code du travail.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'La République Démocratique du Congo demeurant un pays encore en développement et peu digitalisé, les textes juridiques officiels, y compris le Code du travail, sont principalement disponibles sous forme papier, accessibles physiquement auprès des institutions et services concernés.',
                  ),
                  const SizedBox(height: 8),
                  const Text('Dans ce contexte, le texte du Code du travail est consulté à partir du site Leganet :'),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final uriString =
                          'https://www.leganet.cd/Legislation/DroitSocial/Code%20du%20travail.%20loi.2002.htm';
                      if (await canLaunchUrlString(uriString)) {
                        await launchUrlString(uriString);
                      }
                    },
                    child: const Text(
                      'Lien vers Leganet',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Leganet est une plateforme associative et non gouvernementale, développée dans le cadre d’un projet porté par l’association Partenariat pour le Développement Social (PPDS). Ce projet vise à mettre gratuitement à la disposition du public des informations juridiques, notamment par la création d’un site dédié, le soutien à la magistrature et l’accompagnement des avocats.',
                  ),
                  const SizedBox(height: 20),
                  const Text('CLAUSE DE NON-RESPONSABILITÉ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    'Cette application n’est PAS une application officielle du gouvernement. Elle ne représente aucun gouvernement, ministère ou institution publique et n’est affiliée à aucune entité gouvernementale.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Les informations fournies dans cette application sont proposées à titre informatif et éducatif uniquement. Elles ne constituent pas des conseils juridiques. Bien que nous nous efforcions de fournir un contenu fidèle au texte disponible, aucune garantie n’est donnée quant à l’exactitude, l’exhaustivité ou l’actualité des informations.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pour toute interprétation officielle ou pour des conseils juridiques spécifiques, il est recommandé de consulter les autorités compétentes ou un professionnel du droit qualifié.',
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
