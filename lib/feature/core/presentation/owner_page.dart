import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stripe_test/feature/signin/provider/auth_provider.dart';

class OwnerPage extends ConsumerWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authedUserProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await notifier.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('You are the owner'),
            Text(ref.watch(authedUserProvider)!.uid),
          ],
        ),
      ),
    );
  }
}
