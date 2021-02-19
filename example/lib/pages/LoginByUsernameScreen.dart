import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xauth_sdk/flutter_xauth_sdk.dart';

class LoginByUsernameScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController loginUsernameController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  String _username;
  String _password;
  String _captchaCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('用户名/密码登录'),
        ),
        body: Form(
          child: Card(
              child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 8.0, left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: loginUsernameController,
                        onChanged: (value){
                          _username = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "用户名",
                          hintStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black54
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: loginPasswordController,
                          onChanged: (value){
                            _password = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "密码",
                            hintStyle: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black54
                            ),
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          onChanged: (value){
                            _captchaCode = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "验证码",
                            hintStyle: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black54
                            ),
                          ),
                        )
                    ),
                    RaisedButton(
                        child: Text('登录'),
                        onPressed: () async {
                          try {
                            var user = await Provider.of<XAuth>(context)?.loginByUsername(username: _username, password: _password, captchaCode: _captchaCode);
                          } catch (e) {
                            if (e is XAuthException) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              _scaffoldKey.currentState?.removeCurrentSnackBar();
                              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                content: new Text(
                                  e.message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                backgroundColor: Color(0xFF008752),
                                duration: Duration(seconds: 4),
                              ));
                            }
                          }
                        }
                    )
                  ]
              )
          )
      )
    );
  }
}