import 'package:codedutravail/presentation/widgets/animated_gradient_border_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiAgentScreen extends HookConsumerWidget {
  const AiAgentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);

    useEffect(() {
      void onFocusChange() {
        isFocused.value = focusNode.hasFocus;
      }

      focusNode.addListener(onFocusChange);
      return () => focusNode.removeListener(onFocusChange);
    }, [focusNode]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Assistant Code du travail', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/Android-pana.svg', height: 150.0),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Bienvenue dans l\'assistant IA du Code du Travail !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Cet agent est un outil d\'assistance à la recherche et à la consultation du Code du travail. '
                    'Il ne fournit pas de conseil juridique et ne se substitue pas à un professionnel du droit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            AnimatedGradientBorderTextField(
              controller: textController,
              isFocused: isFocused.value,
              focusNode: focusNode,
              minLines: 2,
              maxLines: 6,
              hintText: 'Posez votre question sur le Code du travail...',
              labelText: 'Votre question',
              onSubmit: (value) {
                // Handle question submission
              },
            ),
            const SizedBox(height: 4.0),
            Text(
              "Les réponses fournies par l'assistant IA sont générées et peuvent ne pas être exactes ou complètes. ",
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
