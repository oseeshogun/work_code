import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutWorkCode extends HookConsumerWidget {
  const AboutWorkCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos du Code du Travail'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const Text(
              'LOI N° 015/2002 DU 16 OCTOBRE 2002 PORTANT CODE DU TRAVAIL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Fait à Kinshasa, le 16 octobre 2002'),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Promulgué le 09 août 1967, le Code du Travail de la République Démocratique du Congo tel que modifié et complété à ce jour, se trouve largement dépassé tant par rapport à l\'évolution économique et sociale du pays qu\'à sa conformité aux normes internationales du travail.\n'
              '  En considération de cette situation, des voix se sont levées de partout pour réclamer vivement son adaptation aux conditions nouvelles, particulièrement de la part du monde du travail dans son ensemble.\n'
              '  Une tentative de révision du Code est intervenue en 1986, lors de la 21ème session du Conseil National du Travail au cours de laquelle le Conseil avait adopté un projet de Code qui est demeuré lettre morte. Le Conseil National du Travail est, en effet, l\'organe consultatif tripartite placé auprès du gouvernement en matière du travail, emploi et prévoyance sociale.\n'
              '  La nécessité de disposer d\'une législation du travail adaptée, se faisant sentir avec acuité, une Commission préparatoire tripartite de la 29ème session du Conseil National du Travail avait été mise en place le 2 juin 2001.\n'
              '  Les travaux de cette Commission ont abouti entre autres à l\'adoption d\'un projet de code du travail en s\'inspirant notamment\n'
              '  - du projet de code révisé par le Conseil National du Travail en sa 21ème session précitée qu\'elle avait la charge d\'examiner ;\n'
              '  - des remarques et suggestions des organisations professionnelles d\'employeurs et de travailleurs ;\n'
              '  - des conventions et recommandations de l\'Organisation Internationale du Travail, O.I.T. en sigle ; et\n'
              '  - des us et coutumes du monde du travail.\n'
              '  Le texte du code élaboré par la Commission préparatoire avait été soumis au Conseil National du Travail en sa 29ème session tenue du 15 janvier au 12 février 2002.\n'
              '  Au cours de cette session, le Conseil National du Travail avait apporté des modifications et aménagements à certaines dispositions du Code du Travail.\n'
              '  \n'
              '  Parmi les innovations les plus importantes, il y a lieu de citer les dispositions ci-après :\n'
              '  - l\'élargissement du champ d\'application du Code du Travail aux petites et moyennes entreprises et petites et moyennes industries du secteur informel ainsi qu\'aux organisations sociales, culturelles, communautaires, philanthropiques utilisant des travailleurs salariés ;\n'
              '  - l\'interdiction des pires formes de travail des enfants et l\'action immédiate de leur élimination ;\n'
              '  - le relèvement de l\'âge d\'admission à l\'emploi qui est porté de 14 à 16 ans ; étant, toutefois, entendu qu\'une personne âgée de 15 ans ne peut être engagée ou maintenue en service que moyennant dérogation expresse de l\'Inspecteur du Travail et de l\'autorité parentale ou tutélaire ;\n'
              '  - le renforcement des mesures anti-discriminatoires à l\'égard des femmes et des personnes avec handicap ;\n'
              '  - l\'institution de l\'Office National de l\'Emploi avec un patrimoine propre, en remplacement du Service National de l\'Emploi qui n\'a pas donné satisfaction ;\n'
              '  - la réhabilitation des Tribunaux du Travail ;\n'
              '  - le renforcement des capacités institutionnelles en matière de formation et de\n'
              '  perfectionnement professionnels par la participation des organisations\n'
              '  professionnelles d\'employeurs et de travailleurs ;\n'
              '  - la mise en place des structures appropriées en matière de santé et de sécurité au\n'
              '  travail afin d\'assurer une protection optimale du travailleur contre les nuisances ;\n'
              '  - le renforcement des mesures coercitives.\n'
              '  Dans le souci d\'assurer la pleine application des dispositions du présent Code, le délai d\'un an est imparti pour la prise des mesures d\'exécution.\n'
              '  En attendant leur entrée en vigueur, la loi dispose que les institutions et procédures existant en application de la législation et de la réglementation actuelles et non contraires aux dispositions dudit Code restent d\'application.\n'
              '  Le présent Code du Travail mérite d\'être considéré comme un instrument capable d\'apporter la paix sociale grâce à l\'affermissement des relations professionnelles, au rétablissement des droits fondamentaux du travailleur et de l\'entrepreneur que sont le droit au travail et la liberté d\'entreprise.',
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
