import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stripe_test/feature/core/model/role.dart';

part 'user_role_provider.g.dart';

@riverpod
class UserRole extends _$UserRole {
  @override
  Role? build() {
    return null;
  }

  @override
  set state(Role? value) {
    super.state = value;
  }
}
