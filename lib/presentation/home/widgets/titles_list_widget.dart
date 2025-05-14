import 'package:codedutravail/domain/entities/title.dart';
import 'package:flutter/material.dart';

class TitlesListWidget extends StatelessWidget {
  final List<TitleEntity> titles;

  const TitlesListWidget({
    super.key,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: titles.length,
      itemBuilder: (context, index) {
        final title = titles[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: Text(
              'Titre ${title.number}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              title.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            children: [
              if (title.articles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Articles: ${title.articles.length}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Navigate to title detail screen
                      // TODO: Implement navigation
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Voir les détails'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
