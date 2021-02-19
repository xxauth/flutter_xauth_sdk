
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String id;
  String arn;
  String userPoolId;
  String username;
  String email;
  bool emailVerified;
  String phone;
  bool phoneVerified;
  String unionid;
  String openid;

  User({
    this.id,
    this.arn,
    this.userPoolId,
    this.username,
    this.email,
    this.emailVerified,
    this.phone,
    this.phoneVerified,
    this.unionid,
    this.openid,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}