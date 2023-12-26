import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stripe_test/constants/constants.dart';
import 'package:stripe_test/feature/core/provider/firebase_auth_provider.dart';
import 'package:stripe_test/feature/signin/error/custom_firebase_auth_exceptions.dart';
import 'package:stripe_test/feature/signin/provider/user_function_call_provider.dart';

import '../../core/model/role.dart';
import '../model/app_user.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthedUser extends _$AuthedUser {
  @override
  User? build() {
    return ref.watch(firebaseAuthProvider).currentUser;
  }

  Future<String> signIn({
    required Role role,
  }) async {
    final user = AppUser.fromRole(role);

    try {
      await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
            email: user.emailAddress,
            password: user.password,
          );
    } on CustomFirebaseAuthExceptions catch (e) {
      return e.message;
    }

    final result =
        await ref.read(userFunctionCallProvider.notifier).setUserInfo(role);

    if (result != ok) {
      await signOut();
      return result;
    }

    state = ref.read(firebaseAuthProvider).currentUser;
    return result;
  }

  Future<String> signOut() async {
    try {
      await ref.read(firebaseAuthProvider).signOut();
    } on CustomFirebaseAuthExceptions catch (e) {
      return e.message;
    }
    state = ref.read(firebaseAuthProvider).currentUser;
    return ok;
  }
}
