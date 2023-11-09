import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stripe_test/feature/signin/presentation/sign_in_page.dart';
import 'package:stripe_test/feature/signin/provider/auth_provider.dart';

import '../../core/presentation/home_page.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authedUserProvider);

    if (user == null) {
      return const SignInPage();
    }
    return const HomePage();
  }
}
