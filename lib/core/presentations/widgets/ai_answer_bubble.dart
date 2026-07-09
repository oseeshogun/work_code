import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AiAnswerBubble extends StatelessWidget {
  const AiAnswerBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: switch (Theme.of(context).brightness) {
            Brightness.dark => Colors.grey.shade800,
            Brightness.light => Colors.grey.shade200,
          },
          borderRadius: BorderRadius.circular(12.0),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: MarkdownBody(
          data: text,
          selectable: true,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodyMedium,
            h1: Theme.of(context).textTheme.titleLarge,
            h2: Theme.of(context).textTheme.titleMedium,
            h3: Theme.of(context).textTheme.titleSmall,
            code: TextStyle(
              backgroundColor: switch (Theme.of(context).brightness) {
                Brightness.dark => Colors.grey.shade700,
                Brightness.light => Colors.grey.shade300,
              },
              fontFamily: 'monospace',
              fontSize: 14,
            ),
            codeblockDecoration: BoxDecoration(
              color: switch (Theme.of(context).brightness) {
                Brightness.dark => Colors.grey.shade700,
                Brightness.light => Colors.grey.shade300,
              },
              borderRadius: BorderRadius.circular(4),
            ),
            blockquote: TextStyle(
              color: switch (Theme.of(context).brightness) {
                Brightness.dark => Colors.grey.shade300,
                Brightness.light => Colors.grey.shade700,
              },
              fontStyle: FontStyle.italic,
            ),
            blockquoteDecoration: BoxDecoration(
              color: switch (Theme.of(context).brightness) {
                Brightness.dark => Colors.grey.shade900,
                Brightness.light => Colors.grey.shade100,
              },
              borderRadius: BorderRadius.circular(4),
              border: Border(
                left: BorderSide(
                  color: switch (Theme.of(context).brightness) {
                    Brightness.dark => Colors.blue.shade700,
                    Brightness.light => Colors.blue.shade300,
                  },
                  width: 4,
                ),
              ),
            ),
            blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
          ),
        ),
      ),
    );
  }
}