import 'package:flutter/material.dart';

class QuestionBubble extends StatelessWidget {
  const QuestionBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: switch (Theme.of(context).brightness) {
            Brightness.dark => Colors.blue.shade800,
            Brightness.light => Colors.blue.shade100,
          },
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(text),
      ),
    );
  }
}