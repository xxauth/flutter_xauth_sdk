part of flutter_xauth_sdk;

const SDK_VERSION = '1.0.0';

const encrptionPublicKey = '''-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXF2kRW8oaTPA7KZqqsAuDmmhh
fa1IbxjK3zincLjV5ICJBacxTrKM6T8w/7zTgO/dRin2fACO5d65eOE1R65L2Syt
FWjSMefU8E36cHaykoi0o79qSxlpN7UPnRR1n60kRqlcM0IZ9XOlFszK05aLOrVh
Hdspg836OaW98JYl0QIDAQAB
-----END PUBLIC KEY-----''';


class XAuth with XAuthError {
  String _token;
  AuthenticationClientOptions _options;

  GraphQLClient _graphQLClientV1;
  GraphQLClient _graphQLClientV2;

  Dio _dio;

  XAuth({
    @required options,
  }) {
    _options = options;
    createClient();
  }

  static String encrypt(String s) {
    final RSAPublicKey publicKey = RSAKeyParser().parse(encrptionPublicKey);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(s).base64;
  }


  Future<User> loginByUsername({
    @required String username,
    @required String password,
    @required String captchaCode,
    bool autoRegister = false,
  }) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(loginByUsernameMutation),
        variables: {
          'username': username,
          'password': password,
          'captchaCode': captchaCode,
          'autoRegister': autoRegister,
        });
    var result = await _graphQLClientV2.mutate(_options);
    checkForError(result);
    var user = User.fromJson(result.data['user']);
    return user;
  }

  Future<User> loginByPhoneCode({
    @required String phone,
    @required String code,
  }) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(loginByPhoneCodeMutation),
        variables: {
          'input': {
            'phone': phone,
            'code': code,
          }
        });
    var result = await _graphQLClientV2.mutate(_options);
    checkForError(result);
    var user = User.fromJson(result.data['loginByPhoneCode']);
    return user;
  }

  Future<void> sendSmsCode({
    @required String phone,
  }) async {
    try {
      var response = await _dio.post(
          "/api/v2/sms/send",
          data: {
            "phone": phone
          }
      );
    } on DioError catch(e) {
      var data = e.response.data??{};
      throw XAuthException(data['message']);
    }
  }

  createClient() {
    final AuthLink _authLink = AuthLink(
      getToken: () => "Bearer ${_token}",
    );

    var defaultHeaders = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'x-authing-sdk-version': SDK_VERSION,
      'x-authing-userpool-id': _options.userPoolId??'',
      'x-authing-app-id': _options.appId??'',
    };

    final Link _httpLink1 = HttpLink(
        headers: defaultHeaders,
        uri: "${_options.host}/v1/graphql"
    );

    _graphQLClientV1 = GraphQLClient(
      link: _authLink.concat(_httpLink1),
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    );

    final Link _httpLink2 = HttpLink(
        headers: defaultHeaders,
        uri: "${_options.host}/v2/graphql"
    );

    _graphQLClientV2 = GraphQLClient(
      link: _authLink.concat(_httpLink2),
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    );

    _dio = Dio(BaseOptions(
      baseUrl: _options.host,
      headers: defaultHeaders,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));
  }


  Future<QueryResult> refreshToken({
    String client,
    String user
  }) async {
    var result = await _graphQLClientV2.mutate(MutationOptions(
        documentNode: gql(refreshTokenMutation),
        variables: <String, dynamic> {
          'user': user,
          'client': client
        }
    ));
    checkForError(result);
    var r = result.data['refreshToken'];
    return r;
  }

  Future<QueryResult> resetPassword({
    String phone,
    String email,
    String code,
    String newPassword,
  }) async {
    var result =  await _graphQLClientV2.mutate(MutationOptions(
        document: resetPasswordMutation,
        variables: <String, dynamic> {
          'phone': phone,
          'email': email,
          'code': code,
          'newPassword': encrypt(newPassword),
        }
    ));
  }

  bool _wxRegistered = false;
  MethodChannel _wechatChannel = MethodChannel('plugins.duolacloud/xwechat');

  Future<User> loginByPlatform(SocialConnection conn) async {
    // 先从云端取得 wechatAppId
    var appId = 'aaaaa';

    // 没有注册就注册
    if (!_wxRegistered) {
      await _wechatChannel.invokeMethod("registerApp", {
        "appId": appId,
        "iOS": true,
        "android": true,
      });

      _wxRegistered = true;
    }

    var result = await _wechatChannel.invokeMethod("sendAuth", {
      "scope": 'snsapi_userinfo',
      "state": 'wechat_sdk_demo_test',
    });

    print(result);

    return null;
  }
}