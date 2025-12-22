import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedGradientBorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;
  final int minLines;
  final int maxLines;
  final String hintText;
  final String labelText;
  final Function(String) onSubmit;
  final bool thinking;

  const AnimatedGradientBorderTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isFocused,
    this.minLines = 1,
    this.maxLines = 1,
    required this.hintText,
    required this.labelText,
    required this.onSubmit,
    this.thinking = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isFocused
            ? const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        border: Border.all(
          color: isFocused
              ? Colors.transparent
              : Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              TextField(
                controller: controller,
                focusNode: focusNode,
                minLines: minLines,
                maxLines: maxLines,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 48, 16), // Add right padding for the button
                  border: InputBorder.none,
                  labelText: labelText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: false,
                  labelStyle: TextStyle(
                    color: isFocused ? Theme.of(context).colorScheme.primary : Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onSubmitted: onSubmit,
              ),
              if (!thinking)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // Handle submit action
                        if (controller.text.trim().isNotEmpty) {
                          onSubmit(controller.text);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: isFocused
                              ? const LinearGradient(
                                  colors: [Colors.blue, Colors.purple, Colors.red],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          color: isFocused
                              ? null
                              : Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Transform.rotate(
                          angle: -math.pi / 6, // Negative pi/4 (-45 degrees)
                          child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
