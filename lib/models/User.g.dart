// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(id: json['id'] as String)
    ..arn = json['arn'] as String
    ..userPoolId = json['userPoolId'] as String
    ..username = json['username'] as String
    ..email = json['email'] as String
    ..emailVerified = json['emailVerified'] as bool
    ..phone = json['phone'] as String
    ..phoneVerified = json['phoneVerified'] as bool
    ..unionid = json['unionid'] as String
    ..openid = json['openid'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'arn': instance.arn,
      'userPoolId': instance.userPoolId,
      'username': instance.username,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'phone': instance.phone,
      'phoneVerified': instance.phoneVerified,
      'unionid': instance.unionid,
      'openid': instance.openid
    };
