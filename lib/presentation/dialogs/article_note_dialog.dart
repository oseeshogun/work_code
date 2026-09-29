import 'package:codedutravail/data/repositories/article_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showArticleNoteDialog(
  BuildContext context, {
  required int articleNumber,
  required String? initialNote,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (BuildContext context) => _ArticleNoteDialog(articleNumber: articleNumber, initialNote: initialNote),
  );
}

class _ArticleNoteDialog extends HookConsumerWidget {
  final int articleNumber;
  final String? initialNote;

  const _ArticleNoteDialog({required this.articleNumber, required this.initialNote});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initialNote ?? '');
    final saving = useState(false);

    Future<void> save(String? note) async {
      saving.value = true;
      await ref.read(articleRepositoryProvider).updateNote(articleNumber, note);
      if (context.mounted) Navigator.of(context).pop();
    }

    final hasExistingNote = initialNote != null && initialNote!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ma note personnelle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 6,
              minLines: 3,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ajoutez une note personnelle sur cet article...',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (hasExistingNote)
                  TextButton(onPressed: saving.value ? null : () => save(null), child: const Text('Supprimer')),
                const Spacer(),
                FilledButton(
                  onPressed: saving.value ? null : () => save(controller.text),
                  child:
                      saving.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Enregistrer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
