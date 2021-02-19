
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xauth_sdk/flutter_xauth_sdk.dart';
import 'package:flutter_xauth_sdk_example/pages/LoginByPhoneScreen.dart';
import 'package:flutter_xauth_sdk_example/pages/LoginByUsernameScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('xauth示例'),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: RaisedButton(
                child: Text('用户名/密码登录'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginByUsernameScreen()));
                },
              )
          ),
          Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: RaisedButton(
                child: Text('手机号登录'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginByPhoneScreen()));
                },
              )
          ),
          Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: RaisedButton(
                child: Text('微信登录'),
                onPressed: () async {
                  User user = await Provider.of<XAuth>(context).loginByWechat(scope: null, state: null);

                },
              )
          )
        ],
      ),
    );
  }
}