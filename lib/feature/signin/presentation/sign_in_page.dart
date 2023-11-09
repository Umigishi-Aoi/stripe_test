import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stripe_test/constants/constants.dart';
import 'package:stripe_test/feature/signin/provider/auth_provider.dart';

import '../../core/model/role.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authedUserProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Choose the role'),
            for (final Role role in Role.values)
              ElevatedButton(
                onPressed: () async {
                  final result = await notifier.signIn(role: role);

                  if (!context.mounted) {
                    return;
                  }

                  if (result != ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result),
                      ),
                    );
                  }
                },
                child: Text(role.name),
              ),
          ],
        ),
      ),
    );
  }
}
