part of flutter_xauth_sdk;

class XAuth {
  final String appId;
  final String host;

  XAuth({
    this.appId,
    this.host,
  });

  Future<User> loginByMobile({
    @required String mobile,
    @required String code,
  }) async {
    return Future.value(null);
  }
}