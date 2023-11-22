import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stripe_test/feature/core/presentation/home_page.dart';
import 'package:stripe_test/feature/signin/presentation/sign_in_page.dart';
import 'package:stripe_test/feature/signin/provider/auth_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: $appRoutes,
    redirect: (context, state) {
      final signedIn = ref.watch(authedUserProvider) != null;
      final signingIn = state.matchedLocation == const SignInRoute().location;
      if (!signedIn && !signingIn) {
        return const SignInRoute().location;
      }
      if (signedIn && signingIn) return const HomeRoute().location;
      return null;
    },
  );
}

@TypedGoRoute<SignInRoute>(
  path: '/sign-in',
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
