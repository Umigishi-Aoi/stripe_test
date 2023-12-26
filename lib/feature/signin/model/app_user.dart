import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stripe_test/constants/constants.dart';
import 'package:stripe_test/feature/core/model/role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required Role role,
    required String name,
    required String emailAddress,
    required String password,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, Object?> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromRole(Role role) => switch (role) {
        Role.customer => AppUser(
            role: role,
            name: customerName,
            emailAddress: customerEmailAddress,
            password: customerPassword,
          ),
        Role.owner => AppUser(
            role: role,
            name: ownerName,
            emailAddress: ownerEmailAddress,
            password: ownerPassword,
          )
      };
}
