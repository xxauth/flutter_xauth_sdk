import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xauth_sdk/flutter_xauth_sdk.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginByPhoneScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _phone;
  String _code;
  var _phoneController = TextEditingController();
  var _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('手机号/验证码登录'),
        ),
        body: Builder(
            builder: (context) => _loginForm(context)
        )
    );
  }

  Widget _loginForm(BuildContext context) {
    var xauth = Provider.of<XAuth>(context);

    var form = Form(
      child: Column(
        children: [
          TextField(
            controller: _phoneController,
            style: TextStyle(fontSize: 20),
            textInputAction: TextInputAction.next,
            maxLength: 11,
            onChanged: (value) => _phone = value,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  _phoneController.clear();
                },
              ),
              labelText: '请输入11位手机号码',
            ),
          ),
          TextField(
            onChanged: (value) => _code = value,
            controller: _codeController,
            maxLength: 6,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                labelText: '请输入验证码',
                suffixIcon: FlatButton(
                    onPressed: () async {
                      try {
                        await xauth.sendSmsCode(phone: _phone);
                      } on XAuthException catch(e) {
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            e.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          backgroundColor: Color(0xFFF08752),
                          duration: Duration(seconds: 4),
                        ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xFFF354D),
                      ),
                      child: Center(
                        child: Text(
                          '获取验证码',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 80,
                    )
                )
            ),
          ),
          RaisedButton(
              child: Text('登录'),
              onPressed: () async {
                User user = await xauth.loginByPhoneCode(phone: _phone, code: _code);
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(user.username)));
              })
        ],
      ),
    );

    return ModalProgressHUD(child: form, inAsyncCall: false);
  }
}