library flutter_xauth_sdk;

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xauth_sdk/models/SocialConnection.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/asymmetric/api.dart';

import 'package:flutter_xauth_sdk/graphql/mutations/loginByPhoneCodeMutation.dart';
import 'package:flutter_xauth_sdk/graphql/mutations/loginByUsernameMutation.dart';
import 'package:flutter_xauth_sdk/graphql/mutations/refreshTokenMutation.dart';
import 'package:flutter_xauth_sdk/graphql/mutations/resetPasswordMutation.dart';

import 'package:flutter_xauth_sdk/mixins/xauth_error.dart';
import 'package:flutter_xauth_sdk/models/User.dart';
import 'package:graphql/client.dart' hide BaseOptions;

export 'models/User.dart';
export 'models/SocialConnection.dart';
export 'mixins/xauth_error.dart';

// part 'src/auth_provider.dart';
part 'xauth.dart';
part 'options.dart';