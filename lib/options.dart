part of flutter_xauth_sdk;

class AuthenticationClientOptions {
  final String host;
  String appId;
  String userPoolId;
  String requestFrom;

  AuthenticationClientOptions({
    this.host = 'https://core.xauth.lucfish.com',
    this.userPoolId,
    this.appId,
    this.requestFrom,
  });

}
