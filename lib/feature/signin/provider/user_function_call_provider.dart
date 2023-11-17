import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stripe_test/feature/core/provider/firebase_functions_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constants.dart';
import '../../core/model/role.dart';

part 'user_function_call_provider.g.dart';

@riverpod
class UserFunctionCall extends _$UserFunctionCall {
  @override
  void build() {
    return;
  }

  Future<String> setUserInfo(Role role) async {
    final functions = ref.watch(firebaseFunctionsProvider);

    final String functionName;

    functionName = switch (role) {
      Role.owner => 'createOwner',
      Role.customer => 'createCustomer',
    };

    final userName = switch (role) {
      Role.owner => ownerName,
      Role.customer => customerName,
    };
    const uuid = Uuid();
    try {
      final result = await functions
          .httpsCallable(functionName)
          .call<Map<String, dynamic>>({
        'userName': userName,
        'idempotencyKey': uuid.v4(),
      });

      if (result.data[statusCode] != 200) {
        return '${result.data[statusCode]}:${result.data[errorCode]}';
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return ok;
  }
}
