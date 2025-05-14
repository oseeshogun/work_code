import 'package:codedutravail/domain/home/providers/read_disclaimer.dart';
import 'package:codedutravail/presentation/home/dialogs/disclaimer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReadDisclaimer = ref.watch(readDisclaimerProvider).value;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (hasReadDisclaimer is bool && !hasReadDisclaimer) {
          showDisclaimerDialog(context);
        }
      });
      return null;
    }, [hasReadDisclaimer]);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/drc_law.png', height: 30.0),
        title: Text('Code du Travail', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: go to search
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // TODO: go to info
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SizedBox(),
    );
  }
}
