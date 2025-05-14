import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:codedutravail/domain/usecases/register_data_offline.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TitlesEmptyWidget extends HookConsumerWidget {
  const TitlesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svgs/undraw_legal-counsel_kdnh.svg', height: 200, width: 200),
            const SizedBox(height: 24.0),
            Text(
              'Nemo jus ignorare censetur ou Ignorantia juris non excusat ⚖️',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              height: 56.0,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withBlue((Theme.of(context).primaryColor.blue + 40).clamp(0, 255)),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28.0),
                  onTap: loading.value
                      ? null
                      : () {
                          // Load data using the register data offline use case
                          loading.value = true;
                          ref.read(registerDataOfflineProvider).call().then((value) {
                            loading.value = false;
                            value.fold(
                              (l) => showOkAlertDialog(context: context, message: l.message),
                              (_) {},
                            );
                          });
                        },
                  child: Center(
                    child: loading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Commencer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
