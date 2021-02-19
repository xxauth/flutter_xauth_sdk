import 'package:flutter/material.dart';
import 'package:flutter_xauth_sdk/flutter_xauth_sdk.dart';
import 'package:flutter_xauth_sdk_example/pages/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var xauth = XAuth(
      options: AuthenticationClientOptions(
          appId: '261ec84ac2e64522b25270380fd1e4d0',
          // userPoolId: '5c7aae5e-90da-4d13-8dcf-171907d20016',
      ),
    );

    return MultiProvider(
          providers: [
            Provider.value(value: xauth),
          ],
          child: MaterialApp(
            home: HomeScreen(),
          )
    );
  }
}
