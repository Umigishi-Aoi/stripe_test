// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      name: json['name'] as String,
      emailAdress: json['emailAdress'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'role': _$RoleEnumMap[instance.role],
      'name': instance.name,
      'emailAdress': instance.emailAdress,
      'password': instance.password,
    };

const _$RoleEnumMap = {
  Role.owner: 'owner',
  Role.customer: 'customer',
};
