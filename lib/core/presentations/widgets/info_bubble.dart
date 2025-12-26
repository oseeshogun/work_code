import 'package:flutter/material.dart';

class InfoBubble extends StatelessWidget {
  const InfoBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: switch (Theme.of(context).brightness) {
            Brightness.dark => Colors.grey.shade800,
            Brightness.light => Colors.grey.shade100,
          },
          borderRadius: BorderRadius.circular(12.0),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: switch (Theme.of(context).brightness) {
            Brightness.dark => Colors.grey.shade300,
            Brightness.light => Colors.grey.shade700,
          }),
        ),
      ),
    );
  }
}
