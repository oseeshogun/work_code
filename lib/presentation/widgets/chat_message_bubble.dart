import 'package:codedutravail/core/router/routes.dart';
import 'package:codedutravail/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

/// Renders one chat message, Claude-style: the user's own messages stay in a
/// bubble, while AI responses render as a plain full-width block — no bubble
/// background — since they're often long, structured legal text.
class ChatMessageBubble extends StatefulWidget {
  final ChatMessageEntity message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: _buildContent(context)));
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.message.role == ChatRole.user) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            widget.message.content,
            style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontSize: 15),
          ),
        ),
      );
    }

    final isError = widget.message.isError;
    final textColor = isError ? theme.colorScheme.onErrorContainer : theme.colorScheme.onSurface;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: isError ? theme.colorScheme.errorContainer.withValues(alpha: 0.4) : Colors.transparent,
      child: _buildMarkdown(context, textColor),
    );
  }

  Widget _buildMarkdown(BuildContext context, Color textColor) {
    return MarkdownBlock(
      data: widget.message.content,
      config: MarkdownConfig(
        configs: [
          PConfig(textStyle: TextStyle(color: textColor, fontSize: 15)),
          LinkConfig(
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            onTap: (url) {
              final number = int.tryParse(url.replaceFirst('article://', ''));
              if (number != null) {
                ArticleRoute(number).push(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
