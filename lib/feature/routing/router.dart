import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stripe_test/constants/constants.dart';
import 'package:stripe_test/feature/core/model/role.dart';
import 'package:stripe_test/feature/signin/presentation/sign_in_page.dart';
import 'package:stripe_test/feature/signin/provider/auth_provider.dart';
import 'package:stripe_test/feature/signin/provider/user_role_provider.dart';

import '../core/presentation/customer_page.dart';
import '../core/presentation/owner_page.dart';

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
      if (signedIn && signingIn) {
        return switch (ref.watch(userRoleProvider)) {
          Role.customer => const CustomerRoute().location,
          Role.owner => const OwnerRoute().location,
          null => const SignInRoute().location
        };
      }
      return null;
    },
  );
}

@TypedGoRoute<SignInRoute>(
  path: '/',
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<CustomerRoute>(
  path: '/$customerName',
)
class CustomerRoute extends GoRouteData {
  const CustomerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CustomerPage();
}

@TypedGoRoute<OwnerRoute>(
  path: '/$ownerName',
)
class OwnerRoute extends GoRouteData {
  const OwnerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OwnerPage();
}
